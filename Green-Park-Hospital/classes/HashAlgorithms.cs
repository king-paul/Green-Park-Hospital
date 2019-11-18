using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Text;
using System.Security.Cryptography;

namespace Assignment2
{
    public class HashAlgorithms
    {
        public static string GetSHA1Hash(string input)
        {
            HashAlgorithm algorithm = SHA1.Create();  // SHA1.Create()
            byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            byte[] hash = algorithm.ComputeHash(inputBytes);

            StringBuilder sb = new StringBuilder();
            foreach (byte b in algorithm.ComputeHash(inputBytes))
                sb.Append(b.ToString("X2"));

            return sb.ToString().ToLower();
        }

        public static string GetMD5Hash(string input)
        {
            // step 1, calculate MD5 hash from input
            MD5 md5 = MD5.Create();
            byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString();
        }
    }
}