From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: PROBLEM REMAINS: [sata_nv ADMA breaks ATAPI]
	Crash	on	accessing DVD-RAM
Date: Sun, 13 Jan 2008 10:51:42 -0600
Message-ID: <1200243102.3179.27.camel@localhost.localdomain>
References: <fa.krOVfyFmB2aqGjJIoHCLmQxecWc@ifi.uio.no>
	 <478702C7.80401@shaw.ca> <47887982.6050805@mail.ru>
	 <47891426.1020604@shaw.ca> <1200170117.3656.66.camel@localhost.localdomain>
	 <47894785.2050508@shaw.ca> <1200180440.3656.76.camel@localhost.localdomain>
	 <47896BA8.4030609@shaw.ca> <20080113133317.50ad4bda@lxorguk.ukuu.org.uk>
	 <1200238725.3179.16.camel@localhost.localdomain>
	 <20080113162959.01d519db@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753377AbYAMQv7@vger.kernel.org>
In-Reply-To: <20080113162959.01d519db@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, Alexander <aledin@mail.ru>, linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org


On Sun, 2008-01-13 at 16:29 +0000, Alan Cox wrote:
> > Yes, I concur for the short term.  The other two possible courses of
> > action either involve long discussions (the different device one) or
> > you'll never quite be sure you got all the paths (the GFP_DMA32 one).
> > At least with this one, you know everything will work.
> 
> The different device one is tricky because the PCI layer is involved in
> mapping on some systems so you can't just magic up a platform device for
> it. Putting a mask on the block queue might perhaps work as a model
> which avoids breaking stuff by suprise, with the device left at 32bit
> masking.

Actually, you might be able to ... that's why I'm suggesting it.  There
are two pieces of information the arch layer needs to know:  what is the
dma_mask and where is the iommu/bridge/whatever.  When we went to the
generic dma_map_ API on parisc, we found you simply get the one from
struct device and for the other you walk up the device tree until you
find what you're looking for.

I'm not suggesting we invent a dummy pci_device ... I'm suggesting we
dma_map on the existing scsi_device, which is properly parented to the
pci_device.  The problem with this approach will be any architecture
which blindly expects dma_map converts to pci_dma_map; however, I'm not
sure we have any of those left.

James


