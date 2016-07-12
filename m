From: tom.ty89@gmail.com
Subject: [PATCH resend 1/2] libata-scsi: set CmdQue bit in standard INQUIRY data to 1
Date: Tue, 12 Jul 2016 21:29:34 +0800
Message-ID: <5784f0c4.8469620a.ab9e4.ffff9997@mx.google.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Tom Yan <tom.ty89@gmail.com>

Avoid performance bottleneck when being SCSI pass-through'd to
virtual machines with other OSes (e.g. Windows) via virtio-scsi
and scsi-block in qemu.

Ref.: https://github.com/YanVugenfirer/kvm-guest-drivers-windows/issues/63

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bfec66f..0a35164 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2097,7 +2097,10 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		0,
 		0x5,	/* claim SPC-3 version compatibility */
 		2,
-		95 - 4
+		95 - 4,
+		0,
+		0,
+		2
 	};
 
 	VPRINTK("ENTER\n");
-- 
2.9.0

