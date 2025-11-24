using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.Windows.Forms;

namespace VeterinariaFinalFinal
{
    public class MainForm : Form
    {
        private DataGridView dataGridView;
        private Button btnCargar;
        private ComboBox cmbReportes;

        public MainForm()
        {
            this.Text = "Sistema Veterinario";
            this.WindowState = FormWindowState.Maximized;
            this.Font = new System.Drawing.Font("Segoe UI", 10);

            CreateControls();
            LoadData();
        }

        private void CreateControls()
        {
            cmbReportes = new ComboBox
            {
                Dock = DockStyle.Top,
                DropDownStyle = ComboBoxStyle.DropDownList
            };
            cmbReportes.Items.AddRange(new object[] {
                "Mascotas",
                "Mascotas Rescatadas",
                "Gastos",
                "Resumen Financiero",
                "Reporte de Compatibilidad"
            });
            cmbReportes.SelectedIndex = 0;

            btnCargar = new Button
            {
                Text = "Cargar Reporte",
                Dock = DockStyle.Top,
                Height = 40
            };
            btnCargar.Click += BtnCargar_Click;

            dataGridView = new DataGridView
            {
                Dock = DockStyle.Fill,
                AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill,
                ReadOnly = true,
                AllowUserToAddRows = false
            };

            this.Controls.Add(dataGridView);
            this.Controls.Add(btnCargar);
            this.Controls.Add(cmbReportes);
        }

        private void BtnCargar_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void LoadData()
        {
            try
            {
                var dbHelper = new DatabaseHelper();
                string query = "";

                switch (cmbReportes.SelectedItem.ToString())
                {
                    case "Mascotas":
                        query = "SELECT * FROM Mascota ORDER BY Especie, Alias";
                        break;
                    case "Mascotas Rescatadas":
                        query = "SELECT m.* FROM Mascota m JOIN Rescatada r ON m.MascotaNo = r.MascotaNo";
                        break;
                    case "Gastos":
                        query = @"
                            SELECT c.MascotaNo, m.Alias, c.Fecha, c.Tipo, c.Precio, v.Nombre AS Veterinario 
                            FROM Cuidado c
                            JOIN Mascota m ON c.MascotaNo = m.MascotaNo
                            LEFT JOIN Veterinario v ON c.VetID = v.VetID
                            ORDER BY c.Fecha DESC";
                        break;
                    case "Resumen Financiero":
                        query = @"
                            SELECT 'Ingresos' AS Tipo, SUM(pc.Monto) AS Total FROM PorCobrar pc
                            UNION ALL
                            SELECT 'Gastos', SUM(c.Precio) FROM Cuidado c
                            UNION ALL
                            SELECT 'Balance', 
                                (SELECT SUM(Monto) FROM PorCobrar) - (SELECT SUM(Precio) FROM Cuidado)";
                        break;
                    case "Reporte de Compatibilidad":
                        dataGridView.DataSource = dbHelper.EjecutarProcedimiento("ReporteCompatibilidadAdopciones");
                        return;

                }

                dataGridView.DataSource = dbHelper.ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al cargar datos: {ex.Message}", "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }

    }
