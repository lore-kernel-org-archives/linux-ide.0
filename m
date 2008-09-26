From: "Grant Grundler" <grundler@google.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Fri, 26 Sep 2008 09:04:23 -0700
Message-ID: <da824cf30809260904u69ed46acpa3a6fef2a4ed170e@mail.gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com>
	 <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com>
	 <20080921001529.23400.qmail@science.horizon.com>
	 <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com>
	 <48DA0C8B.3000406@gmail.com>
	 <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com>
	 <20080925032437.6802.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:16936 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYIZQFG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Sep 2008 12:05:06 -0400
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com [172.24.198.88])
	by smtp-out.google.com with ESMTP id m8QG4QqZ015934
	for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2008 17:04:26 +0100
Received: from ug-out-1314.google.com (ugey2.prod.google.com [10.66.176.2])
	by wpaz24.hot.corp.google.com with ESMTP id m8QG4OnE028644
	for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2008 09:04:24 -0700
Received: by ug-out-1314.google.com with SMTP id y2so451528uge.35
        for <linux-ide@vger.kernel.org>; Fri, 26 Sep 2008 09:04:23 -0700 (PDT)
In-Reply-To: <20080925032437.6802.qmail@science.horizon.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, htejun@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com

On Wed, Sep 24, 2008 at 8:24 PM, George Spelvin <linux@horizon.com> wrote:
> Just a little followup... I currently have the machine with 8 GB RAM,
> all 4 SB600 channels populated, and 64-bit DMA enabled, operating in
> production.  No problems so far.
>
> Q: Does the fact that I'm using the GART IOMMU mean that I'm not really using
> 64-bit DMA at all?

If pci_dev->dma_mask has more bits set than the highest physical
memory address, then the GART will not be used for that device.

See "need_iommu()" in arch/x86/kernel/pci-gart_64.c and how that's
used in gart_map_single().

My assumption is libata will not override something the PCI device driver sets.

hth,
grant
