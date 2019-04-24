From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/3] drivers: libata: introduce sysctl directory
Date: Wed, 24 Apr 2019 12:34:40 +0200
Message-ID: <1556102081-11820-3-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Register a sysctl directory for libata, so upcoming knobs
can be added here.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/libata-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index adf2878..d3044c9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -176,6 +176,21 @@ struct ata_force_ent {
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+static struct ctl_table ctl_libata[] = {
+	{}
+};
+
+static struct ctl_table libata_dir_table[] = {
+	{
+		.procname	= "libata",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= ctl_libata,
+	},
+	{ },
+};
+
+static struct ctl_table_header *libata_sysctl_header;
 
 static bool ata_sstatus_online(u32 sstatus)
 {
@@ -7059,6 +7074,8 @@ static int __init ata_init(void)
 		goto err_out;
 	}
 
+	libata_sysctl_header = register_sysctl_table(libata_dir_table);
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 
@@ -7072,6 +7089,7 @@ static void __exit ata_exit(void)
 	libata_transport_exit();
 	ata_sff_exit();
 	kfree(ata_force_tbl);
+	unregister_sysctl_table(libata_sysctl_header);
 }
 
 subsys_initcall(ata_init);
-- 
1.9.1
