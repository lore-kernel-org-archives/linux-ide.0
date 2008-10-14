From: Stan Cunningham <stan.cunningham@yahoo.com>
Subject: Re: Porting old hardware from ide to libata (was [PATCH 0/7] ide: locking improvements)
Date: Mon, 13 Oct 2008 19:04:00 -0700 (PDT)
Message-ID: <726515.41771.qm@web57406.mail.re1.yahoo.com>
References: <200810132345.51836.bzolnier@gmail.com>
Reply-To: stan.cunningham@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n58.bullet.mail.sp1.yahoo.com ([98.136.44.46]:26813 "HELO
	n58.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755139AbYJNCJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 22:09:18 -0400
In-Reply-To: <200810132345.51836.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--- On Mon, 10/13/08, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > I know many distros still use ide for CD drives, but
> > that *sucks* for users because the two driver frameworks
> > loaded simultaneously waste memory and step on each
> > other's toes. Plus, obscure fixes to one framework will
> > not help the other, so users have to stumble on the same bug
> > *twice* before it's fixed for good. But most likely it
> > will get fixed in one framework and overlooked in the other.
> 
> It is not mine fault.  Please complain to the right people.
> 
> You may want to dig into archives and learn about history
> of libata.
> Especially under what conditions it has been ACK-ed and
> merged _five_
> years ago.  Just to quickly recall, there were two such
> conditions:
> 
> * PATA support would be moved from IDE to libata in an
> evolutionary way.
> 
>   Didn't happen.  Instead we had code split, loss of
> git history, user
>   confusion and unimaginable waste of time/resources (quick
> stunt trick
>   and more then three long years of rediscovering the
> wheel...).

I guess you're right that maintaining the continuity of code would have been useful. But ide drivers can still be used as a reference when creating or improving libata drivers. I don't think that git would have been of much use given that it was created only in 2005 and any previous code changes don't appear in its history.

But previous mistakes can't be undone. Let's consider what is the most productive approach for the future, given today's situation.

> > So please, take the time to overcome the libata
> learning curve and start systematically porting support for
> the remaining old hardware to libata.
> 
> I don't mind somebody doing it.

I'm sorry to hear that, because as I see it, porting the remaining hardware and quirks to libata would benefit end users more than dragging along two frameworks. 

> I just have zero motivation to do it myself in my private
> time.

I certainly wish companies would hire more developers to focus on doing this tedious but much needed work.

Stan



      

