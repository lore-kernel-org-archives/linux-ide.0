From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata-hp: skip EH reset if no device to recover and hotplug pending
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <1144764848273-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.238]:40382 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751295AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by wproxy.gmail.com with SMTP id i11so931981wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:14 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that hotplug support is online, there is no reason to reset frozen
empty port with pending hotplug probe (it will do the same thing).
Skip EH reset in such cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

0d1308467ab2bc82faee607440c00b9a14b0af71
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 443f81f..d54ebb1 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1208,8 +1208,12 @@ int ata_eh_revive(struct ata_port *ap, u
 	}
 	action &= ~ATA_PORT_REVALIDATE;
 
-	/* Skip reset if possible. */
-	if (!nr_enabled && !(ap->flags & ATA_FLAG_FROZEN))
+	/* Skip reset if possible.  Note that ata_eh_hotplug() might
+	 * determine not to perform reset and EH can finish with a
+	 * frozen port.  EH framework will take care of such cases.
+	 */
+	if (!nr_enabled && (!(ap->flags & ATA_FLAG_FROZEN) ||
+			    ap->hotplug_flags & ATA_HOTPLUG_PROBE))
 		goto out;
 
 	/* give devices some time to breath */
-- 
1.2.4


