From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Problem with some aec62xx
Date: Sun, 07 Dec 2003 13:11:02 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1070763062.12497.30.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.86.99.235]:53203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265285AbTLGCMM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2003 21:12:12 -0500
Received: from [202.81.18.30] (helo=gaston.ozlabs.ibm.com)
	by pentafluge.infradead.org with asmtp (Exim 4.22 #5 (Red Hat Linux))
	id 1ASoQg-0003tW-CK
	for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2003 02:13:50 +0000
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi !

One of you (Bart, Andre ?) has specs to these controllers ? Some
users are reporting me various failures with these on ppc until
they got a bit of code back from earlier 2.4 drivers into the
new (2.4.21+ or 2.6.0) one:

			/* Clear reset and test bits.  */
			pci_read_config_byte(hwif->pci_dev, 0x49, &reg49h);
			pci_write_config_byte(hwif->pci_dev, 0x49, reg49h & ~0x30);
			/* Enable chip interrupt output.  */
			pci_read_config_byte(hwif->pci_dev, 0x4a, &reg4ah);
			pci_write_config_byte(hwif->pci_dev, 0x4a, reg4ah & ~0x01);

Theres also this additional bit, that doesn't seem to be required,
but was there in 2.4.20 (at least in my tree, it's possible that the
version of the driver I had was slightly different as I remember
taking patches on this driver from some users a long time ago).

#define CONFIG_AEC6280_BURST
#ifdef CONFIG_AEC6280_BURST
			/* Must be greater than 0x80 for burst mode.  */
			pci_write_config_byte(hwif->pci_dev, PCI_LATENCY_TIMER, 0x90);
			/* Enable burst mode.  */
			pci_read_config_byte(hwif->pci_dev, 0x4a, &reg4ah);
			pci_write_config_byte(hwif->pci_dev, 0x4a, reg4ah | 0x80);
#endif


