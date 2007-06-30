From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 13/15] ide: add ata_set{_max}_pio()
Date: Sat, 30 Jun 2007 16:21:05 -0400
Message-ID: <4686BB31.7040205@garzik.org>
References: <200706302111.29322.bzolnier@gmail.com> <4686B70F.9080606@garzik.org> <200706302231.10032.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38082 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbXF3UVH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 16:21:07 -0400
In-Reply-To: <200706302231.10032.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> This has been changing recently since "ide_" prefix seems to have
> negative emotional connotations. :-)
> 
> New patches for drivers/ide should use exclusively the "ata_" prefix.

So this choice to be inconsistent was made based entirely on fashion?

This is the same as using a different coding style in one area of the 
IDE driver, when the rest of the IDE driver uses another coding style.

It violates the Principle of Least Surprise.

I cannot see any harm in continuing to use the prefix the IDE driver has 
been using for over a decade, while I can see how inconsistency


>> particularly when libata uses the "ata_" prefix almost exclusively.
> 
> I don't see *any* problem with this since libata exists in the separate
> directory and the amount of code shared between libata and drivers/ide
> equals *zero* (not counting <linux/ata.h> containing defines etc).

There are many opportunities for confusion:  global grep.  oops traces. 
  General reviewer expectations ("oooh, I grepped for ide_xxx because 
thats what all the functions use, except for this ONE function that's 
different")

You are living in a global namespace.  Directories are irrelevant.

	Jeff


