From: Andre Hedrick <andre@pyxtechnologies.com>
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Date: Wed, 11 Jun 2003 21:15:54 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10306112115300.30142-100000@master.linux-ide.org>
References: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39179
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264725AbTFLEPB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2003 00:15:01 -0400
In-Reply-To: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


It is the SiI3112 or SiI3114 behind and Adaptec munge.


Andre Hedrick
LAD Storage Consulting Group

On Thu, 5 Jun 2003, Alan Cox wrote:

> >    I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> > adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> > the kernel driver doesn't seem to notice this device on boot --
> 
> Its not a PCI identifier I've ever seen before
> 
> > 00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)
> 
> So its some kind of CMD now SIS device, either an SI680 or SI3112 with a 
> weird PCI ID
> 
> 
> Does it have any option to put it into non raid mode in its bios ?
> 

