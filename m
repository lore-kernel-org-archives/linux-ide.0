From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Mon, 25 Jun 2007 13:22:47 +0800
Message-ID: <467F5127.4060006@tw.ibm.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <467A9923.6010203@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:47419 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbXFYFWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 01:22:52 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5P5MqZu029207
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 01:22:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5P5Mqar267904
	for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 23:22:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5P5MplX019280
	for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 23:22:52 -0600
In-Reply-To: <467A9923.6010203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bahadir Balban <bahadir.balban@gmail.com>, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Sergei Shtylyov wrote:
> Hello.
> 
> Bahadir Balban wrote:
> 
>> I have a PCI Promise TX2 Ultra133 controller with a harddisk on an ARM
>> platform (which is a barebone system with no BIOS). This setup used to
>> work with the old linux-ide drivers on 2.6.19
> 
> 
>    You were very lucky then bacause actually it usually failed on
> anything non-x86. ;-)
> 
>> but it does not work
>> with 2.6.22-rc4, or 2.6.21. Here's the error output:
> 
> 
>    I guess this might be related to the driver update in 2.6.20-rc1 then
> -- I made the driver calibrate the chip's PLL, so that it might work for
> non-x86 case too (where Promise BIOS isn't available to do this). The
> code is basically the same as in the libata's pata_2027x driver...
> 
>> PDC20269: chipset revision 2
>> <6>PDC20269: ROM enabled at 0xa0210000
>> PDC20269: ROM enabled at 0xa0210000
> 
> 
>    Hm, why all the messages are printed twice? :-O
>    (I'll cut out the dupes to save bandwidth).
> 
>> PDC20269: PLL input clock is 37736 kHz
> 
> 
>    37.736 MHz is a pretty strange PLL clock... Basically, it's the
> halved PCI clock, and that value signifies your PCI is probably running
> at 75 MHz -- which is serious overclocking... :-/
>    That could explain why the driver managed to work before -- the
> default DPLL settings fit for 66 MHz PCI but made the UltraDMA fail with
> CRC errors on the plain 33 MHz PCI, IIRC...
>    I may suggest replacing #undef DEBUG by #define DEBUG in this driver,
> rebuilding the kernel and posting the driver's output...
> 

I don't know whether this is related or not. Recently I noticed that
the PLL clock being detected higher than expected as 20MHz on my box.
(It used be 16.6 MHz since my PCI bus is running at 33MHz...)

Reloading the pata_pdc2027x module then the problem goes away.
I guess maybe somehow mdelay() is not as precise as before...

--
albert

(dmesg attached for reference)
The PLL clock is wrongly detected as 20MHz on my box, kernel 2.6.22-rc3.

[ 5545.255266] pata_pdc2027x 0000:02:05.0: version 0.9
[ 5545.255489] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
[ 5545.374703] pata_pdc2027x 0000:02:05.0: PLL input clock 20027 kHz
[ 5545.404872] scsi2 : pata_pdc2027x
[ 5545.430357] scsi3 : pata_pdc2027x
[ 5545.433338] ata3: PATA max UDMA/133 cmd 0xe09897c0 ctl 0xe0989fda bmdma 0xe0989000 irq 0
[ 5545.433671] ata4: PATA max UDMA/133 cmd 0xe09895c0 ctl 0xe0989dda bmdma 0xe0989008 irq 0
[ 5545.916581] ata3.00: ATAPI, max UDMA/33
[ 5545.916590] ata3.01: ATAPI, max UDMA/33
[ 5546.080361] ata3.00: configured for UDMA/33
[ 5546.244197] ata3.01: configured for UDMA/33
[ 5546.410493] scsi 2:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S07 PQ: 0 ANSI: 5
[ 5546.437658] scsi 2:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A105 PQ: 0 ANSI: 5
[ 5546.604481] sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
[ 5546.604808] Uniform CD-ROM driver Revision: 3.20
[ 5546.607596] sr 2:0:0:0: Attached scsi CD-ROM sr0
[ 5546.612168] sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[ 5546.614075] sr 2:0:1:0: Attached scsi CD-ROM sr1
[ 5640.334685] ata3.00: disabled
[ 5640.334695] ata3.01: disabled
[ 5640.403451] ACPI: PCI interrupt for device 0000:02:05.0 disabled
==============================================================================================
The PLL clock clock is correct after rmmod and reload the module:

[ 5644.153643] pata_pdc2027x 0000:02:05.0: version 0.9
[ 5644.153723] ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
[ 5644.252954] pata_pdc2027x 0000:02:05.0: PLL input clock 16714 kHz
[ 5644.303470] scsi4 : pata_pdc2027x
[ 5644.319285] scsi5 : pata_pdc2027x
[ 5644.321207] ata5: PATA max UDMA/133 cmd 0xe09897c0 ctl 0xe0989fda bmdma 0xe0989000 irq 0
[ 5644.321215] ata6: PATA max UDMA/133 cmd 0xe09895c0 ctl 0xe0989dda bmdma 0xe0989008 irq 0
[ 5644.803308] ata5.00: ATAPI, max UDMA/33
[ 5644.803629] ata5.01: ATAPI, max UDMA/33
[ 5644.967144] ata5.00: configured for UDMA/33
[ 5645.130975] ata5.01: configured for UDMA/33
[ 5645.287539] scsi 4:0:0:0: CD-ROM            LITE-ON  CD-RW SOHR-5238S 4S07 PQ: 0 ANSI: 5
[ 5645.291669] sr0: scsi3-mmc drive: 52x/52x writer cd/rw xa/form2 cdda tray
[ 5645.294295] sr 4:0:0:0: Attached scsi CD-ROM sr0
[ 5645.300189] scsi 4:0:1:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A105 PQ: 0 ANSI: 5
[ 5645.305716] sr1: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[ 5645.306736] sr 4:0:1:0: Attached scsi CD-ROM sr1
[albertcc@p4ht-s june_2007]$ 


