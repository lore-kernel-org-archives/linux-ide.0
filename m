From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Wed, 6 May 2009 08:11:21 +0200
Message-ID: <20090506061121.GB3406@liondog.tnic>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com> <20090505211259.GA2723@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46810 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZEFGLZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 02:11:25 -0400
Received: by fxm2 with SMTP id 2so5169556fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 05 May 2009 23:11:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090505211259.GA2723@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>

Hi,

On Tue, May 05, 2009 at 11:12:59PM +0200, Mark de Wever wrote:
> > In the mean time, Tejun has fixed some ide-tape bugs and has a git
> > tree so if you don't want to wait for the fixes to trickle upstream
> > and are eager to test :) you could pull from
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase2
> 
> I compiled 2.6.30-rc4 + ide-phase2 +  your 'tmp fix 2' patch +
> IDETAPE_DEBUG_LOG set to 1

Actually, I meant only the Tejun tree without my patches. Please retry again if
you have the time or just wait a bit - I finally got an ide tape myself :) :

hdb: Seagate STT8000A, ATAPI TAPE drive

I guess similar to yours and I'll get to do testing here which eases bug
fixing largely.

> Your other patches gave merge and compilation problems. ide-phase2 also
> has a problem when I set IDETAPE_DEBUG_LOG to 1, but that one was
> trivial to fix. (I'll send the patch as reply to this post.)

Thanks, acked.

-- 
Regards/Gruss,
    Boris.
