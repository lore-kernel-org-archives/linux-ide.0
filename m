From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: IDE channels not independent in PIIX4E?
Date: Fri, 25 Feb 2005 09:45:37 -0500
Message-ID: <87f94c37050225064563f663c5@mail.gmail.com>
References: <e6dt11lj3pt9v7hl0luqseris0fs2kvr7v@4ax.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:28035 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262711AbVBYOpi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Feb 2005 09:45:38 -0500
Received: by wproxy.gmail.com with SMTP id 68so465023wra
        for <linux-ide@vger.kernel.org>; Fri, 25 Feb 2005 06:45:38 -0800 (PST)
In-Reply-To: <e6dt11lj3pt9v7hl0luqseris0fs2kvr7v@4ax.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: GrantC <grant_nospam@dodo.com.au>
Cc: linux-ide@vger.kernel.org

I can't speak to your specific motherboard/chipset, but the
performance testing I have done shows that the onboard IDE controllers
do not have two independent channels, so using both channels does not
provide twice the speed of a single channel, not even close.

True under both Linux and Windows2K.

OTOH, I have tested 3 or 4 PCI-based Dual Channel IDE controllers and
they work much better from a performance perspective.  I recently
tested both the SIIG dual-channel card and Adaptec dual-channel card. 
They were both in the $50-$60 range and neither has given me any
problems, but I have heard people complain about the SIIG.

HTH
Greg


On Fri, 25 Feb 2005 16:47:46 +1100, GrantC <grant_nospam@dodo.com.au> wrote:
> Greetings,
> 
> I have an old but reliable Intel SE440BX-2 with 440BX and PIIX4E
> chipset.  120 + 80 GB hard drives on each channel as master, very
> disappointing md software RAID0 or RAID1 performance.
> 
> Slackware 10.1 with 2.4.29 or 2.4.30pre2, testing back to 2.4.21.
> 
> One thing I noticed is that if I start a
> 
>   dd if=/dev/zero bs=4k of=/dev/hdX
> 
> on each drive, then Ctrl-C stop each, one terminal will wait for
> the other drive to complete the write before starting its turn
> to complete the pending write.
> 
> It seems that somewhere what I expected to be two parallel data
> streams are serialised.  As the chipset only does udma33 I was
> hoping to get an OS performance gain with RAID0.  Box has 512MB
> memory and rarely touches swap.
> 
> Is this a limit of the hardware or did I miss some kernel tuning?
> 
> Have benchmarked with tiobench -- that tells me chunk-size has
> little effect, software RAID costs about 8% CPU, and sequential
> writes cost roughly 20%, 40% and 60% for ext2, ext3 and reiserfs.
> 
> Filesystem sequential read speed improved from 17 to 25 MB/s for
> RAID0, but no improvement in write speed.
> 
> Raw (non-filesystem) dd speeds are about 27MB/s read, 20MB/s write
> to non-RAID partition.  All testing done on same partitions, so
> no confusion with fast or slow end of drive.  The drives are
> Seagate 7200.7 series with 2MB cache.
> 
> Any pointers on tuning options appreciated, the Intel datasheets
> don't really tell me much.  As for reading the kernel source, I
> have no idea where to start, not much under Docs, and I dunno
> which or which way to turn the 'knobs'.
> 
> Even search terms would be welcome :)
> 
> Thanks,
> Grant.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
