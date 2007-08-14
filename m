From: Andreas Radke <a.radke@arcor.de>
Subject: Re: sata drive loosing connection/resetting port
Date: Tue, 14 Aug 2007 22:19:28 +0200
Message-ID: <20070814221928.243949b6@workstation64.home>
References: <20070813220241.3f4b8df5@workstation64.home>
	<6bffcb0e0708131311k51238bb0l63eeb2fce53e3481@mail.gmail.com>
	<46C180D8.9060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:55698 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757234AbXHNUTe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 16:19:34 -0400
In-Reply-To: <46C180D8.9060005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Am Tue, 14 Aug 2007 19:15:52 +0900
schrieb Tejun Heo <htejun@gmail.com>:

> Most likely a hardware issue.
> 
> * Please try a different harddrive/cable and connect to a different
> port.
> 
> * Get a different power supply and see whether that changes anything.
> 

already tried different ports, several SATA cables on that mainboard and
psu works well. the Samsung drive works well no matter where
connected. never had any issues with the Raptor drive when it was
connected to the "old" Intel P965 board before. what's the difference
form ICH8 to ICH9R? any changes in how the driver works?

i confirmed, that the issues still resist in kernel 2.6.23rc3 and also
when using controller in "ide" mode together with ata_piix modul.

but on thing that is really weird: i used our installer iso to boot
with 2.6.22 kernel and even after several hours the error did not
appear! can you explain that? so it only happens when filesystems are
mounted (also / partition is on that drive). 

any idea?

Andreas
