From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 05/08] sil24: remove PORT_TF
Date: Wed, 17 Aug 2005 13:09:02 +0900 (KST)
Message-ID: <20050817040611.FCA60659@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:63898 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750831AbVHQEJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:10 -0400
Received: by zproxy.gmail.com with SMTP id r28so73452nza
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:09:07 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

05_sil24_remove-PORT_TF.patch

	Remove PORT_TF, as taskfile isn't located at PORT_TF.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
@@ -104,9 +104,6 @@ enum {
 	 */
 	PORT_REGS_SIZE		= 0x2000,
 	PORT_PRB		= 0x0000, /* (32 bytes PRB + 16 bytes SGEs * 6) * 31 (3968 bytes) */
-		/* TF is overlayed w/ PRB regs in the preview driver,
-		 * but it doesn't seem to work. */
-	PORT_TF			= 0x0000,
 
 	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
 		/* 32 bit regs */
@@ -703,9 +700,7 @@ static int sil24_init_one(struct pci_dev
 		u32 tmp;
 		int cnt;
 
-		probe_ent->port[i].cmd_addr = portu + PORT_TF;
-		probe_ent->port[i].ctl_addr = portu + PORT_TF + 0xa;
-		probe_ent->port[i].altstatus_addr = portu + PORT_TF + 0xa;
+		probe_ent->port[i].cmd_addr = portu;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);

