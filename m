From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] ata: Remove inline attribute from ata_sff_host_intr()
Date: Thu, 20 Nov 2008 16:39:03 -0800
Message-ID: <49260327.8050408@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18750 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbYKUAjt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Nov 2008 19:39:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

ata: Remove inline attribute from ata_sff_host_intr()

ata_sff_host_intr is a public function, it should not be declared inline.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/libata-sff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9033d16..73d7dbb 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1542,8 +1542,8 @@ bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	One if interrupt was handled, zero if not (shared irq).
  */
-inline unsigned int ata_sff_host_intr(struct ata_port *ap,
-				      struct ata_queued_cmd *qc)
+unsigned int ata_sff_host_intr(struct ata_port *ap,
+			       struct ata_queued_cmd *qc)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 status, host_stat = 0;
