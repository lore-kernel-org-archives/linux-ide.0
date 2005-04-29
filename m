From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Date: Fri, 29 Apr 2005 02:23:39 +0200
Message-ID: <58cb370e05042817232461fb09@mail.gmail.com>
References: <1114703284.18809.208.camel@localhost.localdomain>
	 <58cb370e05042813414af5bc1e@mail.gmail.com>
	 <1114727522.18355.242.camel@localhost.localdomain>
	 <58cb370e05042816003c2ca4be@mail.gmail.com>
	 <1114731804.24687.259.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:31190 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262351AbVD2AXk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 20:23:40 -0400
Received: by wproxy.gmail.com with SMTP id 68so934282wra
        for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 17:23:39 -0700 (PDT)
In-Reply-To: <1114731804.24687.259.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4/29/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-04-29 at 00:00, Bartlomiej Zolnierkiewicz wrote:
> > > why. You've disabled open() of a device with no bound driver.
> >
> > Guess what open() for ide-default was doing in 2.6?
> >
> > return -ENXIO;
> >
> > and no it wasn't my change - it was the effect of fixing
> > locking of the higher layers.
> 
> Yes so it needed fixing and without all the kref, kmalloc, unique object
> structure per ide driver code spew too.

IDE is similar to SCSI now in this respect.
Are you claiming that SCSI needs fixing too?

> > > The fact that the IDE layer appears to be getting worse not better,
> > > which given the starting point is a remarkable achievement.
> >
> > Personal insults are easy, get technical facts.
> 
> I consider that a technical fact. The last IDE code I maintained fully
> in 2.4 had mostly working locking, drive hotplug, open for unbound
> drivers, didnt oops on spurious irqs and wasn't losing all sorts of
> useful boot options. I had hoped that I wouldnt have to totally fork the
> 2.6 IDE code in order to get back to where 2.4-ac was and get the
> locking working so you can't oops it via /proc

Somehow you seem to forget that I took maintaince over
2.5.5x (or 2.5.6x) and there was a lot new stuff added when
you were away (i.e. driver-model and IDE code needs to conform
with it to get sane power management and sysfs support)
and that a lot of other things have changed (influencing IDE).

Feel free to fork so you'll be wasting yours time only and not mine.
