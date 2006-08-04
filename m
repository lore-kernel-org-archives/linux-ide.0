From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] ata_piix: fix host_set private_data intialization
Date: Sat, 5 Aug 2006 05:48:46 +0900
Message-ID: <11547245262369-git-send-email-htejun@gmail.com>
References: <11547243571730-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:49680 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161467AbWHDUsx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 16:48:53 -0400
Received: by py-out-1112.google.com with SMTP id z74so508109pyg
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 13:48:52 -0700 (PDT)
In-Reply-To: <11547243571730-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

To get host_set->private_data initialized reliably, all pinfos need to
point to the same hpriv.  Restore pinfo->private_data after pata pinfo
assignment.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

f814b75f4ed2ed58cd7bc876a0a9406f984aac6d
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


