From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Wed, 22 Dec 2004 00:06:44 +0100
Message-ID: <58cb370e041221150664911436@mail.gmail.com>
References: <20041221202407.GD2725@artsapartment.org>
	 <41C88F73.2090606@pobox.com> <20041221133056.6a5a3259.akpm@osdl.org>
	 <41C89ADE.1010403@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:20829 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261897AbULUXl2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 18:41:28 -0500
Received: by wproxy.gmail.com with SMTP id 58so74256wri
        for <linux-ide@vger.kernel.org>; Tue, 21 Dec 2004 15:41:28 -0800 (PST)
In-Reply-To: <41C89ADE.1010403@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On Tue, 21 Dec 2004 16:51:26 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>Art Haas wrote:
> >>
> >>>Hi.
> >>>
> >>>This patch adds C99 initializers to the file. It can clearly wait until
> >>>after 2.6.10 is released if you want to send it to Linus.
> >>
> >>The unpatched version is far more readable and maintainable.
> >>
> >
> >
> > I was thinking the exact opposite ;)
> 
> The problem with this (and similar patches to PCI drivers' struct
> pci_device_id arrays) is that a single line explodes into 4-5 or more
> lines, when it is _already_ plainly obvious to the maintainer what each
> field value represents.
> 
> It uses more space without adding value to the maintainer ("I have to
> scroll a lot more to see the same information?  Thanks!").
> 
> Once the struct has exploded from one line per entry to bunches, the
> maintainer is then forced to reverse the damage by creating a macro that
> allows the data to shrink again.  Why not just avoid the expand-shrink
> cycle in the first place?  See example below, from drivers/ide/pci/piix.h.
>
> Of course, Art's patch modifies drivers/ide/*, so Bart's opinion on the
> subject is far more important than mine.

My opinion on this subject is the same as Jeff's.
