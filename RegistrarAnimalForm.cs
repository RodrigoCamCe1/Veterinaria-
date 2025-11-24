using System;
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    public class RegistrarAnimalForm : Form
    {
        private TextBox txtEspecie, txtRaza, txtColor, txtAlias, txtFamiliaNo, txtRescatistaId;
        private DateTimePicker dtpFechaNacimiento;
        private Button btnRegistrar;

        public RegistrarAnimalForm()
        {
            this.Text = "Registrar Animal Rescatado";
            this.Size = new System.Drawing.Size(400, 400);
            this.StartPosition = FormStartPosition.CenterScreen;

            var lbls = new[] { "Especie", "Raza", "Color", "Fecha Nacimiento", "Alias", "Familia No", "Rescatista ID" };
            var top = 20;

            txtEspecie = CreateTextBox("txtEspecie", top += 30);
            txtRaza = CreateTextBox("txtRaza", top += 30);
            txtColor = CreateTextBox("txtColor", top += 30);

            var lblFecha = new Label { Text = "Fecha Nacimiento", Top = top += 30, Left = 20, Width = 120 };
            Controls.Add(lblFecha);
            dtpFechaNacimiento = new DateTimePicker { Top = top, Left = 150, Width = 200 };
            Controls.Add(dtpFechaNacimiento);

            txtAlias = CreateTextBox("txtAlias", top += 40);
            txtFamiliaNo = CreateTextBox("txtFamiliaNo", top += 30);
            txtRescatistaId = CreateTextBox("txtRescatistaId", top += 30);

            btnRegistrar = new Button
            {
                Text = "Registrar",
                Top = top += 40,
                Left = 150,
                Width = 100
            };
            btnRegistrar.Click += BtnRegistrar_Click;
            Controls.Add(btnRegistrar);
        }

        private TextBox CreateTextBox(string name, int top)
        {
            var lbl = new Label { Text = name.Replace("txt", ""), Top = top, Left = 20, Width = 120 };
            var txt = new TextBox { Name = name, Top = top, Left = 150, Width = 200 };
            Controls.Add(lbl);
            Controls.Add(txt);
            return txt;
        }

        private void BtnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                var db = new DatabaseHelper();
                db.RegistrarAnimalRescatado(
                    txtEspecie.Text,
                    txtRaza.Text,
                    txtColor.Text,
                    dtpFechaNacimiento.Value,
                    txtAlias.Text,
                    txtFamiliaNo.Text,
                    txtRescatistaId.Text
                );
                MessageBox.Show("Animal rescatado registrado correctamente.");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }
    }
}
