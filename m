From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] IDE updates part #4
Date: Tue, 5 Feb 2008 11:09:24 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802051059330.3110@woody.linux-foundation.org>
References: <200802022035.02326.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40994 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753119AbYBETJ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 14:09:56 -0500
In-Reply-To: <200802022035.02326.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Sat, 2 Feb 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> * next part of IDE probing code re-organization saga
>   (that would be me)

This seems to cause very irritating and bogus messages for me:

	Probing IDE interface ide0...
	Probing IDE interface ide1...
	ide2: I/O resource 0x0-0x7 not free.
	ide2: ports already in use, skipping probe
	ide3: I/O resource 0x0-0x7 not free.
	ide3: ports already in use, skipping probe
	ide4: I/O resource 0x0-0x7 not free.
	ide4: ports already in use, skipping probe
	ide5: I/O resource 0x0-0x7 not free.
	ide5: ports already in use, skipping probe
	ide6: I/O resource 0x0-0x7 not free.
	ide6: ports already in use, skipping probe
	ide7: I/O resource 0x0-0x7 not free.
	ide7: ports already in use, skipping probe
	ide8: I/O resource 0x0-0x7 not free.
	ide8: ports already in use, skipping probe
	ide9: I/O resource 0x0-0x7 not free.
	ide9: ports already in use, skipping probe

and that's just totally bogus. It shouldn't even request that region, 
since it's not been allocated!

So that "ide_device_add_all()" is missing some checks. Should it check the 
probe[] array like ideprobe_init() used to, or what?

		Linus
