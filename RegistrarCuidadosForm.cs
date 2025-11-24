using System;
using System.Data;
using Microsoft.Data.SqlClient; 
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    public partial class RegistrarCuidadoForm : Form
    {
        private TextBox txtMascotaNo, txtTipo, txtPrecio, txtComentarios, txtVoluntarioId, txtVetID;
        private DateTimePicker dtpFecha;
        private Button btnRegistrar;

        public RegistrarCuidadoForm()
        {
            this.Text = "Registrar Cuidado";
            this.Size = new System.Drawing.Size(450, 400);
            this.StartPosition = FormStartPosition.CenterScreen;

            int top = 20;
            txtMascotaNo = AddLabeledTextBox("Mascota No", ref top);
            dtpFecha = new DateTimePicker { Top = top, Left = 150, Width = 200 };
            Controls.Add(new Label { Text = "Fecha", Top = top, Left = 20, Width = 120 });
            Controls.Add(dtpFecha);
            top += 40;
            txtTipo = AddLabeledTextBox("Tipo", ref top);
            txtPrecio = AddLabeledTextBox("Precio", ref top);
            txtComentarios = AddLabeledTextBox("Comentarios", ref top);
            txtVoluntarioId = AddLabeledTextBox("Voluntario ID", ref top);
            txtVetID = AddLabeledTextBox("Veterinario ID", ref top);

            btnRegistrar = new Button
            {
                Text = "Registrar",
                Top = top + 20,
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
                    new SqlParameter("@Tipo", txtTipo.Text),
                    new SqlParameter("@Precio", decimal.Parse(txtPrecio.Text)),
                    new SqlParameter("@Comentarios", txtComentarios.Text),
                    new SqlParameter("@VoluntarioId", txtVoluntarioId.Text),
                    new SqlParameter("@VetID", txtVetID.Text)
                };

                db.EjecutarProcedimientoSinResultado("RegistrarCuidado", parametros);
                MessageBox.Show("Cuidado registrado correctamente.");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar cuidado: " + ex.Message);
            }
        }
    }
}
