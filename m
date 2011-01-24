From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: DVR-212D can't do SETXFER DVD-RW
 DVR-212D
Date: Mon, 24 Jan 2011 17:01:25 +0100
Message-ID: <20110124160125.GC27510@htj.dyndns.org>
References: <4D3DA084.9070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38748 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab1AXQCO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 11:02:14 -0500
Received: by gyb11 with SMTP id 11so1323779gyb.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 08:02:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3DA084.9070609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Francesco Antonacci <fraanto@gmail.com>

From: Francesco Antonacci <fraanto@gmail.com>

PIONEER DVR-212D can't to SETXFER like its sibling DVRTD08.  Add
ATA_HORKAGE_NOSETXFER for it.  Reported in bko#27502.

  https://bugzilla.kernel.org/show_bug.cgi?id=27502

Signed-off-by: Francesco Antonacci <fraanto@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
Heh, that was formatted rather strangely.  Here's properly reformatted
version.

Thanks.

 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a31fe96..d4e52e2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4138,6 +4138,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 * device and controller are SATA.
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-212D",	"1.28", ATA_HORKAGE_NOSETXFER },
 
 	/* End Marker */
 	{ }
