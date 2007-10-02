From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Asynchronous scan support for libata
Date: Tue, 02 Oct 2007 10:41:11 -0400
Message-ID: <47025887.2090006@garzik.org>
References: <20070906210505.GF27404@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbXJBOlP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 10:41:15 -0400
In-Reply-To: <20070906210505.GF27404@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> Last December, I posted this: http://lwn.net/Articles/213635/
> 
> Here's an updated version.  It shaves 5 seconds off boot time on my
> configuration (qla2xxx, emulex, two ata_piix, dual fusion), but could
> save more or less on other setups.
> 
> I think I can remove the 'sync' argument and code from
> ata_scsi_scan_host() now, but wanted to send out this update today.
> 
> ---
> 
> Some of the drivers (AHCI was mentioned to me as a culprit) take a long
> time to discover all the devices attached to them.  Even for ones which
> are relatively quick, if you put a lot of them in a machine, it will
> take a long time in aggregate.  This can be fixed by adding support for
> asynchronous scsi scans, which causes the time-consuming portions of
> initialisation to take place in threads.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Did you look at SATA alone?

Since SATA does its own scan asynchronously from SCSI itself, doing this 
seems of little value.  This patch doesn't change AHCI scanning at all, 
for example.

Quite willing to be convinced otherwise, though...

	Jeff


