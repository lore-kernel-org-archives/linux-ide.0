From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Fri, 05 Mar 2010 14:43:43 -0500
Message-ID: <4B915EEF.1040307@garzik.org>
References: <20100301202330.GA14977@havoc.gtf.org> <201003051958.24987.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51207 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab0CETn6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 14:43:58 -0500
In-Reply-To: <201003051958.24987.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>

On 03/05/2010 01:58 PM, Bartlomiej Zolnierkiewicz wrote:
> On Monday 01 March 2010 09:23:30 pm Jeff Garzik wrote:
>
>>        libata: Pass host flags into the pci helper
>
> It introduces a subtle bug:
>
> struct ata_host {
> ...
> 	unsigned long		flags;
>
>> @@ -1642,8 +1643,8 @@ extern int ata_pci_sff_activate_host(struct ata_host *host,
>>   				     irq_handler_t irq_handler,
>>   				     struct scsi_host_template *sht);
>>   extern int ata_pci_sff_init_one(struct pci_dev *pdev,
>> -				const struct ata_port_info * const * ppi,
>> -				struct scsi_host_template *sht, void *host_priv);
>> +		const struct ata_port_info * const * ppi,
>> +		struct scsi_host_template *sht, void *host_priv, int hflags);
>
> 'int' type is not equal 'unsigned long' one on 64-bit architectures.

True but largely irrelevant as we will never use more than 32 bits worth 
of host flags.


> Besides doing it this way is clearly suboptimal as the same effect
> could have been achieved by doing:
>
> extern int __ata_pci_sff_init_one(struct pci_dev *pdev,
> 				const struct ata_port_info * const *ppi,
> 				struct scsi_host_template *sht, void *host_priv,
> 				int hflag);
> static inline int ata_pci_sff_init_one(struct pci_dev *pdev,
> 				const struct ata_port_info * const *ppi,
> 				struct scsi_host_template *sht, void *host_priv)
> {
> 	return __ata_pci_sff_init_one(pdev, ppi, sht, host_priv, 0);
> }

This is far uglier than simply changing the API.


> without the need to update all drivers and without breaking pending
> out-of-tree driver patches (yeah, it breaks my pata_ep93xx patches)..

Every post you include a disclaimer about "my patches are not intended 
for upstream" yet you still complain?

Some people are never satisfied...

	Jeff


