Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF066B51;
	Tue, 30 Jan 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620917; cv=none; b=uxJPaCh6szxltrURcEhdY8fk7Rg3d7gYp5TDIKx/AGJtzmsBtTQ18QinIV84/Te5aIt9Q3wO3A5opo8FlxcVO+DPZLAwu1VGbb0Yx6IdW2F9j9lYqoSXgV2mqSkbn+EOAPONiIj0Ep+KzWQcjHG2Q5jgUE+4iwPc5jH3pvTWEoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620917; c=relaxed/simple;
	bh=sCwvg7fmZpYe2WFUpmLqoBWvtS4SSrCpp+/eMKYVJzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iBnSE4vuAqsuhthC2R3CrmRDDW2gyylJ7RNprbO6HMApA0Z/5077OjM3uMftCT7rXS9QeRYRLgU+sEC36ADgbOacQZHlnfCcldqj8d0kofiMHu35t+DNXCdYQNO98Ve2pK6BFzNNAmacfCOhetkhnVd9luYo8DzpD++ESd9WnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id C985D7F711; Tue, 30 Jan 2024 15:21:51 +0200 (EET)
Date: Tue, 30 Jan 2024 15:21:51 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: [PATCH v2] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Message-ID: <Zbj37-5aAB_6R4m_@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ASMedia have confirmed that all ASM106x parts currently listed in
ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
into on the ASM1061, and therefore, we need to apply the quirk added by
commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
ASM1061 controllers") to the other supported ASM106x parts as well.

Cc: stable@vger.kernel.org
Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
---
Changes in v2:
- Add Cc: stable@ (requested by Damien)
- Fix commit reference style (requested by Niklas)

Link to v1: https://lore.kernel.org/linux-ide/ZbjgTmR5FbAnb-Ua@wantstofly.org/
---
 drivers/ata/ahci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d2460fa985b7..da2e74fce2d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
 	/* ASMedia */
-	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
 	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
-- 
2.43.0
