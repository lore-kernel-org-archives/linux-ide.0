From: Andrew Morton <akpm@osdl.org>
Subject: Re: Bugs in Kernels 2.6.20-rc2, rc3 and 2.6.20-rc2-mm1
Date: Fri, 5 Jan 2007 10:54:44 -0800
Message-ID: <20070105105444.946f05bb.akpm@osdl.org>
References: <20070105182037.207760@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:53043 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422684AbXAETMe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jan 2007 14:12:34 -0500
In-Reply-To: <20070105182037.207760@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>

On Fri, 05 Jan 2007 19:20:37 +0100
"Uwe Bugla" <uwe.bugla@gmx.de> wrote:

> Hi,
> 1.In Kernels 2.6.20-rc2 and 2.6.20-rc3 a CD- and DVD-burning application called nerolinux is doing nasty things:
> After a cold start you start the application, then chose the burning device, then close the application. Then the KDE Daemon comes up although no CD is inserted into the burning device. In every following use of Nerolinux after that nerolinux is incapable of recognizing CD- and DVD devices. In other words:
> The device stays active, with or without containing a CD or DVD, and is not released anymore!
> Dmesg looks like this:
> hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hdd: drive not ready for command
> 
> This does not happen in Kernel 2.6.19!

Added linux-ide.

> 2.In Kernel 2.6.20-rc2-mm1 you cannot mount a conventional floppy drive without hanging up the whole system. This does not happen in Kernel 2.6.20-rc2 and rc3.
> 

Yup, this is still on my list of things to look at, thanks.
