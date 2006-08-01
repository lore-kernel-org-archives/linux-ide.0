From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/11] ata_piix: fix host_set private_data intialization
Date: Wed, 2 Aug 2006 05:11:49 +0900
Message-ID: <11544631093192-git-send-email-htejun@gmail.com>
References: <11544631081793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:29277 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932544AbWHAULz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Aug 2006 16:11:55 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1473623ugc
        for <linux-ide@vger.kernel.org>; Tue, 01 Aug 2006 13:11:53 -0700 (PDT)
In-Reply-To: <11544631081793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.ukjgarzik@pobox.com, akpm@osdl.org, davej@redhat.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

To get host_set->private_data initialized reliably, all pinfos need to
point to the same hpriv.  Restore pinfo->private_data after pata pinfo
assignment.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

2b9e1bbec0f99f038e40d040a41a082154399554
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 19745a3..298e464 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -828,6 +828,7 @@ static void __devinit piix_init_sata_map
 		case IDE:
 			WARN_ON((i & 1) || map[i + 1] != IDE);
 			pinfo[i / 2] = piix_port_info[ich5_pata];
+			pinfo[i / 2].private_data = hpriv;
 			i++;
 			printk(" IDE IDE");
 			break;
-- 
1.3.2


