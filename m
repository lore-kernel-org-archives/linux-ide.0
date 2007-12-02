From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Peculiar out-of-sync boot log lines
Date: Sun, 2 Dec 2007 19:34:25 +0100
Message-ID: <200712021934.26043.bzolnier@gmail.com>
References: <20071129193728.2f1c237e@linuxamd.linicks.net> <200712012259.35152.bzolnier@gmail.com> <20071202173130.1c645dbc@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:58447 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbXLBSmR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2007 13:42:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2423439rvb
        for <linux-ide@vger.kernel.org>; Sun, 02 Dec 2007 10:42:17 -0800 (PST)
In-Reply-To: <20071202173130.1c645dbc@linuxamd.linicks.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Warne <nick@ukfsn.org>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 02 December 2007, Nick Warne wrote:
> On Sat, 1 Dec 2007 22:59:35 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
>  
> > Thanks for reporting/debugging it guys!
> > 
> > > Something in there needs to insert a '\n' before the "skipping
> > > word" message. Since it doesn't do that right now, the KERN_DEBUG
> > > string appears as "<7>"
> > 
> > This seems like a good occasion to fix ide_dma_verbose() for good
> > so... :)
>  
> > This patch should fix the following problem with out-of-sync IDE
> > messages reported by Nick Warned:
> ...

Sorry for that, I fixed it in "take 2" of the patch.

> I was only reporting it... not warning anybody ;-)

Hehe... :-)

Bart
