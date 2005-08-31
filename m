From: Brett Russ <russb@emc.com>
Subject: Re: [RFC][PATCH 2.6.13] Marvell SATA support (PIO mode)
Date: Wed, 31 Aug 2005 07:37:41 -0400
Message-ID: <43159685.5010405@emc.com>
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com> <43158800.6010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:53722 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932413AbVHaLls
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Aug 2005 07:41:48 -0400
In-Reply-To: <43158800.6010303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>> +static struct pci_device_id mv_pci_tbl[] = {
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
>> +
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
>> +    {PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
>> +    {}            /* terminate list */
>> +};
>> <http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>
>>
> MODULE_DEVICE_TABLE(pci, 
> <http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>mv_pci_tbl);  here for 
> hotplug

Thanks Jiri,

All the MODULE_ stuff is at the bottom of the file, including 
MODULE_DEVICE_TABLE.  What inserted those URLs?

BR
