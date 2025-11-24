using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    public class DatabaseHelper
    {
        private readonly string _connectionString =
            "Server=localhost;Database=Veterinariafinal1;User Id=sa;Password=contrasena123;TrustServerCertificate=True;";

        public DataTable ExecuteQuery(string query)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                using (var cmd = new SqlCommand(query, conn))
                {
                    var dt = new DataTable();
                    using (var reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                    return dt;
                }
            }
        }

        public DataTable EjecutarProcedimiento(string nombreProcedimiento, SqlParameter[] parametros = null)
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand(nombreProcedimiento, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                if (parametros != null)
                {
                    cmd.Parameters.AddRange(parametros);
                }

                conn.Open();
                var dt = new DataTable();
                using (var reader = cmd.ExecuteReader())
                {
                    dt.Load(reader);
                }
                return dt;
            }
        }

        public void EjecutarProcedimientoSinResultado(string nombreProcedimiento, SqlParameter[] parametros)
        {
            using (var conn = new SqlConnection(_connectionString))
            using (var cmd = new SqlCommand(nombreProcedimiento, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddRange(parametros);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void RegistrarAnimalRescatado(string especie, string raza, string color, DateTime fechaNacimiento,
            string alias, string familiaNo, string rescatistaId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            using (SqlCommand command = new SqlCommand("RegistrarAnimalRescatado", connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Especie", especie);
                command.Parameters.AddWithValue("@Raza", raza);
                command.Parameters.AddWithValue("@Color", color);
                command.Parameters.AddWithValue("@FechaNacimiento", fechaNacimiento);
                command.Parameters.AddWithValue("@Alias", alias);
                command.Parameters.AddWithValue("@FamiliaNo", familiaNo);
                command.Parameters.AddWithValue("@RescatistaId", rescatistaId);

                SqlParameter mascotaNoOut = new SqlParameter("@MascotaNo", SqlDbType.Char, 10)
                {
                    Direction = ParameterDirection.Output
                };
                command.Parameters.Add(mascotaNoOut);

                connection.Open();
                command.ExecuteNonQuery();

                string nuevoMascotaNo = mascotaNoOut.Value.ToString();
                MessageBox.Show($"Mascota registrada con ID: {nuevoMascotaNo}");
            }
        }
    }
}
