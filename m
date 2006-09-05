From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA drivers queued for 2.6.19
Date: Tue, 05 Sep 2006 15:39:36 +0100
Message-ID: <1157467176.9018.48.camel@localhost.localdomain>
References: <44FC0779.9030405@garzik.org>
	 <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
	 <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
	 <44FD7B1E.7020102@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965077AbWIEOSj@vger.kernel.org>
In-Reply-To: <44FD7B1E.7020102@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

Ar Maw, 2006-09-05 am 15:26 +0200, ysgrifennodd Helge Hafting:
> between sda/hda unless they also use an initrd.  The kernel
> itself does not seem to support partition by label. :-(

This is correct and one reason vendor kernels generally use an initrd.
The kernel does however support "root=/dev/sda1"

Alan
