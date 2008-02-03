From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [BUG] 2.6.24 refuses to boot - ATA problem?
Date: Sat, 02 Feb 2008 20:37:27 -0500
Message-ID: <47A51AD7.3070102@garzik.org>
References: <745427.71265.qm@web52907.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42753 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243AbYBCBha (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Feb 2008 20:37:30 -0500
In-Reply-To: <745427.71265.qm@web52907.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Chris Rankin wrote:
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
> res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link
> ata1.00: configured for UDMA/66
> ata1: EH complete
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
> res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: status: { DRDY }
> ata1: soft resetting link


Had at least one other report like this...  Sleepiness prevents me from 
recalling more at the moment, but I think the other report was fixed 
with a special ACPI switch...

/me puts in pile for Monday...

	Jeff


