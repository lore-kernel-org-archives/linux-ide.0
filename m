From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Sat, 24 Mar 2007 16:38:12 +0900
Message-ID: <4604D564.9010806@gmail.com>
References: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:9094 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXCXHiT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Mar 2007 03:38:19 -0400
Received: by an-out-0708.google.com with SMTP id b33so1681757ana
        for <linux-ide@vger.kernel.org>; Sat, 24 Mar 2007 00:38:19 -0700 (PDT)
In-Reply-To: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> I wonder if this card of mine is what's bad.  I loaded Sarge 2.4 and the
> Sunix driver and a new disk onto my test whore.  I got essentially the 
> same sort of errors as with your driver (see below) but in this case,
> abolutely nothing was ever reliable, including the partition table.  I'm
> not sure I want to buy another card to test this out, though.  Maybe 
> I'll put the card in my other machine just to verify it's not a mobo 
> issue, though.   crapcrapcrap!
> 
> Sample errors:
> 
> drive not ready for command
> status timeout: status = 0x80 { busy }
> 
> error = 0x00 { }
> dma_intr: status = 0x51 {drive ready SeekComplete error}

My bet is on broken driver.  sunix driver doesn't seem like it was 
written carefully.  Anyways, thanks for testing.  It seems we'll either 
have to implement adma mode.  I'll mark the driver broken for 2.6.21. 
Thanks.

-- 
tejun
