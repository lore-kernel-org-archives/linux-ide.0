From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 01:01:48 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.SOL.4.30.0308070100430.29732-100000@mion.elka.pw.edu.pl>
References: <200308070044.41198.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308070044.41198.fsdeveloper@yahoo.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Willy Gardiol <gardiol@libero.it>
List-Id: linux-ide@vger.kernel.org


On Thu, 7 Aug 2003, Michael Buesch wrote:

> But I've captured a few other interesting things in the syslog.
> After doing a
> $ hdparm -c1 -u1 -d1 -X69 /dev/hda
> I saw this in my syslog:
>
> Aug  7 00:32:05 lfs kernel: blk: queue c049195c, I/O limit 4095Mb (mask 0xffffffff)
> Aug  7 00:32:05 lfs kernel: hda: Speed warnings UDMA 3/4/5 is not functional.
>
> The onboard IDE controller is a UDMA-100 controller
> and the disks do run in this mode, too.

Please send dmesg and .config.

--
Bartlomiej
