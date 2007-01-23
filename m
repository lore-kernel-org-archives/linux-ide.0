From: Stefan Althoefer <as@janz.de>
Subject: problem with register_hw_with_fixup
Date: Tue, 23 Jan 2007 09:51:52 +0100
Message-ID: <45B5CCA8.7010603@janz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mr01.hansenet.de ([213.191.74.10]:44834 "EHLO mr01.hansenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902AbXAWJJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 04:09:55 -0500
Received: from mail1.janzag.de (213.39.240.49) by mr01.hansenet.de (7.2.074)
        id 45AE38A100052480 for linux-ide@vger.kernel.org; Tue, 23 Jan 2007 09:49:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail1.janzag.de (Postfix) with ESMTP id 0D3551ACB5
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 09:49:43 +0100 (CET)
Received: from mail1.janzag.de ([127.0.0.1])
 by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23565-02 for <linux-ide@vger.kernel.org>;
 Tue, 23 Jan 2007 09:49:38 +0100 (CET)
Received: from [192.168.0.63] (pc-as007.janzag.de [192.168.0.63])
	by mail1.janzag.de (Postfix) with ESMTP id 3A0C219F94
	for <linux-ide@vger.kernel.org>; Tue, 23 Jan 2007 09:49:38 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi,

I'm currently developing a ide driver for an embedded ARM device.
The device hardware is somewhat wired, as all IDE access must
be done 16bit, even the control bytes. I therefore need special
access functions.

I do this to register special IN/OUT functions:

-----%<---some code delete for brevity-------------
void empca400_fixup(
     ide_hwif_t *hwif
)
{
     hwif->mmio =3D 2;
     hwif->OUTB =3D &empca400_ide_outb;
     hwif->OUTBSYNC =3D &empca400_ide_outbsync;
     hwif->OUTW =3D &empca400_ide_outw;
     hwif->OUTSW =3D &empca400_ide_outsw;
     :
}


static int __init empca400ide_init(void)
{
	:

         memset(&hw, 0, sizeof(hw));

         base =3D 0x56000000;
         aux  =3D base + 0x10;

         vbase =3D (unsigned long) ioremap(base, 0x10);
         vaux  =3D vbase + 0x20;

         for (i =3D IDE_DATA_OFFSET; i <=3D IDE_STATUS_OFFSET; i++) {
                 hw.io_ports[i] =3D (unsigned long)vbase;
                 vbase +=3D 4;
         }
         hw.io_ports[IDE_CONTROL_OFFSET] =3D vaux + (6 * 0x2);
         hw.irq =3D 20;  /* GPIO3 =3D IRQ20 */
         hw.dma =3D NO_DMA;
         hw.chipset =3D ide_generic;

         ret =3D ide_register_hw_with_fixup(&hw, &hwif, empca400_fixup)=
;

	:
}
-----------------------------------------------------

However, in probe_hwif_init_with_fixup() I find this sequence:

-----%<-----------------
int probe_hwif_init_with_fixup(ide_hwif_t *hwif, void (*fixup)(ide_hwif=
_t *hwif))
{
	probe_hwif(hwif);

	if (fixup)
		fixup(hwif);
-------------------------

fixup() gets called after probe_hwif, hence my special function
pointers will not be installed in time.

Shouldn't probe_hwif_init_with_fixup() call the fixup() first? If
not, what is fixup() good for, and how can I get my function
pointers registered before probe_hwif()?


mfg

--=20
----------------------
Stefan Alth=F6fer (stefan.althoefer@janz.de)
Janz Automationssysteme AG
   - Automation Intelligence -
Member of the Janz company group
Im Doerener Feld 8
33100 Paderborn - Germany
