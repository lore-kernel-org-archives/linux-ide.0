From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 20:12:39 +0100
Message-ID: <200703172012.39295.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703171600.55863.bzolnier@gmail.com> <45FC37DF.3010805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:14857 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbXCQTFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 15:05:20 -0400
Received: by ug-out-1314.google.com with SMTP id 44so973843uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 12:05:19 -0700 (PDT)
In-Reply-To: <45FC37DF.3010805@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org


On Saturday 17 March 2007, YUP wrote:
> BTW, maybe I didn't understand you well, stupid question- what is=20
> Promise controller? Is it normal ide controler on my motherboard or=20
> attached ultra ATA  133/ PCI controller?

attached one

> 00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset=20
> Host Bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset A=
GP=20
> Bridge (rev 03)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 12)
> 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 1=
2)
> 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 12)
> 00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (r=
ev 12)
> 00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 12)
> 00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (r=
ev 12)
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC=
'97=20
> Audio (rev 12)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 =
QW=20
> [Radeon 7500]
>=20
> This one?
>=20
> 02:01.0 Mass storage controller: Promise Technology, Inc. 20269 (rev =
02)

Yes.

However you have the "problematic" drive on the on-board Intel controll=
er so
please disable ata_piix libata driver, enable piix IDE driver and retes=
t. :-)

Thanks,
Bart

> 02:05.0 Ethernet controller: ADMtek NC100 Network Everywhere Fast=20
> Ethernet 10/100 (rev 11)
>=20
>=20
>=20
> Bartlomiej Zolnierkiewicz =EF=E8=F8=E5:
> > On Saturday 17 March 2007, Albert Lee wrote:
> >> Bartlomiej Zolnierkiewicz wrote:
> >>> Hi,
> >>>
> >>> Any news about this test?  ide-cd driver is much more forgiving f=
or
> >>> quirky hardware than libata+sr so please give it a try...
> >>>
> >> Hi Bart,
> >> Yarema did the run test, but the AOpen drive was connected to the =
PIIX
> >> controller, which is driven by libata:
> >=20
> > Which unfortunately says us nothing besides that pdc202xx_new works=
 great
> > on this system... ;-)
> >=20
> > Yarema, could you disable ata_piix, enable drivers/ide piix driver =
and retest?
> >=20
> > Thanks,
> > Bart
