From: Tigran Aivazian <tigran@veritas.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 2 Jul 2004 16:51:23 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0407021648040.2190-100000@einstein.homenet>
References: <40E5817D.4000408@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colossus.systems.pipex.net ([62.241.160.73]:26006 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264647AbUGBPwq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 11:52:46 -0400
In-Reply-To: <40E5817D.4000408@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

if I enable CONFIG_IDE then IDE subsystem takes over 0170-0177
and 01f0-01f7 io ranges and SATA gets "busy" error and doesn't handle the 
hard disk (i.e. hard disk remains 3M/sec slow).

As for CONFIG_BLK_DEV_IDE_SATA, there is no such thing:

# find -name Kconfig | xargs fgrep CONFIG_BLK_DEV_IDE_SATA
# 

Maybe you meant CONFIG_SCSI_SATA? But if I disable it then the hard disk 
will no longer be 56M/sec but will go back to generic IDE 3M/sec 
performance.

My guess is that the solution to my problem is to compile both IDE and 
SATA but somehow pass some "ide?=???" boot options which would tell IDE to 
take over ide1 channel and let SATA handle the rest. Is this incorrect?

Kind regards
Tigran

On Fri, 2 Jul 2004, Jeff Garzik wrote:

> Tigran Aivazian wrote:
> > Hi Jeff,
> > 
> > I was a bit confused with the "SATA vs IDE" thing recently, namely the 
> > fact that if I compile _both_ IDE and SATA support into the kernel 
> > then IDE takes over and SATA gets a "busy" error, and as a result I get 
> > 3M/sec performance instead of 56M/sec.
> > 
> > Now, realizing this error I have reconfigured the kernel to NOT include 
> > ide and ONLY include SATA plus chipset-specific ata_piix.c (I have ICH6 
> > device 2652). However, now the new problem is that I can't see the IDE 
> > DVD-ROM drive anymore. Here is dmesg:
> [...]
> > As you see, sda is there, but where is my DVD drive gone?
> 
> I am guessing that your DVD drive is connected to a PATA bus, but you 
> disabled the PATA driver (CONFIG_IDE) completely.
> 
> Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
> fix things I bet.
> 
> 	Jeff
> 

