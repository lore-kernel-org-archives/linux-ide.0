From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Problem with ahci and a external sata disk
Date: Fri, 7 Mar 2008 15:15:43 +0100
Message-ID: <200803071515.43686.jareguero@telefonica.net>
References: <200802191646.39277.jareguero@telefonica.net> <47CFA2E0.5030304@gmail.com> <200803071403.43113.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outmailhost.telefonica.net ([213.4.149.242]:23808 "EHLO
	ctsmtpout3.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759678AbYCGOP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Mar 2008 09:15:59 -0500
In-Reply-To: <200803071403.43113.jareguero@telefonica.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

El Viernes, 7 de Marzo de 2008, Jose Alberto Reguero escribi=F3:
> El Jueves, 6 de Marzo de 2008, Tejun Heo escribi=F3:
> > Jose Alberto Reguero wrote:
> > > When I try to make a ext3 fs in the disk I got a lot of erros:
> >
> > Can you please try 2.6.25-rc4 and see whether it behaves any
> > differently.  The initial errors should be about the same but EH sh=
ould
> > slow the PHY to 1.5Gbps quickly and that seems to solve many PHY re=
lated
> > problems on eSATA connectors.
> >
> > Thanks.
>
> I try with kernel 2.6.25-rc4 but when the limiting speed to 1.5g the =
device
> can't recover.
> I try whith the option:
> options libata force=3D4:1.5g
> and works, but the speed is limited until:
> ata4.00: limiting speed to UDMA/33:PIO4
> and still have some errors.
>
> Do you know what Transfer mode   I must try in  libata force to not h=
ave
> erros?
>
> Thanks.
>
> Jose Alberto
>

[root@jar Pls]# hdparm -I /dev/sdd

/dev/sdd:

ATA device, with non-removable media
        Model Number:       Seagate FreeAgent Pro
        Serial Number:      5QD3Q2AZ
        Firmware Revision:  3.AFM
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 1
        Supported: 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   0
        heads           16      0
        sectors/track   63      0
        --
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors: 1465149168
        device size with M =3D 1024*1024:      715404 MBytes
        device size with M =3D 1000*1000:      750156 MBytes (750 GB)
Capabilities:
        LBA, IORDY(cannot be disabled)
        Standby timer values: spec'd by Vendor, with device specific mi=
nimum
        R/W multiple sector transfer: Max =3D 1   Current =3D 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udm=
a6
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=3D120ns  IORDY flow control=3D=
120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
           *    Power Management feature set
           *    Write cache
           *    48-bit Address feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART self-test
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)
Integrity word not set (found 0x0000, expected 0x23a5)

I noticed that :
  R/W multiple sector transfer: Max =3D 1   Current =3D 0

It is important?

Jose Alberto

