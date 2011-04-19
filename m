From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] libata: Pioneer DVR-216D can't do SETXFER
Date: Tue, 19 Apr 2011 11:13:32 -0400
Message-ID: <4DADA69C.4060708@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38901 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab1DSPNf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2011 11:13:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

 Commit 4a5610a04d415ed94af75bb1159d2621d62c8328 fixed an issue with
 the Pioneer DVR-212D not handling SETXFER correctly. An openSUSE user
 reported a similar issue with his DVR-216D that the NOSETXFER horkage
 worked around for him as well.

 This patch adds the DVR-216D (1.08) to the horkage list for NOSETXFER.

 The issue was reported at:
 https://bugzilla.novell.com/show_bug.cgi?id=679143

Reported-by: Volodymyr Kyrychenko <vladimir.kirichenko@gmail.com>
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 drivers/ata/libata-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4138,6 +4138,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	 */
 	{ "PIONEER DVD-RW  DVRTD08",	"1.00",	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-212D",	"1.28", ATA_HORKAGE_NOSETXFER },
+	{ "PIONEER DVD-RW  DVR-216D",	"1.08", ATA_HORKAGE_NOSETXFER },
 
 	/* End Marker */
 	{ }

-- 
Jeff Mahoney
SUSE Labs
