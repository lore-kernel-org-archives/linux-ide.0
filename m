From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/4] ide-tape: misc stuff
Date: Thu, 16 Jul 2009 08:52:33 +0200
Message-ID: <20090716065233.GA7242@liondog.tnic>
References: <1247671100-8173-1-git-send-email-petkovbb@gmail.com>
 <20090715.111606.193724419.davem@davemloft.net>
 <20090715184350.GA13708@liondog.tnic>
 <20090715.124150.120992830.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34372 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbZGPGxD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2009 02:53:03 -0400
Content-Disposition: inline
In-Reply-To: <20090715.124150.120992830.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 15, 2009 at 12:41:50PM -0700, David Miller wrote:
> From: Borislav Petkov <petkovbb@googlemail.com>
> Date: Wed, 15 Jul 2009 20:43:50 +0200
> 
> > Well, the downside to that is whenever there's a bug report and I want
> > the user to do a debug build and send me the output, I'll have to rehash
> > that debug patch and send it to her/him, maybe teach her/him how to
> > patch a kernel, build it and catch the output and send it my way before
> > we do some real work. Having the change upstream makes it _a_ _lot_
> > _more_ easier to do that and this is experience talking, we had several
> > scenarious like that already.
> 
> Your PFX patch has no effect at all, it's just cleanup noise.

Yes, that one I don't need, I can drop it.

> The other patch moves the debug mask from one place to another,
> why can't the debug selections bet set properly as is?

Where the debug_mask is set is all the same to me, its the additional
information added to the debug calls that I care about. I don't mention
that in the commit message which is my bad, sorry, will fix. With those
you can actually follow what happens, for example:

[   51.945800] ide-tape: ide_tape_get_bsize_from_bdesc: blk_size: 512, write_prot: 0
[   51.945821] ide-tape: idetape_chrdev_ioctl: cmd: 0x40086d01
[   51.945826] ide-tape: idetape_mtioctop: MTIOCTOP ioctl: mt_op: 13, mt_count: 1
[   51.945830] ide-tape: idetape_rewind_tape: enter
[   51.945843] ide-tape: idetape_do_request: cmd: 0x1, sector: 4294967295, nr_sectors: 0

Those debug calls were simply not there/not complete wrt to the
information they were dumping because nobody had an ide-tape to play
with. After I got one and started debugging, I've added that missing
information which made a dbg output more understandable (e.g. request
cmd, args the ioctl is being called with, etc.)

This is the only reason for that change and because it doesn't break
anything but helps a whole lot when debugging, it's a win-win thing and
that's why I advocate its inclusion so vehemently :).

Thanks.

-- 
Regards/Gruss,
    Boris.
