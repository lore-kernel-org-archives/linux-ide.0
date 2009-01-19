From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 22:04:37 +0300
Message-ID: <4974CEC5.9050402@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>	<20090119130322.24745.76137.sendpatchset@localhost.localdomain>	<49748B95.9080105@ru.mvista.com>	<200901191523.15240.bzolnier@gmail.com>	<49748E43.4030009@ru.mvista.com>	<20090119173701.13fd24c6@lxorguk.ukuu.org.uk>	<4974C030.5020509@ru.mvista.com>	<20090119183607.5ee804e1@lxorguk.ukuu.org.uk>	<4974CA81.1050506@ru.mvista.com> <20090119184951.35a52184@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756637AbZASTEW@vger.kernel.org>
In-Reply-To: <20090119184951.35a52184@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:

>>    Tried looking at how in*()/out*() are defined on x86?

> Tried looking at how ide_mm_inb is defined on x86

    That's a bogus argument because:
- MMIO isn't much used by the IDE drivers much (normally the inline
   ins*()/outs*() accessors are used;
- that's used only by generic IDE code, not by the drivers about which
   I'veargued;

I've already agreed that the generic code would probably win from using 
ioread*()/iowrite*().

>>>It's already making function calls, without the benefit of inlining and

>>    I'm afraid you're wrong here.

> I'm afraid you are the one who is wrong. The IDE layer is duplicating a
> generic level of indirection with its own code - purely because IDE
> pre-dates that core functionality. The whole IDE layer indirection can go
> away because Linux has caught up with the needs of the IDE layer.

    What IDE indirection you're talking about anyway?

> Alan

MBR, Sergei
