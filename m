From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Wed, 03 Oct 2007 17:18:07 -0400
Message-ID: <4704070F.1090308@garzik.org>
References: <46F7FBCB.4030803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34941 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbXJCVSJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 17:18:09 -0400
In-Reply-To: <46F7FBCB.4030803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Berck E. Nash wrote:
> Greetings,
> 
> I get a few million of these on boot-- the system never actually boots.
> Works fine in 2.6.23-rc7.
> 
> [   50.456012] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [   50.462484] ata2.00: irq_stat 0x40000001
> [   50.466441] ata2.00: cmd e5/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> cdb 0x0 data 0
> [   50.466442]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask
> 0x1 (device error)
> [   50.481914] ata2.00: status: {DRDY ERR }
> [   50.485876] ata2.00: error: {ABRT }
> [   50.489533] ata2.00: configured for UDMA/133
> [   50.493839] ata2: EH complete

FWIW I haven't had time to debug this, so I'm going to simply revert the 
patch, and make sure it does not make it into 2.6.24.

	Jeff



