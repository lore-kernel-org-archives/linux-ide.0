From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 3/5] ata: ahci_ceva: use the new port_{offset,length} members
Date: Fri, 22 Apr 2016 16:32:39 +0200
Message-ID: <1461335561-18363-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41744 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754376AbcDVOct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 10:32:49 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Now that the ahci_host_priv structure contains port_offset and
port_length members, this commit moves the ahci_ceva driver to use
them rather than hardcoded values.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/ahci_ceva.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 207649d..38611f2 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -79,8 +79,6 @@
 #define PORT_SCTL_SPD_GEN1	(0x1 << 4)
 #define PORT_SCTL_IPM		(0x3 << 8)
 
-#define PORT_BASE	0x100
-#define PORT_OFFSET	0x80
 #define NR_PORTS	2
 #define DRV_NAME	"ahci-ceva"
 #define CEVA_FLAG_BROKEN_GEN2	1
@@ -154,7 +152,8 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		tmp = PORT_SCTL_SPD_GEN2 | PORT_SCTL_IPM;
 		if (cevapriv->flags & CEVA_FLAG_BROKEN_GEN2)
 			tmp = PORT_SCTL_SPD_GEN1 | PORT_SCTL_IPM;
-		writel(tmp, mmio + PORT_SCR_CTL + PORT_BASE + PORT_OFFSET * i);
+		writel(tmp, mmio + PORT_SCR_CTL + hpriv->port_offset +
+		       hpriv->port_length * i);
 	}
 }
 
-- 
2.6.4

