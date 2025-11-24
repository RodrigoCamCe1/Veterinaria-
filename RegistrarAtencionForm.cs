using System;
using System.Windows.Forms;
using Microsoft.Data.SqlClient;

namespace VeterinariaFinalFinal
{
    public class RegistrarAtencionForm : Form
    {
        private TextBox txtMascotaNo, txtEnfermedad, txtVetID;
        private CheckBox chkRescatado;
        private DateTimePicker dtpFecha;
        private Button btnRegistrar;

        public RegistrarAtencionForm()
        {
            this.Text = "Registrar Atención Médica";
            this.Size = new System.Drawing.Size(450, 350);
            this.StartPosition = FormStartPosition.CenterScreen;

            int top = 20;

            txtMascotaNo = AddLabeledTextBox("Mascota No", ref top);
            dtpFecha = new DateTimePicker { Top = top, Left = 150, Width = 200 };
            Controls.Add(new Label { Text = "Fecha", Top = top, Left = 20, Width = 120 });
            Controls.Add(dtpFecha);
            top += 40;

            txtEnfermedad = AddLabeledTextBox("Enfermedad", ref top);
            txtVetID = AddLabeledTextBox("Veterinario ID", ref top);

            chkRescatado = new CheckBox
            {
                Text = "¿Fue rescatado?",
                Top = top,
                Left = 150,
                Width = 200
            };
            Controls.Add(chkRescatado);
            top += 40;

            btnRegistrar = new Button
            {
                Text = "Registrar",
                Top = top,
                Left = 150,
                Width = 120
            };
            btnRegistrar.Click += BtnRegistrar_Click;
            Controls.Add(btnRegistrar);
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
                    new SqlParameter("@Fecha", dtpFecha.Value),
                    new SqlParameter("@Enfermedad", txtEnfermedad.Text),
                    new SqlParameter("@Rescatado", chkRescatado.Checked ? 1 : 0),
                    new SqlParameter("@VetID", txtVetID.Text)
                };

                db.EjecutarProcedimientoSinResultado("RegistrarAtencion", parametros);
                MessageBox.Show("Atención médica registrada correctamente.");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar atención: " + ex.Message);
            }
        }
    }
}
