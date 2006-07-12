From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: + sata-add-pci-id.patch added to -mm tree
Date: Wed, 12 Jul 2006 11:04:07 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE070C11B4@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3588 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932295AbWGLSNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jul 2006 14:13:11 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org
Cc: helms.adam@gmail.com, htejun@gmail.com, linux-ide@vger.kernel.org

I agree with Jeff on this and do not want to see 0x27c0 in the AHCI
driver as with this DID the controller is in IDE mode.

Note:  82801GB(ICH7) does not support AHCI mode.  If you have this SKU,
you will not see AHCI available in the BIOS.  You need to have an
82801GR(ICH7R) or an 82801GH(ICH7DH) for AHCI mode.  All three of these
SKU's share the same IDE mode DID.

Thanks,

Jason



>-----Original Message-----
>From: Jeff Garzik [mailto:jeff@garzik.org]
>Sent: Wednesday, July 12, 2006 10:47 AM
>To: akpm@osdl.org; Gaston, Jason D
>Cc: helms.adam@gmail.com; htejun@gmail.com; linux-ide@vger.kernel.org
>Subject: Re: + sata-add-pci-id.patch added to -mm tree
>
>akpm@osdl.org wrote:
>> Subject: SATA: Add PCI-ID
>> From: "Adam Helms" <helms.adam@gmail.com>
>>
>> Makes the AHCI driver detect the PCI ID 8086:27c0 (IDE interface:
Intel
>> Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controller
IDE
>> (rev 01)) as an AHCI chipset.
>>
>> 8086:27c0 also works with ata_piix but it's much slower.  8086:27c0
is
>> shipped with - among others - new HP Proliant servers.
>
>> diff -puN drivers/scsi/ahci.c~sata-add-pci-id drivers/scsi/ahci.c
>> --- a/drivers/scsi/ahci.c~sata-add-pci-id
>> +++ a/drivers/scsi/ahci.c
>> @@ -291,6 +291,8 @@ static const struct pci_device_id ahci_p
>>  	  board_ahci }, /* ICH6 */
>>  	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>>  	  board_ahci }, /* ICH6M */
>> +	{ PCI_VENDOR_ID_INTEL, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>> +	  board_ahci }, /* ICH7 */
>>  	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>>  	  board_ahci }, /* ICH7 */
>>  	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>
>This patch needs discussing with Intel.
>
>0x27c0 was intentionally omitted, because it is only supposed to show
up
>when the device is configured into IDE mode.
>
>If the user (read: BIOS) has chosen to configure the device in AHCI
>mode, it should show up as a different PCI ID, which ahci.c already
>contains.
>
>I'm inclined to NAK the patch, since things appear to be working as
>expected.
>
>	Jeff
