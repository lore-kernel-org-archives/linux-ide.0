From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Tue, 22 Apr 2008 23:11:01 +0900
Message-ID: <480DF1F5.3060208@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200804191548.04013.volker.armin.hemmann@tu-clausthal.de> <15F501D1A78BD343BE8F4D8DB854566B277C048A@hkemmail01.nvidia.com> <200804221444.55483.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000100040206050302060401"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.235]:28836 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbYDVOLU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 10:11:20 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1929625qbe.15
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 07:11:19 -0700 (PDT)
In-Reply-To: <200804221444.55483.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Peer Chen <pchen@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

This is a multi-part message in MIME format.
--------------000100040206050302060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Volker Armin Hemmann wrote:
> On Dienstag, 22. April 2008, Peer Chen wrote:
>> Looks like the BIOS trap had been applied, GHC.AE suppose should be set
>> correctly. Volker, could you try to set the AE twice in the driver or using
>> mmapper to set the AE manually to check if AE will be set correctly or not?
> 
> emm, I am totally out of my depth here. I don't even know what you are talking 
> about. If you explain me in nice, little word or even better, with examples, 
> what I shall try, I will happily do so.

This patch should do the trick.

-- 
tejun

--------------000100040206050302060401
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3efa990..dbbf6cf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -562,15 +562,23 @@ static inline void __iomem *ahci_port_base(struct ata_port *ap)
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
+	int i;
 	u32 tmp;
 
-	/* turn on AHCI_EN */
 	tmp = readl(mmio + HOST_CTL);
-	if (!(tmp & HOST_AHCI_EN)) {
+	if (tmp & HOST_AHCI_EN)
+		return;
+
+	for (i = 0; i < 10; i++) {
+		msleep(100);
 		tmp |= HOST_AHCI_EN;
 		writel(tmp, mmio + HOST_CTL);
 		tmp = readl(mmio + HOST_CTL);	/* flush && sanity check */
-		WARN_ON(!(tmp & HOST_AHCI_EN));
+
+		/* turn on AHCI_EN */
+		if (tmp & HOST_AHCI_EN)
+			break;
+		printk("AHCI_EN failed i=%d\n", i);
 	}
 }
 

--------------000100040206050302060401--
