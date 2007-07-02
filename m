From: "Johny Mail list" <maillist.johny@gmail.com>
Subject: Re: PROBLEM: ata_piix.c for the ICH5 SATA Controller.
Date: Mon, 2 Jul 2007 16:26:04 +0200
Message-ID: <cd98e0260707020726s1b3ef8bx8ea766e24bc4d549@mail.gmail.com>
References: <cd98e0260706280546m5d8c8f91kb639731e6e2da8db@mail.gmail.com>
	 <4683F340.2020905@rtr.ca>
	 <cd98e0260706290439n475dc02cw552e47fdd953b575@mail.gmail.com>
	 <46851F65.5070400@rtr.ca> <46852BAE.6070505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:18502 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbXGBO0K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 10:26:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1515155wxd
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 07:26:09 -0700 (PDT)
In-Reply-To: <46852BAE.6070505@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2007/6/29, Mark Lord <liml@rtr.ca>:
> Mark Lord wrote:
> > Johny Mail list wrote:
> >> 2007/6/28, Mark Lord <liml@rtr.ca>:
> >>> I have an ugly (but working) hack for the ICH5 ata_piix driver
> >>> to support hot insertion/removal of drives, but I don't know if/when
> >>> I'll be pushing it upstream.
> >>
> >> Yes it hang permanently there, after this messages i generally reboot
> >> the server.
> >> Yes it not support SATA drive hot insertion/removal, but i have make
> >> the same test on windows. I unplug one disk when i'm logged and the
> >> system don't stop. The drive is removed from the devices list.
> >>
> >> If you can give me the patch for testing it... I would give you my
> >> returns about the good/bad functioning in my case.
> >
> > Okay, Here is a working patch for a very specific variant of ICH5.
> > If your PCI IDs don't match what the patch is looking for,
> > then it should have no effect -- you may need to patch the patch
> > to contain the correct PCI IDs (from lspci -n).
> > * * *
> >
> > Implement ICH5 chipset handling for drive hot insertion/removal.
> > This cannot go upstream, as it conflicts with a more generic
> > polled-hotplug framework that is currently in development.
> >
> > Hot-inserted drives are automatically detected within a second or two,
> > and are ready-to-use within 30 seconds or so.  This could be even faster,
> > but the 2.6.18.8 libata implementation of error-handling is what slows
> > us down here.
> ...
>
> This patch was for 2.6.18.8 -- it *might* apply to newer kernels,
> but I haven't ported it forward yet.
>
> Cheers
>

This patch don't work in my case.
Sorry but i don't understand when you say : "you may need to patch the
patch to contain the correct PCI IDs (from lspci -n)."
Where is the correct line in the patch to set the correct value.
My lspci -n line for the sata is "00:1f.2 0101: 8086:24d1 (rev 02)".
I have noticed that the lock of my kernel is when the "ata4: port
failed to respond (30sec, Status 0xd0)" is written.

Thk
