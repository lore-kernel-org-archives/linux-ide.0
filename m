From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6.21.1] SATA freeze
Date: Sat, 12 May 2007 12:48:59 -0600
Message-ID: <46460C1B.6000609@shaw.ca>
References: <fa.zU1kuoSgByTYCYqY+iCQ5rMJy34@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40090 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958AbXELStR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 14:49:17 -0400
In-reply-to: <fa.zU1kuoSgByTYCYqY+iCQ5rMJy34@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fred Moyer <fred@redhotpenguin.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Fred Moyer wrote:
> I just joined the list today so apologies if this email breaks any email 
> client post threading.
> 
> I have been seeing similar errors on two different systems.  I applied 
> Robert's sata_nv patch posted to the list on May 5th, and approved today 
> by Jeff Garzik.  I've taken several steps to insure that this isn't a 
> faulty cable or drive issue.  This is running on a hp dl145g2.  Here is 
> my lspci, dmesg, and relevant kernel config sections:

(snip)

> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 
> 123392 in
>          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM 
> violation)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete

This appears to be a different problem. Something is issuing 
SMART-related commands (smartd or smartctl perhaps) which the drive 
seems to be reacting strangely to. It apparently completed the command 
but never raised DRQ to request any data being transferred even though 
we expected it to. Maybe SMART is disabled on the drive and that's 
causing it to just toss these commands? CCing linux-ide in case anyone 
knows what would cause this.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

