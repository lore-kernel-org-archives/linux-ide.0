From: "Michael Chan" <mchan@broadcom.com>
Subject: Re: [PATCH 3/4]: [PCI]: Add quirk for devices which disable MSI
 when INTX_DISABLE is set.
Date: Tue, 23 Oct 2007 21:59:39 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC002AABB0A@nt-irva-0751.brcm.ad.broadcom.com>
References: <20071023.195310.131105752.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:1538 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbXJXE75 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 00:59:57 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20071023.195310.131105752.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: jeff@garzik.org, barkalow@iabervon.org, linas@austin.ibm.com, chunhao.huang@hotmail.com, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, linux-ide@vger.kernel.org, brice@myri.com

David Miller wrote:

> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> +			PCI_DEVICE_ID_TIGON3_5780,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> +			PCI_DEVICE_ID_TIGON3_5780S,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> +			PCI_DEVICE_ID_TIGON3_5714,
> +			quirk_msi_intx_disable_bug);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> +			PCI_DEVICE_ID_TIGON3_5714S,
> +			quirk_msi_intx_disable_bug);
> +

Please add PCI_DEVICE_ID_TIGON3_5715 and
PCI_DEVICE_ID_TIGON3_5715S as well.

Other than that,
Acked-by: Michael Chan <mchan@broadcom.com>

