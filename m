From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Mon, 16 Aug 2004 22:48:54 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092692923.21065.9.camel@localhost.localdomain>
References: <20040815151346.GA13761@devserv.devel.redhat.com>
	 <200408162343.35588.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:26085 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267992AbUHPWvQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 18:51:16 -0400
In-Reply-To: <200408162343.35588.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Llu, 2004-08-16 at 22:43, Bartlomiej Zolnierkiewicz wrote:

> it restores hwif to previous state not the default one

Same thing, but sure docs changed. We never stack states.

> ide settings are not limited to /proc, remember about ioctls

Added 

> old old?

Emphatic. Intentional. Changed to "very old"

> > + *	Takes a drive that is as yet not assigned to any midlayer IDE
> > + *	module and figures out which driver would like to own it. If
> 
> drive maybe assinged to midlayer ide-default driver
> 
> > + *	nobody claims the driver then it is automatically attached
> the drive

Fixed

> > +/**
> > + *	ide_register_driver	-	new driver loaded
> > + *	@driver: the IDE driver module
> 
> driver doesn't have to be a module
> 
> IDE device driver

Ok

> it doesn't unload given IDE device driver

Clarified that its called on unloading

