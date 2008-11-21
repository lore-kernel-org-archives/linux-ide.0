From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Fri, 21 Nov 2008 13:56:32 +0900
Message-ID: <49263F80.2060607@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55872 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbYKUE4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Nov 2008 23:56:25 -0500
In-Reply-To: <18725.17831.755158.999770@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>
Cc: Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

sata_promise hardreset doesn't seem to be able to acquire the initial
D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
follow-up SRST.

 http://article.gmane.org/gmane.linux.ide/36186

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Peter, can you please test this one too?  It's essentially the same
code just slightly prettier.  Mikael, what do you think about this?

Jeff, please commit only after Peter's verification and Mikael's ACK.

Thanks.

 drivers/ata/sata_promise.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index ba9a257..917038a 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -710,7 +710,12 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
 {
 	pdc_reset_port(link->ap);
-	return sata_sff_hardreset(link, class, deadline);
+
+	/* sata_promise can't reliably acquire the first D2H Reg FIS
+	 * after hardreset.  Do non-waiting hardreset and request
+	 * follow-up SRST.
+	 */
+	return sata_std_hardreset(link, class, deadline);
 }
 
 static void pdc_error_handler(struct ata_port *ap)
