From: Mickael Marchand <marchand@kde.org>
Subject: adaptec 1210sa, lost interrupt
Date: Thu, 18 Dec 2003 00:49:00 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312180049.09951.marchand@kde.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alhya.freenux.org ([213.41.137.38]:12416 "EHLO
	moria.freenux.org") by vger.kernel.org with ESMTP id S264868AbTLQXsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Dec 2003 18:48:39 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

anyone has a small idea of what to do to make it work ?
I tried both siimage and sata_sil (libata) with it, all got locked with 
interrupt/dma stuff with 2.4/2.6 latest patches, noapic noacpi (dma 
enabled/disabled)

I feel pretty curious on the fact that the 2 channels wants to use the same 
IRQ and it tries to share it with another device (on my K7 it tried to share 
IRQ 5 with my soundcard, so i removed the soundcard but that did not help 
either).
Maybe I am wrong, but it looks really strange to me that both channels use the 
same IRQ and I wonder if the channels are conflicting with each other.

I tried also to disable the share IDE interrupts in kernel, but it does not 
seem to change anything.

So if you have ideas/comments about it, I can try them ...

maybe I will try to disable one of the ports and see if that helps.

Dec 17 14:25:46 moria kernel: Adaptec AAR-1210SA: IDE controller at PCI slot 
0000:00:11.0
Dec 17 14:25:46 moria kernel: PCI: Found IRQ 5 for device 0000:00:11.0
Dec 17 14:25:46 moria kernel: PCI: Sharing IRQ 5 with 0000:00:0b.0
Dec 17 14:25:46 moria kernel: Adaptec AAR-1210SA: chipset revision 2
Dec 17 14:25:46 moria kernel: Adaptec AAR-1210SA: 100%% native mode on irq 5
Dec 17 14:25:46 moria kernel:     ide2: MMIO-DMA at 0xd09b9e00-0xd09b9e07, 
BIOS settings: hde:pio, hdf:pio
Dec 17 14:25:46 moria kernel:     ide3: MMIO-DMA at 0xd09b9e08-0xd09b9e0f, 
BIOS settings: hdg:pio, hdh:pio
Dec 17 14:25:46 moria kernel: hde: ST3120026AS, ATA DISK drive

please CC me.

cheers,
Mik

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4OtwyOYzc4nQ8j0RAg9tAKCZ/iS0U/RhafUgYwyv6jcZa9DyrACeIKX1
KjYHUaeWsMZvc0yG3y5JBfo=
=swKN
-----END PGP SIGNATURE-----
