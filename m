From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 3/3] drivers: libata: add sysctl: 'libata.allow_tpm' for self-encrypted devices
Date: Wed, 24 Apr 2019 12:34:41 +0200
Message-ID: <1556102081-11820-4-git-send-email-info@metux.net>
References: <1556102081-11820-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556102081-11820-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

libata tpm functionality, needed for self encrypted devices (OPAL, ...),
is currently disabled per default and needs to be enabled via kernel
command line.

This patch allows enabling it via sysctl.

The implementation might look a bit 'naive', as there aren't any locks
or barriers, etc. As we're dealing just w/ a plain boolean value, that's
only checked when an tpm-related ioctl is called, we're fine w/ that.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/libata-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3044c9..80ba844 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -177,6 +177,13 @@ struct ata_force_ent {
 MODULE_VERSION(DRV_VERSION);
 
 static struct ctl_table ctl_libata[] = {
+	{
+		.procname	= "allow_tpm",
+		.data		= &libata_allow_tpm,
+		.maxlen		= sizeof(libata_allow_tpm),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{}
 };
 
-- 
1.9.1
