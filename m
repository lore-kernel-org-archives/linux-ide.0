From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with some aec62xx
Date: Sun, 07 Dec 2003 13:19:12 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1070763552.11008.34.camel@gaston>
References: <1070763062.12497.30.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.86.99.235]:63188 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265286AbTLGCUW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2003 21:20:22 -0500
Received: from [202.81.18.30] (helo=gaston.ozlabs.ibm.com)
	by pentafluge.infradead.org with asmtp (Exim 4.22 #5 (Red Hat Linux))
	id 1ASoYZ-0003tl-Uw
	for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2003 02:22:00 +0000
In-Reply-To: <1070763062.12497.30.camel@gaston>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, 2003-12-07 at 13:11, Benjamin Herrenschmidt wrote:
> Hi !
> 
> One of you (Bart, Andre ?) has specs to these controllers ? Some
> users are reporting me various failures with these on ppc until
> they got a bit of code back from earlier 2.4 drivers into the
> new (2.4.21+ or 2.6.0) one:
> 
> 			/* Clear reset and test bits.  */
> 			pci_read_config_byte(hwif->pci_dev, 0x49, &reg49h);
> 			pci_write_config_byte(hwif->pci_dev, 0x49, reg49h & ~0x30);
> 			/* Enable chip interrupt output.  */
> 			pci_read_config_byte(hwif->pci_dev, 0x4a, &reg4ah);
> 			pci_write_config_byte(hwif->pci_dev, 0x4a, reg4ah & ~0x01);

   .../...

And I forgot to mention that the above is for those IDs:

		case PCI_DEVICE_ID_ARTOP_ATP865:
		case PCI_DEVICE_ID_ARTOP_ATP865R:

Ben.

