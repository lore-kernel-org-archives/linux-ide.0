From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: prefix sata register print outs with 0x
Date: Tue, 11 Apr 2006 22:26:29 +0900
Message-ID: <1144761989558-git-send-email-htejun@gmail.com>
References: <11447619891579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.233]:6531 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750849AbWDKN0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:26:31 -0400
Received: by wproxy.gmail.com with SMTP id i11so922160wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:26:31 -0700 (PDT)
In-Reply-To: <11447619891579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Prefix SStatus and SControl values with 0x as they are hex.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

f95a0f4882a17839102844fa0afe74a88e554800
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f1abe75..808a978 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1520,11 +1520,11 @@ static void sata_print_link_status(struc
 	if (sata_dev_present(ap)) {
 		tmp = (sstatus >> 4) & 0xf;
 		printk(KERN_INFO
-		       "ata%u: SATA link up %s (SStatus %X SControl %X)\n",
+		       "ata%u: SATA link up %s (SStatus 0x%X SControl 0x%X)\n",
 		       ap->id, sata_spd_string(tmp), sstatus, scontrol);
 	} else {
 		printk(KERN_INFO
-		       "ata%u: SATA link down (SStatus %X SControl %X)\n",
+		       "ata%u: SATA link down (SStatus 0x%X SControl 0x%X)\n",
 		       ap->id, sstatus, scontrol);
 	}
 }
-- 
1.2.4


