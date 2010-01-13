From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
 Cougar Point DeviceIDs
Date: Wed, 13 Jan 2010 12:08:42 -0500
Message-ID: <4B4DFE1A.4000606@pobox.com>
References: <201001121700.18234.seth.heasley@intel.com>	<4B4D4EAA.2010109@gmail.com> <4B4DAA68.60608@pobox.com> <m3my0i6nou.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59356 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0AMRIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2010 12:08:45 -0500
In-Reply-To: <m3my0i6nou.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Robert Hancock <hancockrwd@gmail.com>, Seth Heasley <seth.heasley@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/13/2010 10:15 AM, Krzysztof Halasa wrote:
> Jeff Garzik<jgarzik@pobox.com>  writes:
>
>> Well, two lines of thinking here:
>>
>> * some of lines of Intel chips do not separate AHCI into a separate
>> PCI ID rather legacy IDE interface.  When an AHCI interface exists and
>> AHCI/IDE share the same PCI ID, we default to using AHCI.  Thus, some
>> of those PCI ID matches in ahci.c's PCI table may not get caught by
>> the generic PCI class match at the end of the table.
>>
>> * the cost carrying redundant PCI IDs seems low, harmless, and
>> potentially helpful.
>
> Also people may use things like this:
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index a3241a1..0616bbb 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -561,9 +561,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
>   	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>
> +#ifdef DOESNT_WORK_FOR_ME
>   	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>   	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
> +#endif
>
>   	/* ATI */
>   	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_sb600 }, /* ATI SB600 */
> @@ -667,9 +669,11 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	/* Promise */
>   	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
>
> +#ifdef DOESNT_WORK_FOR_ME
>   	/* Generic, PCI class code for AHCI */
>   	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
> +#endif
>

I'm not sure I understand your point.  Are there ahci problems with the 
generic entries, that remain unresolved?

	Jeff




