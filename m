From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Wed, 30 Nov 2016 18:15:39 +0000
Message-ID: <20161130181539.59cbec41@lxorguk.ukuu.org.uk>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
        <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
        <20161130145322.252f7403@lxorguk.ukuu.org.uk>
        <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58646 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbcK3SPt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 13:15:49 -0500
In-Reply-To: <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tedheadster <tedheadster@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

On Wed, 30 Nov 2016 10:03:47 -0500
tedheadster <tedheadster@gmail.com> wrote:

> On Wed, Nov 30, 2016 at 9:53 AM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
> > On Wed, 30 Nov 2016 16:11:39 +0300
> > Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
> >  
> >> Hello.
> >>
> >> On 11/29/2016 08:53 PM, Matthew Whitehead wrote:
> >>  
> >> > If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
> >> > common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
> >> > and also their associated interrupts (14,15,11,10,8,12).
> >> >
> >> > Unfortunately, on such systems those interrupt lines are at a premium because there is no
> >> > PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
> >> > a list of ports to skip allocating.  
> >
> > In what situation do you actually hit this. The probes should fail so the
> > interrupt shouldn't end up allocated.
> >  
> 
> Alan,
>   on my hardware it grabbed all those interrupts, showing up in
> /proc/interrupts very clearly.

Do you have a dmesg of the boot ?

Alan
