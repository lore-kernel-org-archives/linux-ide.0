From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 11:01:38 +0900
Message-ID: <48040C82.8080503@gmail.com>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:50774 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759539AbYDOCBp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 22:01:45 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1352802wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 19:01:44 -0700 (PDT)
In-Reply-To: <4803C429.6070201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> Well, I've spent much of the day porting to the new interfaces,
> and then trying to get things working again.

Heh... sorry about the trouble.

> One port multiplier card turned out to be totally dead.
> It was never found (today) by libata, and got quite hot for some reason.
> Since it is probably now toast, I've set it aside.
> 
> The other port multiplier here is different, and was not used
> in the first round of tests.  So far, it gets detected by libata,
 >
> but I'm temporarily stuck on the old issue of libata not finding
> any of the connected drives.  So I probably don't have the myriad
> of pre/hard/soft/pmp/post reset handlers configured just right yet.

Which PMP are you using?  SIMG one or marvell one?

> To establish some kind of baseline, I'm going to reimplement the
> pmp_read/write hooks I used to have, and see if things come alive
> again with those.  And then figure out again what has to change
> to get rid of them.
> 
> 
> Tejun:
> 
> Do you have any recommendations on exactly what should be in
> mv_pmp_softreset() and mv_softreset() and mv_hardreset() under this scheme?
> 
> My basic attempt was to try this:
> 
> No prereset or postreset handlers of any kind.

Yes.

> mv_hardreset():  as in the hardreset rework patch (yet to be picked up
> by Jeff), plus a call to mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT)
> before the sata_link_hardreset() wrapper loop.

Yes.

> mv_softreset():
> First do mv_select_pmp(link->ap, SATA_PMP_CTRL_PORT),
> and then call ata_sff_softreset().
> 
> mv_pmp_softreset():
> First do mv_select_pmp(link->ap, link->pmp),
> and then call ata_sff_softreset().

You can just use mv_select_pmp(link->ap, sata_srst_pmp(link)) in 
mv_softreset() and use it for both mv_softreset() and mv_pmp_softreset().

> Resets of the pmp ports always fail with SRST failed (errno=-16).

Hmm... That's -EBUSY.  I'll continue on the reply of the other mail.

-- 
tejun
