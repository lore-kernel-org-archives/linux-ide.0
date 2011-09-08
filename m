From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] achi, ata_generic: Add ASMedia ASM1061 support
Date: Thu, 08 Sep 2011 14:36:53 +0400
Message-ID: <4E689AC5.7020802@ru.mvista.com>
References: <1315453426-8796-1-git-send-email-kengyu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52947 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758153Ab1IHKhj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Sep 2011 06:37:39 -0400
In-Reply-To: <1315453426-8796-1-git-send-email-kengyu@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Keng-Yu Lin <kengyu@canonical.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Hello.

On 08-09-2011 7:43, Keng-Yu Lin wrote:

> ASM1061 PCI-E to SATA bridge controller has two variants.
> One works under AHCI and the other works with ata_generic.

> Add the PCI vendor ID and product IDs accordingly.

> Signed-off-by: Keng-Yu Lin<kengyu@canonical.com>
[...]
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f8910e1..87182b8 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2844,3 +2844,7 @@
>
>   #define PCI_VENDOR_ID_XEN		0x5853
>   #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
> +
> +#define PCI_VENDOR_ID_ASMEDIA		0x1b21
> +#define PCI_DEVICE_ID_ASM1061_IDE	0x0611
> +#define PCI_DEVICE_ID_ASM1061_AHCI	0x0612

    Adding new device IDs to that file is frowned upon. Define the device ID 
locally in the driver file, if you must. You don't even use the second one.

WBR, Sergei
