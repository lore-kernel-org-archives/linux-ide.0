From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset) - 2.6.14.2
Date: Wed, 23 Nov 2005 11:34:33 +0000
Message-ID: <438453C9.4050200@gentoo.org>
References: <4383DC5E.3050601@panoch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:2813 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965210AbVKWLej (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 06:34:39 -0500
In-Reply-To: <4383DC5E.3050601@panoch.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Panoch <jan@panoch.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Panoch wrote:
> Hi,
> 
> This patch adds additional Intel ICH7 DID's for Intel chipset 945G to
> the piix driver.
> I need to add PATA support for new intel 945G chipset on Asus
> motherboard P5LD2-VM.
> If acceptable, please apply.

PCI_DEVICE_ID_INTEL_ICH7_2 has been removed in 2.6.15 as it was unused.
Your patch is whitespace damaged (mailer ate the tabs?). You also need to send 
it to the linux-ide list and the IDE maintainer (see 
Documentation/SubmittingPatches). I don't think it will be accepted because 
this hardware is already supported by the ata_piix libata driver.

> 
> --- piix.c.orig 2005-11-23 11:46:12.000000000 +0100
> +++ piix.c      2005-11-23 11:13:02.000000000 +0100
> @@ -134,6 +134,7 @@
>                 case PCI_DEVICE_ID_INTEL_ESB_2:
>                 case PCI_DEVICE_ID_INTEL_ICH6_19:
>                 case PCI_DEVICE_ID_INTEL_ICH7_21:
> +               case PCI_DEVICE_ID_INTEL_ICH7_2:
>                 case PCI_DEVICE_ID_INTEL_ESB2_18:
>                         mode = 3;
>                         break;
> @@ -448,6 +449,7 @@
>                 case PCI_DEVICE_ID_INTEL_ESB_2:
>                 case PCI_DEVICE_ID_INTEL_ICH6_19:
>                 case PCI_DEVICE_ID_INTEL_ICH7_21:
> +               case PCI_DEVICE_ID_INTEL_ICH7_2:
>                 case PCI_DEVICE_ID_INTEL_ESB2_18:
>                 {
>                         unsigned int extra = 0;
> @@ -575,6 +577,7 @@
>         /* 21 */ DECLARE_PIIX_DEV("ICH7"),
>         /* 22 */ DECLARE_PIIX_DEV("ICH4"),
>         /* 23 */ DECLARE_PIIX_DEV("ESB2"),
> +       /* 24 */ DECLARE_PIIX_DEV("ICH7"),
>  };
> 
>  /**
> @@ -651,6 +654,7 @@
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 21},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 23},
> +       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_2, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 24},
>         { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
> 

