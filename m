From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] sata_sil: kill bogus PCI ID 0x1095/0x0240
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <11415422321792-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:38173 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752082AbWCEHD5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:03:57 -0500
Received: by zproxy.gmail.com with SMTP id 13so1009550nzn
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:03:56 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Silicon Image confirmed that 0x1095/0x0240 has never been used for
3112.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

---

 drivers/scsi/sata_sil.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

4c960f8b73294d01b9307ea6775304fc8556e550
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 8cb662d..0d962a4 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -90,7 +90,6 @@ static void sil_post_set_mode (struct at
 
 static const struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-- 
1.2.1


