From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Another project for you... :)
Date: Sat, 10 Jun 2006 00:44:46 +0100
Message-ID: <1149896686.22124.96.camel@localhost.localdomain>
References: <1149751860.29552.79.camel@forrest26.sh.intel.com>
	 <44883BAE.7070406@pobox.com>
	 <1149820043.5721.7.camel@forrest26.sh.intel.com> <4488E6F6.10306@pobox.com>
	 <1149822824.5721.16.camel@forrest26.sh.intel.com>
	 <87f94c370606091529q2cb2a197v96ef95c3e4b55643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:472 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932581AbWFIX3i
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 19:29:38 -0400
In-Reply-To: <87f94c370606091529q2cb2a197v96ef95c3e4b55643@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com, linux-ide@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>

Ar Gwe, 2006-06-09 am 18:29 -0400, ysgrifennodd Greg Freemyer:
> behavior was to have the Linux Kernel look for HPAs by default and to
> open the drive up to the full size via "set max" on boot, but to have
> a boot parameter to disable this behavior if desired.

It doesn't really work very well, even less so when you hit SATA and
have hot plug disks. HPA on which disks, inserted when.

Thus it needs, as Jeff says, to be cleanly exposed dynamically at
runtime.

Alan

