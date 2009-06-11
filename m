From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Thu, 11 Jun 2009 10:44:01 +1000
Message-ID: <1244681041.5739.0.camel@pasglop>
References: <20090425170203.74603b9c@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
	<20090530144643.76cb456e@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
	<20090611003834.7bde5e95@power-debian>
	<1244670377.3352.12.camel@pasglop>
	<20090611015733.39bab13a@power-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090611015733.39bab13a@power-debian>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Andrey Gusev <a.gusev1980@mail.ru>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Thu, 2009-06-11 at 01:57 +0400, Andrey Gusev wrote:

> 
> I wrote about time, why it have such values on second CPU? Sorry, if this 
> message is silly.

Oh that's just because it hasn't synchronized the timebases yet when
it prints those messages.

Cheers,
Ben.

> I found configuration, where there isn't delay, but I need more time for
> testing.
> 
> > 
> > > > 
> > > > 
> > > > > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > > > 
> > > > DMA status indicates that DMA transfer is still active according
> > > > to the controller.  This one is really a platform/hardware
> > > > specific issue.
> > > > 
> > > 
> > > Notes for Ben, I checked only 2.6.26, but may be somebody checked
> > > 2.6.24 or this is interpolation.
> > > 
> > > Thanks,
> > > Andrey 
> > 
