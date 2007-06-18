From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 10:57:57 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE07016FE477@orsmsx420.amr.corp.intel.com>
References: <200706181552.37776.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23469 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761054AbXFRR56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 13:57:58 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200706181552.37776.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chr <chunkeey@web.de>, linux-ide@vger.kernel.org

=46YI: DID 2850 is the PATA IDE controller.  Most likely, the laptop do=
es not have SATA drives and is running off of PATA. =20

The old IDE subsystem (piix.c) is where I added that PATA DID to.
#define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850 in pci_ids.h

Jason



>-----Original Message-----
>From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>owner@vger.kernel.org] On Behalf Of Chr
>Sent: Monday, June 18, 2007 6:53 AM
>To: linux-ide@vger.kernel.org
>Cc: chunkeey@web.de
>Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
>
>On Monday, 18. June 2007, Alan Cox wrote:
>> On Mon, 18 Jun 2007 15:20:06 +0200
>> Chr <chunkeey@web.de> wrote:
>>
>> > Hi,
>> >
>> > I got a new laptop and I had a little problem that the DVD drive w=
asn't
>recognized by
>> > libata's piix driver (but the old IDE Subsystem found it!).
>> >
>> > So, after adding the new pciid 8086:2850 it works!
>> > But, I don't know if it's ich_pata_100 or ich_pata_133 since the
>> > dvd/cd drives only goes up to udma2 speeds.
>>
>> Its ich_pata_133 - all the newer chips are. They work even better if=
 you
>> set them into AHCI mode in the BIOS and then they should "just work"=
 with
>> recent kernels as the AHCI driver now matches by class.
>>
>> Alan
>>
>>
>
>No go.. I've tried 2.6.20-1-amd64 (debian sid) and a vanilla 2.6.22-rc=
5.
>
>(The "problem" is that there are no options for that in the BIOS.
>The BIOS itself is only useful on these laptops, if you want to set a =
BIOS
>password, setting the system clock or change the boot order... and not=
hing
>else)
>
>Thanks,
>=A0=A0=A0=A0=A0=A0=A0=A0Chr.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
