From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Sun, 7 Aug 2005 23:02:39 -0400
Message-ID: <20050808030239.GA27502@havoc.gtf.org>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:7865 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750706AbVHHDCp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Aug 2005 23:02:45 -0400
Content-Disposition: inline
In-Reply-To: <42F6B8CD.4050100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andreas =?iso-8859-1?Q?Kl=F6ckner?= <inform@tiker.net>, linux-ide@vger.kernel.org

On Mon, Aug 08, 2005 at 10:43:41AM +0900, Tejun Heo wrote:
>  I don't know much about PATA support.  All I know is that ICH's seem 
> to generate a lot of noise in this mailing list w/ its legacy, combined, 
> ahci and whatever modes and no one setting seems to satisfy all.  (If 
> anyone knows more about it, please fill in here.)

Combined mode aggregates the PATA and SATA devices into a single PCI
device.  The chosen solution was to use the IDE driver for PATA, and
libata for SATA.

This was necessary since ATAPI support did not exist in libata (nor did
SATAPI devices exist).  An unfortunate side effect is that only one
driver could have access to the busmaster DMA registers -- libata --
which meant that the IDE driver was limited to PIO data xfer for PATA.

Once ATAPI support is mature in libata, we can support PATA fully in
libata, and eliminate this PATA speed limitation in combined mode.

	Jeff



