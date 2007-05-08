From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
Date: Tue, 08 May 2007 16:42:19 +0200
Message-ID: <46408C4B.8020401@gmail.com>
References: <46362672.7080103@gmx.net> <4636DCA9.9050803@gmail.com> <4636FBB7.3030605@gmx.net> <463AE631.9030701@gmail.com> <463B7903.4070206@gmx.net> <463EE239.8060709@gmail.com> <463F634E.2070103@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:39328 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968187AbXEHOma (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 10:42:30 -0400
Received: by py-out-1112.google.com with SMTP id a29so1499472pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 07:42:30 -0700 (PDT)
In-Reply-To: <463F634E.2070103@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Beichl <daniel_beichl@gmx.net>
Cc: linux-ide@vger.kernel.org

Hello,

Daniel Beichl wrote:
> I gave the whole thing some thought. You suspected the sil dma engine to
> cause the issue, because it might only be usable with a certain command
> packet size.
> If these commands result in packets their size is not zero. Not all
> packet commands transfer
> data sectors, but they themselves have a size.
> 
> So i investigated libata and learnt from libata-scsi.c that nbytes is
> set to the size of the scsi
> command corresponding to the atapi command that should be sent to the
> device near the end of atapi_xlat().
> 
> I added code to dump the packet size and data direction as set in the
> scsi command and noticed that the
> controller freezes the port if a packet with the direction DMA_TO_DEVICE
> and a length smaller than ~60 bytes is issued, the command type does not
> matter at all.

Hmmmmm.... This is weird.  < ~60 bytes?  The zero-length protocol thing
is a plain bug but this is something completely different.  Can you test
this with a different controller?  Is the problem always reproducible?

> I tried this with the cdrecord -atip option which generate packets of
> command cdb[0] = 0x00, length 60 and 16 in said direction.
> The first command succeeds, the second one triggers the dma bug.
> 
> The question now is, is the dma engine of the sil chip indeed the
> problem, or did i cover
> another problem located somewhere else by restricting dma to packets not
> smaller than 60 bytes.
> The datasheet of the sil3512 does not specify a lower limit for dma
> transfers.
> 
> It does not appear to be a modulo N issue either as i have seen the
> transfer of
> packets of 12 or 16 bytes fail but then again packets of 60 bytes succeeds.
> 
> size       result
> ==========
> 001100 fail
> 010000 fail
> 111100 succeed
> 
> A thing that crossed my mind was a timing issue. Perhaps the dmaing of <
> 60 bytes is that
> fast that the interrupt that causes it is not yet handled correctly. But
> this is just a very wild guess.

I don't think that can happen.  Controllers are required to queue
interrupt till FIFO is flushed.  Can you post dmesg after such errors?

> I tried your latest patch and the dma bug did show up. I have attached a
> patch to this mail that
> decides based on the dma direction and the command size in the
> sil_check_atapi_dma() routine
> whether to allow dma or not. This fixed the dvd auth issue and the
> cdrecord -atip issue for me,
> but i am pretty sure there is a better solution.

I'm not really sure what we're looking at and where the problem actually
is.  We need to find out more about this problem.

-- 
tejun
