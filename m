From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATA/133 Problems with multiple cards
Date: Sun, 17 Oct 2004 16:45:28 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101707456aa41970@mail.gmail.com>
References: <58cb370e04101412312fc42a57@mail.gmail.com>
	 <Pine.LNX.4.44.0410170347430.3660-100000@beast.stev.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:40345 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269153AbUJQOp2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Oct 2004 10:45:28 -0400
Received: by mproxy.gmail.com with SMTP id 77so104615rnk
        for <linux-ide@vger.kernel.org>; Sun, 17 Oct 2004 07:45:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44.0410170347430.3660-100000@beast.stev.org>
List-Id: linux-ide@vger.kernel.org
To: James Stevenson <james@stev.org>
Cc: Ian Pilcher <i.pilcher@comcast.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org

Hi,

On Sun, 17 Oct 2004 03:51:36 +0100 (BST), James Stevenson
<james@stev.org> wrote:
> 
> Hi,
> 
> i did actually kind of get the card's working together but ran into
> another problem.
> 
> when i boot with ide=nodma and then turn on dma manually on all the other
> cards / board chipset etc... they all function fine
> 
> then i can only turn the dma up to ATA/100 if i set it to ata/133 it will
> cause the errors. I assume this is something todo with the promise bois
> not setting up the 3rd card at boot time. It only shows drive listing for
> 2 of the 3 cards.

There were very similar problems reported in the past and they were
fixed by replacing power supply with a better one.

Also you shouldn't need to use "ide=nodma" and play with hdparm,
driver should tune the best mode available.  If this doesn't work then
something needs fixing.

You can find out if BIOS/driver configures cards correctly by
comparing PCI config space (lspci -xxx) for working/non-working
controller.

> Unfortunatly this generated another problem.
> When read from both drives at the same time it functions normally and
> see resonable performance. When i attempt to write to both drives it will
> cause the machine to lockup.
> 
>         James
> 
> 
> 
> On Thu, 14 Oct 2004, Bartlomiej Zolnierkiewicz wrote:
> 
> > On Thu, 14 Oct 2004 13:12:42 -0500, Ian Pilcher <i.pilcher@comcast.net> wrote:
> > > James Stevenson wrote:
> > > >
> > > > i seem to have run into an annoying problem with a machine which has
> > > > 3 promise ata/133 card the PDC20269 type.
> > > >
> > >
> > > ....
> > >
> > > >
> > > > Does anyone have an explenation of why this can happen ?
> >
> > * check power supply
> > * compare PCI config space of the "failing" controller to the one which
> >   is "working" (assuming that identical devices are connected to each),
> >   maybe firmware/driver forgets to setup some settings
> >
> > > Promise cards don't support more than two per machine.  If you can get a
> > > third card to work in PIO mode, consider it an added (but unsupported)
> > > bonus.
> >
> > AFAIR people have been running 4-5 cards just fine
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> --
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>   3:40am  up 12:22,  1 user,  load average: 0.00, 0.00, 0.00
> 
>
