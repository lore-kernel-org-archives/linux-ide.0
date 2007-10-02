From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 02 Oct 2007 09:12:28 +0900
Message-ID: <47018CEC.6060203@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca> <4700EA52.10701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:25113 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXJBAOF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 20:14:05 -0400
Received: by py-out-1112.google.com with SMTP id u77so7411724pyb
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 17:14:04 -0700 (PDT)
In-Reply-To: <4700EA52.10701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>> Linux kernel development is supposed to happen incrementally nowadays.
>> Get a nice working solution in place, and then enhance/tune it.
> 
> It's not about enhancing and tuning.
> 
> It's about me (and/or James B) having to __undo__ the current code, just
> to get things working on an entire class of SATA-capable controllers out
> in the field.

Hmmm... Simpy not setting ATA_FLAG_PMP isn't enough?

-- 
tejun
