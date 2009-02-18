From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: sata_nv frees DMA memory with different size (possibly a
 generic libata bug)
Date: Wed, 18 Feb 2009 17:05:44 -0500
Message-ID: <20090218170544.714e53a8@dhcp-100-2-144.bos.redhat.com>
References: <4994E30A.3040501@gmail.com>
	<20090216163637.18dd315c@dhcp-100-2-144.bos.redhat.com>
	<499A26B7.80807@gmail.com>
	<20090217202156B.fujita.tomonori@lab.ntt.co.jp>
	<20090218152516.7b4457b3@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:59954 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbZBRWI5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Feb 2009 17:08:57 -0500
In-Reply-To: <20090218152516.7b4457b3@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: hancockrwd@gmail.com, linux-ide@vger.kernel.org

On Wed, 18 Feb 2009 15:25:16 -0500
Chuck Ebbert <cebbert@redhat.com> wrote:

> On Tue, 17 Feb 2009 20:22:05 +0900
> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> 
>  
> > > >>> sata_nv 0000:00:0d.0: DMA-API: device driver frees DMA memory with different
> > > >>> size [device address=0x00000000da031000] [map size=4096 bytes] [unmap
> > > >> That's rather curious. It seems to be saying that the sg length is 
> > > >> different between the map and unmap, but it doesn't look like sata_nv 
> > > >> mucks with that anywhere, and neither does libata core..
> > > > 
> > > > Could the SCSI code have merged two requests?
> > > 
> > > I wouldn't think so.. and if it did it seems like it would have to have 
> > > changed the list after libata got the request somehow..
> > 
> > Does this box uses GART IOMMU?
> 
> I don't think so, but I've asked for the dmesg.

Okay, it _is_ using GART IOMMU:

DMA-API: preallocated 8192 debug entries
DMA-API: debugging enabled by kernel config
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 20000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture

