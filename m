From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/amd74xx: fix section references
Date: Fri, 4 Mar 2005 11:12:32 +0100
Message-ID: <58cb370e05030402122a9290b6@mail.gmail.com>
References: <20050303194821.55fec933.rddunlap@osdl.org>
	 <20050304080307.GC1646@ucw.cz>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.195]:36479 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261342AbVCDKMc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2005 05:12:32 -0500
Received: by wproxy.gmail.com with SMTP id 68so809453wra
        for <linux-ide@vger.kernel.org>; Fri, 04 Mar 2005 02:12:32 -0800 (PST)
In-Reply-To: <20050304080307.GC1646@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>, linux-ide@vger.kernel.org

On Fri, 4 Mar 2005 09:03:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Mar 03, 2005 at 07:48:21PM -0800, Randy.Dunlap wrote:
> >
> > ide/pci/amd74xx:  data structs point to __init text which should be
> >   __devinit;
> > unless (a) these are going away real soon,
> > or (b) this just can't happen, isn't a real problem,
> > or (c) other ?
> 
> This is a problem in most of the IDE PCI drivers. It is a problem if IDE
> hotplug is to be expected, and shouldn't be causing any immediate harm
> if IDE controllers can't be hotplugged. AMD74xx certainly can't.
> 
> However, I believe it's correct to fix that.

Some time ago hch made a patch fixing all IDE PCI drivers.
It was queued to be merged after hotplug support is added
but may be merged earlier if needed (to kill sparse warnings?).
