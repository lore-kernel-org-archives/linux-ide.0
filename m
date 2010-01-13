From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
 Cougar Point DeviceIDs
Date: Tue, 12 Jan 2010 22:40:10 -0600
Message-ID: <4B4D4EAA.2010109@gmail.com>
References: <201001121700.18234.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:52372 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0AMEkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 23:40:15 -0500
In-Reply-To: <201001121700.18234.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/12/2010 07:00 PM, Seth Heasley wrote:
> This patch adds the Intel Cougar Point (PCH) SATA AHCI and RAID Controller DeviceIDs.
>
> Signed-off-by: Seth Heasley<seth.heasley@intel.com>
>
> --- linux-2.6.32.3/drivers/ata/ahci.c.orig	2010-01-06 15:07:45.000000000 -0800
> +++ linux-2.6.32.3/drivers/ata/ahci.c	2010-01-07 13:55:23.000000000 -0800
> @@ -560,6 +560,12 @@
>   	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
>   	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */
>   	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
>
>   	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>   	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

The RAID mode entries would be needed if the device indicates RAID class 
in that mode, but in plain AHCI mode it should indicate SATA AHCI class 
which will get picked up by this catch-all so those entries shouldn't be 
needed:

         /* Generic, PCI class code for AHCI */
         { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
           PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

Likely a lot of the existing specific PCI IDs could be removed from the 
driver because of this (many likely predate the addition of the 
class-based catch-all). The only reason to need a specific entry if the 
device uses AHCI class is if it needs special handling or workarounds, 
which isn't the case here.
