From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH Linux 2.6.12 00/09] NCQ: generic NCQ completion/error-handling
Date: Thu, 30 Jun 2005 17:26:20 +0200
Message-ID: <20050630152620.GZ2243@suse.de>
References: <20050626152105.D86561FB@htj.dyndns.org> <20050627143344.GI11633@suse.de> <20050630073633.GF2243@suse.de> <42C3CEA5.9040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:23999 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262786AbVF3P2F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jun 2005 11:28:05 -0400
Content-Disposition: inline
In-Reply-To: <42C3CEA5.9040509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, Jun 30 2005, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Mon, Jun 27 2005, Jens Axboe wrote:
> >
> >>On Mon, Jun 27 2005, Tejun Heo wrote:
> >>
> >>>Hello, Jeff.
> >>>Hello, Jens.
> >>>
> >>>This patchset implements generic completion and error-handling for
> >>>NCQ commands.  This patchset assumes that the previous six misc
> >>>patches to NCQ are applied.
> >>
> >>Excellent, much needed work in that area. I will give it a test spin
> >>here as well, I have one drive that likes to barf with ncq occasionally.
> >
> >
> >Ok, I've run with this for a few days and finally hit the
> >drive-stops-responding condition yesterday afternoon. Error recovery
> >worked a lot better than before, but eventually went down anyways. But
> >now I got a better look at the error, and it's the drive throwing an
> >ICRC (error 0x80). Very odd. I've never seen this happen with non-NCQ
> >operations, however I've seen it now a few times using NCQ. Any ideas?
> >
> 
>  Hello, Jens.
> 
>  Can you please describe how the drive went down in detail?  If 
> possible, log messages w/ the debug message patch applied would be 
> great.  As the EH now resets both the controller (on entry to EH) and 
> the drive (on timeout), we should be able to recover unless something 
> goes very strange.

I'm pretty sure it wasn't the fault of the error handling, although I
cannot say for sure of course. I don't have the log safed, but what
happened was that the drive threw an 0x80 icrc error, drive was
COMRESET, io was errored, and then nothing happened after that. Access
to the drive hung.

I will save the log the next time it occurs, I could not this time since
I was working on the machine remotely and needed it rebooted.

>  I'm currently trying to rewrite sil24 driver to make it look saner and 
> support NCQ.  Once I'm done with it (maybe one or two more days... I 
> hope), I'll do the second take of generic NCQ patches including ATAPI EH 
> fix and stuff and it would be great to have your failure log message 
> before doing that.

It should trigger again within a day or two, I will send it when it
does. Can you resend the debug patch?

-- 
Jens Axboe

