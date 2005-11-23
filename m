From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: Re: [PATCH] PATA support for Intel ICH7 (intel 945G chipset)
Date: Wed, 23 Nov 2005 12:31:48 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F50574A62D@orsmsx410>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:45762 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932381AbVKWUci convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 15:32:38 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jan@panoch.net
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan,

DeviceID 0x27c0 is the ICH7 SATA controller DID.  It should not be added
to the PATA IDE piix driver.  It is already supported in the SATA
ata_piix driver.  If you are not seeing the PATA controller DID 0x27df,
then your BIOS is most likely set to combined mode.  Change your BIOS to
SATA enhanced mode.  If your BIOS does not support enhanced mode,
contact your motherboard manufacturer.

Thanks,

Jason


Jan Panoch wrote:
> Hi,
> 
> This patch adds additional Intel ICH7 DID's for Intel chipset 945G to
> the piix driver.
> I need to add PATA support for new intel 945G chipset on Asus
> motherboard P5LD2-VM.
> If acceptable, please apply.
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
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21,
PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 21},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 22},
>         { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18,
PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 23},
> +       { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_2, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 24},
>         { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
> 

