From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2.6.39-rc3] ahci: AHCI-mode SATA patch for Intel Panther
 Point DeviceIDs
Date: Wed, 20 Apr 2011 14:05:55 +0400
Message-ID: <4DAEB003.8020304@ru.mvista.com>
References: <201104191638.41267.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41791 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab1DTKHd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Apr 2011 06:07:33 -0400
In-Reply-To: <201104191638.41267.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 20-04-2011 3:38, Seth Heasley wrote:

> This patch adds the AHCI-mode SATA DeviceIDs for the Intel
> Panther Point PCH.

> Signed-off-by: Seth Heasley <seth.heasley@intel.com>

> --- linux-2.6.39-rc3/drivers/ata/ahci.c.orig	2011-04-11
> 17:21:51.000000000 -0700
> +++ linux-2.6.39-rc3/drivers/ata/ahci.c	2011-04-14
> 11:59:24.000000000 -0700
> @@ -261,6 +261,12 @@
>   	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
>   	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
>   	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC
> AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point
> AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther Point
> AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point
> RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point
> RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point
> RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther Point
> RAID */

    The patch is line wrapped.

WBR, Sergei
