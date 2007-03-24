From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Fri, 23 Mar 2007 23:48:14 -0700 (PDT)
Message-ID: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com>
References: <20070316060258.56517.qmail@web811.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web802.biz.mail.mud.yahoo.com ([209.191.90.75]:39082 "HELO
	web802.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753466AbXCXGsP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Mar 2007 02:48:15 -0400
In-Reply-To: <20070316060258.56517.qmail@web811.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

--- Bob Stewart <bob@evoria.net> wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
> > It would be great if you can test the sunix driver on 2.4 kernel for
> > both LBA28 and 48 cases.  I know it's a hassle and would really
> > appreciate it.
> 
> Will do.  I'll be using  Debian Sarge 2.4.  It'll be 2 or 3 weeks before
> I can do anything, though.  I'll post then.
> 
> Bob

Tejun,
I wonder if this card of mine is what's bad.  I loaded Sarge 2.4 and the
Sunix driver and a new disk onto my test whore.  I got essentially the 
same sort of errors as with your driver (see below) but in this case,
abolutely nothing was ever reliable, including the partition table.  I'm
not sure I want to buy another card to test this out, though.  Maybe 
I'll put the card in my other machine just to verify it's not a mobo 
issue, though.   crapcrapcrap!

Sample errors:

drive not ready for command
status timeout: status = 0x80 { busy }

error = 0x00 { }
dma_intr: status = 0x51 {drive ready SeekComplete error}

Bob
