From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: request for SiS SATA hard disk controller 966 rev. 1183 windows
 driver
Date: Tue, 06 May 2008 17:32:07 +0200
Message-ID: <482079F7.7060109@gmx.net>
References: <602D57F60B6F41499FD3A4E0A96AD1FD@willpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763677AbYEFPcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 11:32:10 -0400
In-Reply-To: <602D57F60B6F41499FD3A4E0A96AD1FD@willpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guglielmo Fanini <g.fanini@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

the SiS 966 SATA-controller in PATA emulation mode (0x1183) is supported 
in Linux Kernel.
Please have a look into drivers/ata/sata_sis.c. There you can find the 
necessary ID.
I have checked 2.6.22 and 2.6.25. Which kernel do you want to try?
I am reading something about windows in the subject. What are you really 
searching for?

Uwe


> I found on http://www.sis.com/aboutsis/aboutsis_index05_01.htm a SATA 
> driver 411a.zip but it is for chipset 966 revisions 1182, 1184, I have 
> chip revision 1183, can you ask SiS where to find the driver ?
>
> I found on http://driver.sis.com/linux/raid/sis18x_20060508.zip
>
> static struct pci_device_id sis_pci_tbl[] = {
> { PCI_VENDOR_ID_SI, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> { PCI_VENDOR_ID_SI, 0x0181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> { PCI_VENDOR_ID_SI, 0x0182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> { PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> { PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>
> { PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
>
> { PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
> { } /* terminate list */
> };
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

