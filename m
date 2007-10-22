From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: sata sil3114 vs. certain seagate drives results in filesystem
	corruptions
Date: Mon, 22 Oct 2007 10:36:32 +0000
Message-ID: <1193049392.10246.29.camel@localhost>
References: <1192863324.5720.162.camel@localhost>
	 <471C071C.2010202@gmail.com>  <200710221148.08809.bs@q-leap.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:34110 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbXJVKgf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 06:36:35 -0400
In-Reply-To: <200710221148.08809.bs@q-leap.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernd Schubert <bs@q-leap.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Mon, 2007-10-22 at 11:48 +0200, Bernd Schubert wrote:
> Hello,
> 
> On Monday 22 October 2007 04:12:44 Tejun Heo wrote:
> > Helo,
> > [...]
> > > Now when I write large files of zeros to root(sda&sdb) and read the file
> > > back in it contains a few nonzero entries:
> > >
> > > # dd if=/dev/zero of=/foo bs=1M count=2000
> > > # hexdump /foo
> > > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > > *
> > > <after >1GB random parts, within large blocks of zeroes>
> > >
> > > I can reliably trigger this on the md0 / devmapper-root setup when I
> > > write about 2GB of data (note that this machine has 1.5G of memory - and
> > > still 1GB is often enough to see this problem). Here it does not matter
> > > where in the filesystem I do these writes.
> 
> Thats almost the same test as I'm always doing. Only I do not write only 2GB, 

Well when I read your mail I thought that I could be seeing exactly the
same bug... it still may be. However ``my'' problem does not go away
with the mod15fix ...

> but as much as it fits onto the disk. On reading back this file, the 
> filesystem will report errors somewhere between 50GB and 230GB (disk size is 
> 250GB).

Wow, I really see lots of corruptions (well every 1-2 GB a couple of
bytes are corrupted). Are you getting similiarly many in the 50G - 230G
region?

> > Thanks.  I'll try to reproduce the problem here.  What's your motherboard?
> 
> All tested S2882 boards here.

I assume all equipped with lots of memory and mostly empty pci slots?

Soeren
