From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.32.3] ahci: AHCI and RAID mode SATA patch for Intel
 Cougar Point DeviceIDs
Date: Wed, 20 Jan 2010 14:28:49 -0500
Message-ID: <4B575971.2090009@pobox.com>
References: <201001121700.18234.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:61340 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab0ATT2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:28:51 -0500
In-Reply-To: <201001121700.18234.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/12/2010 08:00 PM, Seth Heasley wrote:
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

applied this, and the ata_piix patch


