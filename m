From: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Sat, 23 Oct 2004 00:51:10 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0410230050480.28663-100000@beast.stev.org>
References: <004601c4b7e0$bfad4ee0$7301a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jstevenson.plus.com ([212.159.71.212]:41357 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S268447AbUJVXSC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Oct 2004 19:18:02 -0400
In-Reply-To: <004601c4b7e0$bfad4ee0$7301a8c0@tw.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, hpj@urpla.net, IDE Linux <linux-ide@vger.kernel.org>


Unfortunatly i dont have the 3rd promise card any more
it found another home ...

	James

On Fri, 22 Oct 2004, Albert Lee wrote:

> Hi, James:
> 
>   Maybe it is caused by firmware not initializing the registers
> of the 3rd adapter correctly. Could you please test the attached
> patch with 2.6.9 kernel and collect the "dmesg" output for the registers
> values?
> 
> Thanks,
> Albert
> 
> ----- Original Message ----- 
> From: "James Stevenson" <james@stev.org>
> To: "Hans-Peter Jansen" <hpj@urpla.net>
> Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>;
> <linux-ide@vger.kernel.org>; <linux-kernel@vger.kernel.org>;
> <kernelnewbies@nl.linux.org>
> Sent: Friday, October 22, 2004 5:56 AM
> Subject: Re: ATA/133 Problems with multiple cards
> 
> 
> > On Thu, 21 Oct 2004, Hans-Peter Jansen wrote:
> >
> > > On Thursday 21 October 2004 20:43, Bartlomiej Zolnierkiewicz wrote:
> > > > On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen
> > > <hpj@urpla.net> wrote:
> > > > > Hmm, I'm running 3 TX2/100 (even with different revisions)
> > > > > without big problems here:
> > > > >
> > > > > 00:09.0 Unknown mass storage controller: Promise Technology, Inc.
> > > > > 20268 (rev 02) 00:0a.0 Unknown mass storage controller: Promise
> > > > > Technology, Inc. 20268 (rev 02) 00:0b.0 Unknown mass storage
> > > > > controller: Promise Technology, Inc. 20268 (rev 01)
> > > >
> > > > lspci -xxx ?
> > >
> > > With pleasure. Let me know, if I can provide anything else useful.
> > > BTW, Bart, I suspect James' problem is, that his system is running in
> > > pic mode, while mine is in apic mode.
> >
> > i dont actually think that this is a problem i was reading an artical from
> > a website (cant find address now) which was stating that the promise
> > card's fireware on the PDC20269 was limited by the firmware to 2 cards
> > and the 3rd did not work in other cases. The author had setup various
> > other systems in the same way using other promise hardware but slightly
> > different cards.
> >
> > I have replaced the 3rd promise card with a highpoint card and everything
> > is working fine and has been for the last 36 hours.
> >
> > James
> >
> > -- 
> > --------------------------
> > Mobile: +44 07779080838
> > http://www.stev.org
> >  10:50pm  up 1 day,  9:16,  3 users,  load average: 0.07, 0.02, 0.00
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 

-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
 12:50am  up 2 days, 11:16,  3 users,  load average: 0.04, 0.01, 0.00

