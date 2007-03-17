From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 19:47:59 +0100
Message-ID: <45FC37DF.3010805@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703171429.49646.bzolnier@gmail.com> <45FBFD89.3080308@tw.ibm.com> <200703171600.55863.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:37212 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbXCQSsH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 14:48:07 -0400
Received: by an-out-0708.google.com with SMTP id b33so980503ana
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 11:48:06 -0700 (PDT)
In-Reply-To: <200703171600.55863.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

BTW, maybe I didn't understand you well, stupid question- what is=20
Promise controller? Is it normal ide controler on my motherboard or=20
attached ultra ATA  133/ PCI controller?


00:00.0 Host bridge: Intel Corporation 82845 845 (Brookdale) Chipset=20
Host Bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 82845 845 (Brookdale) Chipset AGP=
=20
Bridge (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 12)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 12)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 12)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev=
 12)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 12)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev=
 12)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'9=
7=20
Audio (rev 12)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW=
=20
[Radeon 7500]

This one?

02:01.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02=
)


02:05.0 Ethernet controller: ADMtek NC100 Network Everywhere Fast=20
Ethernet 10/100 (rev 11)



Bartlomiej Zolnierkiewicz =EF=E8=F8=E5:
> On Saturday 17 March 2007, Albert Lee wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>> Hi,
>>>
>>> Any news about this test?  ide-cd driver is much more forgiving for
>>> quirky hardware than libata+sr so please give it a try...
>>>
>> Hi Bart,
>> Yarema did the run test, but the AOpen drive was connected to the PI=
IX
>> controller, which is driven by libata:
>=20
> Which unfortunately says us nothing besides that pdc202xx_new works g=
reat
> on this system... ;-)
>=20
> Yarema, could you disable ata_piix, enable drivers/ide piix driver an=
d retest?
>=20
> Thanks,
> Bart
>=20

