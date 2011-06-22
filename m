From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: apply NOSETXFER horkage to the
 affected drives regardless of firmware revision
Date: Wed, 22 Jun 2011 12:13:10 +0200
Message-ID: <20110622101310.GD30101@htj.dyndns.org>
References: <20110620124442.159870@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37530 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1FVKNO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2011 06:13:14 -0400
Received: by fxm17 with SMTP id 17so520684fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 22 Jun 2011 03:13:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110620124442.159870@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: fl-00@gmx.de
Cc: linux-ide@vger.kernel.org

It's unlikely NOSETXFER works for a revision of drive but doesn't for
another and pioneer doesn't seem to be fixing firmwares for the
affected drives.  Apply NOSETXFER to the affected pioneer drives
regardless of firmware revision.

  http://article.gmane.org/gmane.linux.ide/49734

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: fl-00@gmx.de
---
> 1) is it possible to include the dvd-216d with rev. 1.09 as well (or
> even better: with any revision)

Done.

> 2) is there some plan how to cope with such "broken" drives in
> general without the need to include every single drive in the code?

Given that these are the only drives which are affected, I think it
would be better to keep quirks for these ones instead of changing the
generic behavior.

Thanks.

 drivers/ata/libata-core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 736bee5..000d03a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4143,9 +4143,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * Devices which choke on SETXFER.  Applies only if both the
 	 * device and controller are SATA.
 	 */
-	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-212D",	"1.28", ATA_HORKAGE_NOSETXFER },
-	{ "PIONEER DVD-RW  DVR-216D",	"1.08", ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVRTD08",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* End Marker */
 	{ }
