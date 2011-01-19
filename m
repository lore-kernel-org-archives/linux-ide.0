From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.3.37] ahci: AHCI mode SATA patch for Intel DH89xxCC
 DeviceIDs
Date: Tue, 18 Jan 2011 20:00:38 -0500
Message-ID: <4D3637B6.4040107@pobox.com>
References: <201101101257.17449.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60886 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1ASBAl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 20:00:41 -0500
In-Reply-To: <201101101257.17449.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/10/2011 03:57 PM, Seth Heasley wrote:
> This patch adds the AHCI-mode SATA DeviceID for the Intel DH89xxCC PCH.
>
> Signed-off-by: Seth Heasley<seth.heasley@intel.com>
>
> --- linux-2.6.37/drivers/ata/ahci.c.orig	2011-01-04 16:50:19.000000000 -0800
> +++ linux-2.6.37/drivers/ata/ahci.c	2011-01-06 14:16:00.000000000 -0800
> @@ -260,6 +260,7 @@
>   	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
>   	{ PCI_VDEVICE(INTEL, 0x1d04), board_ahci }, /* PBG RAID */
>   	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
> +	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>

applied


