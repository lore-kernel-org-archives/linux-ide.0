From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: question about SATA and IDE DVD/CD drives.
Date: Fri, 02 Jul 2004 13:02:07 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40E5950F.2090308@pobox.com>
References: <Pine.LNX.4.44.0407021745400.2190-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264746AbUGBRCW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2004 13:02:22 -0400
In-Reply-To: <Pine.LNX.4.44.0407021745400.2190-100000@einstein.homenet>
List-Id: linux-ide@vger.kernel.org
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, cova@ferrara.linux.it, Linux Kernel <linux-kernel@vger.kernel.org>

Tigran Aivazian wrote:
> On Fri, 2 Jul 2004, Jeff Garzik wrote:
> 
>>Enable CONFIG_IDE, and disable CONFIG_BLK_DEV_IDE_SATA, and that will 
>>fix things I bet.
> 
> 
> Tried this as well on the latest snapshot (2.6.7-bk9) and it failed as 
> well. Namely, SATA disk works fine but IDE subsystem doesn't see the DVD 
> drive.
> 
> Are you sure that I only need to enable CONFIG_IDE and not some of the
> other IDE options (disk, cdrom, chipset-specific etc)?

Sorry, I was summarizing...  you definitely need a "personality" driver 
such as the ide-cdrom driver in order to make use of your DVD drive.

Really, though, I need to get off my butt and finish ATAPI in libata. 
Then, libata can drive PATA devices and we can get rid of all these 
headaches with combined mode being split between two drivers.

I'm going to be doing some libata hacking this weekend, looking 
particularly at a regression not caused by ACPI (hi Fabio).  I'll see if 
I can finish up ATAPI at that time.

	Jeff


