From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc
	cleanups, take#2
Date: Sat, 18 Apr 2009 22:04:21 +0200
Message-ID: <20090418200421.GA1532@liondog.tnic>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <200904181832.29222.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38294 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbZDRUE0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2009 16:04:26 -0400
Received: by fxm2 with SMTP id 2so1361337fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 18 Apr 2009 13:04:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904181832.29222.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, petkovbb@googlemail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello lads,

On Sat, Apr 18, 2009 at 06:32:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Everything looks fine to me and we can always deal with ide-tape issues
> left later (no big deal as it is broken upstream anyway), Borislav?

Seems so, see http://bugzilla.kernel.org/show_bug.cgi?id=12874, for
example. Especially, as it turns out, there's no checking whether
the driver replies to a command, (say MODE_SENSE, CAPABILITIES PAGE)
with the page itself or with standard sense data. It's kinda hard to
fix something like that remotely if one doesn't have the hardware. I
probably should look for some old junk on ebay...

-- 
Regards/Gruss,
    Boris.
