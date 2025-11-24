using System;
using System.Data;
using System.Windows.Forms;
using Microsoft.Data.SqlClient;

namespace VeterinariaFinalFinal
{
    public class RegistrarAdopcionForm : Form
    {
        private TextBox txtMascotaNo, txtPostulanteId;
        private DateTimePicker dtpFecha;
        private Button btnRegistrar;
        private DataGridView dgvGastos;

        public RegistrarAdopcionForm()
        {
            this.Text = "Registrar Adopción + Gastos";
            this.Size = new System.Drawing.Size(750, 600);
            this.StartPosition = FormStartPosition.CenterScreen;

            int top = 20;
            txtMascotaNo = AddLabeledTextBox("Mascota No", ref top);
            txtPostulanteId = AddLabeledTextBox("Postulante ID", ref top);

            dtpFecha = new DateTimePicker { Top = top, Left = 150, Width = 200 };
            Controls.Add(new Label { Text = "Fecha", Top = top, Left = 20, Width = 120 });
            Controls.Add(dtpFecha);
            top += 40;

            btnRegistrar = new Button
            {
                Text = "Registrar Adopción",
                Top = top,
                Left = 150,
                Width = 200
            };
            btnRegistrar.Click += BtnRegistrar_Click;
            Controls.Add(btnRegistrar);
            top += 50;

            dgvGastos = new DataGridView
            {
                Top = top,
                Left = 20,
                Width = 690,
                Height = 300,
                ReadOnly = true,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
            };
            Controls.Add(dgvGastos);
        }

        private TextBox AddLabeledTextBox(string label, ref int top)
        {
            var lbl = new Label { Text = label, Top = top, Left = 20, Width = 120 };
            var txt = new TextBox { Top = top, Left = 150, Width = 200 };
            Controls.Add(lbl);
            Controls.Add(txt);
            top += 40;
            return txt;
        }

        private void BtnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                var db = new DatabaseHelper();
                var parametros = new[]
                {
                    new SqlParameter("@MascotaNo", txtMascotaNo.Text),
                    new SqlParameter("@PostulanteId", txtPostulanteId.Text),
                    new SqlParameter("@Fecha", dtpFecha.Value)
                };

                // Ejecutamos el SP y mostramos los gastos relacionados
                var dt = db.EjecutarProcedimiento("RegistrarAdopcionYCuentaGastos", parametros);
                dgvGastos.DataSource = dt;

                MessageBox.Show("Adopción registrada y gastos mostrados.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
    }
}
