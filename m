From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 11:57:16 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE07016FE51B@orsmsx420.amr.corp.intel.com>
References: <200706182049.45315.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62186 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764211AbXFRS5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:57:18 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200706182049.45315.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chunkeey@web.de
Cc: linux-ide@vger.kernel.org

I don't think we want to have the same DeviceID supported in more then =
one driver.  Would they not conflict with each other?

Jason



>-----Original Message-----
>From: chunkeey@web.de [mailto:chunkeey@web.de]
>Sent: Monday, June 18, 2007 11:50 AM
>To: Gaston, Jason D
>Cc: linux-ide@vger.kernel.org
>Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
>
>On Monday, 18. June 2007, Gaston, Jason D wrote:
>> FYI: DID 2850 is the PATA IDE controller.  Most likely, the laptop d=
oes
>not have SATA drives and is running off of PATA.
>>
>> The old IDE subsystem (piix.c) is where I added that PATA DID to.
>> #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850 in pci_ids.h
>>
>> Jason
>>
>
>Yes, I've already said that the old IDE subsystem knows about ICH 8M
>(read the stuff in the brackets in the original post!).
>
>But one day the old ide subsystem will be gone...
>that's why I've added the PCIID to ata_piix.c "today", so I don't have=
 to
>do it "tomorrow".
>
>Another thing, Kconfig's description clearly states: "
>config ATA_PIIX
>	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
>...
>	  This option enables support for ICH5/6/7/8 Serial ATA
>	  and support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series
>	  host controllers.
>"
>
>so, either change the description to:
>"... support for PATA on the Intel ESB/ICH(all old chipsets
>0,2,3M,3,4,5,6,7,7-R; but
>not 8M, because you have use the old subsystem, for your "new"
>technology!)/PIIX3/PIIX4 series"
>
>or accept the 1+1=3D2 logic and merge the patch into the git.
>(hint: but only after changing ich_pata_100 to ich_pata_133 of course!=
)
>
>:D
>
>Thanks,
>	Chr.
>
>>
>> >On Monday, 18. June 2007, Alan Cox wrote:
>> >> On Mon, 18 Jun 2007 15:20:06 +0200
>> >> Chr <chunkeey@web.de> wrote:
>> >>
>> >> > Hi,
>> >> >
>> >> > I got a new laptop and I had a little problem that the DVD driv=
e
>wasn't
>> >recognized by
>> >> > libata's piix driver (but the old IDE Subsystem found it!).
>> >> >
>> >> > So, after adding the new pciid 8086:2850 it works!
>> >> > But, I don't know if it's ich_pata_100 or ich_pata_133 since th=
e
>> >> > dvd/cd drives only goes up to udma2 speeds.
>> >>
>> >> Its ich_pata_133 - all the newer chips are. They work even better=
 if
>you
>> >> set them into AHCI mode in the BIOS and then they should "just wo=
rk"
>with
>> >> recent kernels as the AHCI driver now matches by class.
>> >>
>> >> Alan
>> >>
>> >>
>> >
>> >No go.. I've tried 2.6.20-1-amd64 (debian sid) and a vanilla 2.6.22=
-rc5.
>> >
>> >(The "problem" is that there are no options for that in the BIOS.
>> >The BIOS itself is only useful on these laptops, if you want to set=
 a
>BIOS
>> >password, setting the system clock or change the boot order... and
>nothing
>> >else)
>> >
>> >Thanks,
>> >=A0=A0=A0=A0=A0=A0=A0=A0Chr.
>> >-
