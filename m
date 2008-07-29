From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: subsys 106b:00a3 is apple ich8m
 too
Date: Tue, 29 Jul 2008 15:06:26 +0900
Message-ID: <488EB362.1090307@gmail.com>
References: <da38d7b90807240227q165cb5elad937973a58bf88f@mail.gmail.com>	 <488D757B.6000002@gmail.com>	 <da38d7b90807280101y44ef5624of99f7038967405a6@mail.gmail.com>	 <da38d7b90807281154p6cd45e0pf0acd83cd583d06a@mail.gmail.com>	 <488E7D0F.4040204@gmail.com> <da38d7b90807282255l5aabd1c7lb763307a5bac9c64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:24291 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbYG2GGy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 02:06:54 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2507338tic.23
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 23:06:52 -0700 (PDT)
In-Reply-To: <da38d7b90807282255l5aabd1c7lb763307a5bac9c64@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felipe Sere <dodofxp@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Subsys 106b:00a3 also is the weird apple ich8m which chokes when the
latter two ports are accessed, add it.  Reported by Felipe Sere.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Felipe Sere <dodofxp@gmail.com>
---
This leaves a whole - 00a2.  Is there anyone who can verify whether
00a2 exists or not?  I feel a bit uncomfortable about adding it
blindly.

 drivers/ata/ata_piix.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a90ae03..c294121 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -250,6 +250,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* Mobile SATA Controller IDE (ICH8M), Apple */
 	{ 0x8086, 0x2828, 0x106b, 0x00a0, 0, 0, ich8m_apple_sata },
 	{ 0x8086, 0x2828, 0x106b, 0x00a1, 0, 0, ich8m_apple_sata },
+	{ 0x8086, 0x2828, 0x106b, 0x00a3, 0, 0, ich8m_apple_sata },
 	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
 	/* SATA Controller IDE (ICH9) */
