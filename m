From: Tejun Heo <tj@kernel.org>
Subject: [PATCH] libata: use ATAPI dma even for data transfers not aligned
 to 16 bytes
Date: Mon, 16 Jun 2008 16:26:44 +0900
Message-ID: <485615B4.7070002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50028 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbYFPH1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 03:27:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Most ATAPI DMA failures are due to controller issues including choking
on data buffer w/o proper padding or draining areas and should be
worked around in LLDs.  The default 16 byte alignment check in
ata_check_atapi_dma() only partially hides problems (well, that was
the conclusion back then, at least).

Now that ATAPI DMA support seems fairly stable.  Let's take the plunge
and verify the previous conclusion was correct.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jeff, Alan, as discussed before, the default 16 byte alignment check
doesn't make much sense if our previous conclusion was correct.  I
guess it's about time we put the theory to the test.  It'll be
probably best to put this in a separate branch and expose it through
-next and -mm only.

Thanks.

 drivers/ata/libata-core.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 52285f6..0d3d16c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4325,12 +4325,6 @@ int ata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
-	 * few ATAPI devices choke on such DMA requests.
-	 */
-	if (unlikely(qc->nbytes & 15))
-		return 1;
-
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
 
