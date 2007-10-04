From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] libata: blacklist NCQ on Seagate Barracuda ST380817AS
Date: Thu, 4 Oct 2007 11:06:56 +0900
Message-ID: <20071004020656.GA12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:14063 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbXJDCHF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 22:07:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so17144nze
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 19:07:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ornati@fastwebnet.it

From: Paolo Ornati <ornati@fastwebnet.it>

Seagate Barracuda ST380817AS has troubles with NCQ. For example,
unpacking a tarball on an XFS filesystem gives this:

ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata1.00: cmd 61/40:00:29:a3:98/00:00:00:00:00/40 tag 0 cdb 0x0 data 32768 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

More info here:
http://lkml.org/lkml/2007/1/21/76
    
Blacklist it!

Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index aecbdad..48a62a2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3958,6 +3958,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
+	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
 
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
