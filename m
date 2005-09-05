From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
Date: Mon, 05 Sep 2005 13:29:57 +0100
Message-ID: <1125923397.8714.22.camel@localhost.localdomain>
References: <Pine.LNX.4.63.0508311328230.1945@p34>
	 <Pine.LNX.4.63.0508311408320.1945@p34>
	 <58cb370e050905002630a0e02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932326AbVIEQ2L@vger.kernel.org>
In-Reply-To: <58cb370e050905002630a0e02e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, akpm@osdl.org, linux-ide@vger.kernel.org, apiszcz@lucidpixels.com
List-Id: linux-ide@vger.kernel.org

On Llu, 2005-09-05 at 09:26 +0200, Bartlomiej Zolnierkiewicz wrote:
> After DMA timeout driver reverted back to PIO,
> ide-taskfile.c also holds PIO code besides IDE Taskfile Access.


On SMP after a DMA timeout it will potentially freeze. There are some
paths in that code which lead to double lock takes and hangs, plus some
timer races.

Justin can you make a backup (I mean that seriously), then build a
kernel with spin lock debug enabled and see if you can reproduce the
problem and get a trace. 

If its the locking you'll get a trace and the kernel will continue. At
that point because the spinlock debug continues unsafely through a
double lock after the trace you are in the "danger zone" hence the
backup warning

[Yes the spin lock debug code really should warn you its dangerous for
non debug uses or get patched as it is in Fedora to trace and stop]

If its a hardware or other problem it will still hang

if its an unrelated lock problem it should still get a trace.


Why you see this only on 2.6.13 not 2.6.13-rc7 I don't know. It makes me
wonder if you have a bad drive - but then you imply going back to rc7
goes back to stable. Can you therefore also check the .config options
between the two kernels match.

Alan
