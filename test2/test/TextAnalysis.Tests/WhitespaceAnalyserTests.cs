using TextAnalysis;
using NUnit.Framework;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace TextAnalysis.Test
{
    [TestFixture]
    public class WhitespaceAnalyserTests
    {
        public interface IConsole
        {
            void WriteLine(string line);
        }

        public class DummyConsole : IConsole
        {
            public List<string> Output = new List<string>();

            public void WriteLine(string line)
            {
                Output.Add(line);
            }
        }

        public class WhitespaceAnalyser
        {
            private SortedDictionary<char, int> dictionaryOfCharacters = new SortedDictionary<char, int>();

            public void AnalyseString(IConsole console, string stringToAnalyse)
            {
                var nonWhitespaceCharactersRegex = new Regex(@"\s");
                var charactersToInclude = nonWhitespaceCharactersRegex.Replace(stringToAnalyse,string.Empty);
            
                foreach (char character in charactersToInclude)
                {
                    IncrementCharacterCount(character);
                }			
                
                foreach (var character in dictionaryOfCharacters)
                {
                    console.WriteLine(string.Format("{0} {1}", character.Key, dictionaryOfCharacters[character.Key]));
                }
            }
            
            public void IncrementCharacterCount(char character)
            {
                if (!dictionaryOfCharacters.ContainsKey(character))
                {
                    dictionaryOfCharacters.Add(character, 0);
                }	
                        
                dictionaryOfCharacters[character] = dictionaryOfCharacters[character] + 1;		
            }
        }

        [Test]
        public void Test_this_string(){
            var analyser = new WhitespaceAnalyser();
            var console = new DummyConsole();
            analyser.AnalyseString(console, "this");

            Assert.That(console.Output, Is.EquivalentTo(new List<string>() { "h 1","i 1","s 1","t 1" }));
        }

        [Test]
        public void Test_string_including_non_whitespace_characters(){
            var analyser = new WhitespaceAnalyser();
            var console = new DummyConsole();
            analyser.AnalyseString(console, "this 1 2 !!");

            Assert.That(console.Output, Is.EquivalentTo(new List<string>() { "! 2", "1 1", "2 1", "h 1","i 1","s 1","t 1" }));
        }
    }
}