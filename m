From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Mon, 19 Jan 2009 18:36:07 +0000
Message-ID: <20090119183607.5ee804e1@lxorguk.ukuu.org.uk>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
	<20090119130322.24745.76137.sendpatchset@localhost.localdomain>
	<49748B95.9080105@ru.mvista.com>
	<200901191523.15240.bzolnier@gmail.com>
	<49748E43.4030009@ru.mvista.com>
	<20090119173701.13fd24c6@lxorguk.ukuu.org.uk>
	<4974C030.5020509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753724AbZASSgT@vger.kernel.org>
In-Reply-To: <4974C030.5020509@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > BTW if you moved to ioreadX you could get rid of almost all the readb/inb
> > special casing.
> 
>     And burden the driver code with function calls ISO in/out instructions, at 
> least on x86. It's somewhat arguable move.

And exactly how do you think the IDE accessors in the file get called ?
It's already making function calls, without the benefit of inlining and
sharing common paths across architectures that can handle more than just
PIO v MMIO but also other addressing modes.
