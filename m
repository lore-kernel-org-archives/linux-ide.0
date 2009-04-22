From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Wed, 22 Apr 2009 13:32:24 -0700
Message-ID: <200904221332.25200.david-b@pacbell.net>
References: <200904201841.10989.david-b@pacbell.net> <49ED99AE.3020100@ru.mvista.com> <200904222026.11495.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:32767 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754977AbZDVUc0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Apr 2009 16:32:26 -0400
In-Reply-To: <200904222026.11495.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, DaVinci <davinci-linux-open-source@linux.davincidsp.com>

On Wednesday 22 April 2009, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 21 April 2009 12:02:22 Sergei Shtylyov wrote:
> > David Brownell wrote:
> > 
> > > Fix UDMA throughput bug:  tCYC averages t2CYCTYP/2, but the code
> > > previously assumed it was the same as t2CYCTYP.
> > 
> >     Wow, thanks for finding it!
> > ....
> > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 
> >     The patch itself is:
> > 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> applied

Thanks.  Further experimentation suggests (a) doing timing
computations in picoseconds, rather than nanoseconds, gives
better answers and makes that "slow" system faster by 25% or
more; and (b) increasing all the UDMA timings by one clock
cycle gives another few percent.

Now (a) makes obvious sense; but (b) seems odd ...

- Dave
