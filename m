From: Fontana Cristian <fontana_cristian@yahoo.com>
Subject: Re: DMA timeouts with JM20330 based SATA<->IDE bridge
Date: Fri, 28 Jun 2013 12:16:47 +0000 (UTC)
Message-ID: <loom.20130628T140844-269@post.gmane.org>
References: <20100304014558.GA8837@florz.florz.dyndns.org> <20100304214203.GA3353@florz.florz.dyndns.org> <20100304230219.GA3882@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60362 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab3F1MUG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jun 2013 08:20:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1UsXem-0002zc-Dp
	for linux-ide@vger.kernel.org; Fri, 28 Jun 2013 14:20:05 +0200
Received: from 190.183.21.218 ([190.183.21.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2013 14:20:04 +0200
Received: from fontana_cristian by 190.183.21.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2013 14:20:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Florian Zumbiehl <florz <at> florz.de> writes:

> 
> Hi,
> 
> > > Now, reading from the disk seems to work perfectly, but writing
> > > (dding /dev/zero to the block device) causes DMA timeouts every
> > > few hundred megabytes - in between the timeouts, though,
> > > throughput seems to be ok (~ 20 MB/s).
> > > 
> > > Once the fallback mechanism has switched back to PIO4, things seem
> > > to work perfectly, albeit slowly 
> > 
> > FYI: I just tried forcing the device to MWDMA2, and that seems to work
> > well, too - wrote some 10 GB without any errors.
> 
> Yet another piece of information: Writing in 4 KiB or 8 KiB blocks
> in UDMA/66 mode (using dd if=/dev/zero of=/dev/sdc bs=4k oflag=direct)
> seems to work well, too, 16 KiB causes the problems described.
> 
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Hello, I have exactly the same problem as yours using JM20330. I tried to 
force the device to MWDMA2 but I had success.
you could solve the problem?
could be done to limit the maximum kb block?

I appreciate any help the
(sorry for my English)

fontana cristian

