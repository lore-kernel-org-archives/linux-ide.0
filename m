From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv,adma: fix error when rmmod sata_nv
Date: Wed, 12 Dec 2007 17:18:19 +0900
Message-ID: <475F994B.9090505@gmail.com>
References: <200709251323031982245@gmail.com> <470FE47B.5060505@garzik.org> <cfaab6210710160108x1328086cse991f668e23e569e@mail.gmail.com> <47181CE1.4000802@garzik.org> <cfaab6210710182358t4de355f9wd6d605a7b8076ace@mail.gmail.com> <47185BFD.2010909@garzik.org> <cfaab6210710211855q7a2de35co13d3017b2a07d4cc@mail.gmail.com> <47352DD8.6040607@garzik.org> <47353AE8.5050900@garzik.org> <4735FFE6.6020705@shaw.ca> <15F501D1A78BD343BE8F4D8DB854566B1BFE2AAB@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:39363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267AbXLLISi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 03:18:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so244050wah.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 00:18:38 -0800 (PST)
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B1BFE2AAB@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuan Luo <kluo@nvidia.com>
Cc: Jeff Garzik <jeff@garzik.org>, peer chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>

Kuan Luo wrote:
> hi,
> The below error happens when i rmmod sata_nv in adma mode on ck804
> chipset with 2.6.24 kernel.
> I traced the code and found that the driver attempts to write device mem
> that has been unmapped.
> 
> Only simply removing the code" writew(0, mmio + NV_ADMA_CTL);" in the
> nv_adma_port_stop function or remove .port_stop field in nv_adma_ops,
> rmmod is ok.
> 
> static void nv_adma_port_stop(struct ata_port *ap)
> {
> 	struct nv_adma_port_priv *pp = ap->private_data;
> 	void __iomem *mmio = pp->ctl_block;
> 
> 	VPRINTK("ENTER\n");
> -	writew(0, mmio + NV_ADMA_CTL);
> }
> 
> Or
>  Place pcim_iomap_regions before ata_pci_prepare_native_host in
> nv_init_one function.
> This can guarantee that the code "writew(0, mmio + NV_ADMA_CTL) " write
> device mem before the device mem is unmapped.

Which kernel version are you using?  The following commit should have
fixed the problem.  Please give a shot at 2.6.24-rc5.  Thanks.

commit 32ebbc0c0d5d18c0135b55d1eb0029f48c54aff0
Author: Tejun Heo <htejun@gmail.com>
Date:   Thu Nov 8 13:09:00 2007 +0900

libata: port and host should be stopped before hardware resources are
released

-- 
tejun
