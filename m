From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Sil3114 and Hitachi disks
Date: Fri, 24 Dec 2004 23:46:58 -0500
Message-ID: <20041225044658.GB25088@havoc.gtf.org>
References: <Pine.LNX.4.44.0412241621210.16199-100000@kenzo.iwr.uni-heidelberg.de> <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([63.115.148.101]:26838 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261489AbULYErA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2004 23:47:00 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412241822560.16199-100000@kenzo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org

On Fri, Dec 24, 2004 at 06:49:42PM +0100, Bogdan Costescu wrote:
> On Fri, 24 Dec 2004, Bogdan Costescu wrote:
> 
> > - the combination of x86_64 kernel, sata_sil and the Hitachi disks is
> > not good; the corruption seems to appear while writting to disk.  
> 
> I've gotten some more inspiration just after I sent the message...
> 
> The Sil3114 appears on the PCI bus as a 32-bit 66MHz device, therefore
> it should use IOMMU with >4Gb RAM. Booting the x86_64 kernel with
> "mem=2048m" makes the corruption go away; the difference is that the
> IOMMU is automatically disabled by the kernel:

Does 2.4.29-pre3 or 2.6.10 work for you?

	Jeff



