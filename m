From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/amd74xx: fix section references
Date: Fri, 4 Mar 2005 16:40:30 +0100
Message-ID: <58cb370e05030407405572aad2@mail.gmail.com>
References: <20050303194821.55fec933.rddunlap@osdl.org>
	 <20050304080307.GC1646@ucw.cz>
	 <58cb370e05030402122a9290b6@mail.gmail.com>
	 <42287FC0.6060204@osdl.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.193]:61576 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262889AbVCDPkb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 10:40:31 -0500
Received: by wproxy.gmail.com with SMTP id 68so873744wra
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2005 07:40:31 -0800 (PST)
In-Reply-To: <42287FC0.6060204@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, akpm <akpm@osdl.org>, linux-ide@vger.kernel.org, hch@infradead.org

On Fri, 04 Mar 2005 07:33:20 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Fri, 4 Mar 2005 09:03:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >
> >>On Thu, Mar 03, 2005 at 07:48:21PM -0800, Randy.Dunlap wrote:
> >>
> >>>ide/pci/amd74xx:  data structs point to __init text which should be
> >>>  __devinit;
> >>>unless (a) these are going away real soon,
> >>>or (b) this just can't happen, isn't a real problem,
> >>>or (c) other ?
> >>
> >>This is a problem in most of the IDE PCI drivers. It is a problem if IDE
> >>hotplug is to be expected, and shouldn't be causing any immediate harm
> >>if IDE controllers can't be hotplugged. AMD74xx certainly can't.
> 
> Yes, I have a list of other offenders, I just wanted to get
> comments first.
> 
> >>However, I believe it's correct to fix that.
> >
> >
> > Some time ago hch made a patch fixing all IDE PCI drivers.
> > It was queued to be merged after hotplug support is added
> > but may be merged earlier if needed (to kill sparse warnings?).
> 
> So I don't need to fix the remaining offenders, right?

Yep, I'll apply patch from hch.
