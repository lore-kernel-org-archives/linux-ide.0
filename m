From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: [PATCH 4/4]: [PCI]: Add MSI INTX_DISABLE quirks for ATI
 SB700/800 SATA and IXP SB400 USB
Date: Wed, 24 Oct 2007 14:43:21 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A507055D936C@sshaexmb1.amd.com>
References: <20071023.195343.35661973.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:40253 "EHLO
	outbound5-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754147AbXJXGqB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 02:46:01 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20071023.195343.35661973.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org, brice@myri.com, mchan@broadcom.com, Shane Huang <Shane.Huang@amd.com>

This patch and the third one seems can make my SB700 SATA controller
work under MSI(simply tested on 2.6.23-rc5). 

So you may withdraw the RS690/RD580/RX790 MSI disablement patches
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=4be8f906435a6af241821ab5b94b2b12cb7d57d8
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=aea6a433f50cd89b9cbd10850fd0b32f961f9883
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=f122392f679ebed39db08074f935d770504623eb
after the commit of these MSI/INTx quirks.

Thanks
Shane

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Wednesday, October 24, 2007 10:54 AM
> To: linux-kernel@vger.kernel.org
> Cc: jeff@garzik.org; barkalow@iabervon.org; linas@austin.ibm.com;
chunhao.huang@hotmail.com; gregkh@suse.de; htejun@gmail.com;
> brice.goglin@gmail.com; david.gaarenstroom@gmail.com;
linux-pci@atrey.karlin.mff.cuni.cz; Shane Huang;
linux-ide@vger.kernel.org;
> brice@myri.com; mchan@broadcom.com
> Subject: [PATCH 4/4]: [PCI]: Add MSI INTX_DISABLE quirks for ATI
SB700/800 SATA and IXP SB400 USB
> 
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  drivers/pci/quirks.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 591eaa4..5795a3d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1725,4 +1725,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
>  			PCI_DEVICE_ID_TIGON3_5714S,
>  			quirk_msi_intx_disable_bug);
> 
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4390,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4391,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4392,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4393,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4394,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4395,
> +			quirk_msi_intx_disable_bug);
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4373,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4374,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4375,
> +			quirk_msi_intx_disable_bug);
> +
>  #endif /* CONFIG_PCI_MSI */
> --
> 1.5.3.4
> 
> 



