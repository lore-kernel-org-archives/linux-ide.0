From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/5] ata: acard-ahci: use the new port_{offset,length} members
Date: Fri, 22 Apr 2016 16:32:38 +0200
Message-ID: <1461335561-18363-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41733 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754374AbcDVOct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 10:32:49 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Now that the ahci_host_priv structure contains port_offset and
port_length members, this commit moves the acard-ahci driver to use
them rather than hardcoded values.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/acard-ahci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index ed6a30c..54c8ae4 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -476,7 +476,8 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR, -1, "abar");
 		ata_port_pbar_desc(ap, AHCI_PCI_BAR,
-				   0x100 + ap->port_no * 0x80, "port");
+				   hpriv->port_offset +
+				   ap->port_no * hpriv->port_length, "port");
 
 		/* set initial link pm policy */
 		/*
-- 
2.6.4

