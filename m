From: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Thu, 21 Oct 2004 22:56:56 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0410212251300.28663-100000@beast.stev.org>
References: <200410212200.35037.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jstevenson.plus.com ([212.159.71.212]:55175 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S270809AbUJUVXd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 17:23:33 -0400
In-Reply-To: <200410212200.35037.hpj@urpla.net>
List-Id: linux-ide@vger.kernel.org
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org

On Thu, 21 Oct 2004, Hans-Peter Jansen wrote:

> On Thursday 21 October 2004 20:43, Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 20 Oct 2004 16:23:21 +0200, Hans-Peter Jansen 
> <hpj@urpla.net> wrote:
> > > Hmm, I'm running 3 TX2/100 (even with different revisions)
> > > without big problems here:
> > >
> > > 00:09.0 Unknown mass storage controller: Promise Technology, Inc.
> > > 20268 (rev 02) 00:0a.0 Unknown mass storage controller: Promise
> > > Technology, Inc. 20268 (rev 02) 00:0b.0 Unknown mass storage
> > > controller: Promise Technology, Inc. 20268 (rev 01)
> >
> > lspci -xxx ?
> 
> With pleasure. Let me know, if I can provide anything else useful.
> BTW, Bart, I suspect James' problem is, that his system is running in 
> pic mode, while mine is in apic mode.

i dont actually think that this is a problem i was reading an artical from
a website (cant find address now) which was stating that the promise 
card's fireware on the PDC20269 was limited by the firmware to 2 cards
and the 3rd did not work in other cases. The author had setup various 
other systems in the same way using other promise hardware but slightly 
different cards.

I have replaced the 3rd promise card with a highpoint card and everything 
is working fine and has been for the last 36 hours.

	James

-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
 10:50pm  up 1 day,  9:16,  3 users,  load average: 0.07, 0.02, 0.00

