From: Alan Cox <alan@redhat.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Date: Thu, 5 Jun 2003 16:13:38 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
References: <20030605193514.GB1542@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265020AbTFEUAJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jun 2003 16:00:09 -0400
In-Reply-To: <20030605193514.GB1542@carfax.org.uk> from "Hugo Mills" at Meh 05, 2003 08:35:14 
List-Id: linux-ide@vger.kernel.org
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andre@linux-ide.org, alan@redhat.com

>    I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> the kernel driver doesn't seem to notice this device on boot --

Its not a PCI identifier I've ever seen before

> 00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)

So its some kind of CMD now SIS device, either an SI680 or SI3112 with a 
weird PCI ID


Does it have any option to put it into non raid mode in its bios ?
