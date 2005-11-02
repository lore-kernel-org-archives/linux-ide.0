From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Asus A8V , via vt8251 AHCI
Date: Tue, 1 Nov 2005 20:56:59 -0800
Message-ID: <20051101205659.7e97c145.rdunlap@xenotime.net>
References: <20051101064058.GA4902@vcr.star-c.com>
	<Pine.LNX.4.58.0511010736550.11761@shark.he.net>
	<20051101192449.GA9719@vcr.star-c.com>
	<Pine.LNX.4.58.0511011237080.11761@shark.he.net>
	<20051102034151.GA7583@vcr.star-c.com>
	<20051101195715.212ea264.rdunlap@xenotime.net>
	<20051102043643.GA5577@vcr.star-c.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:54432 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751499AbVKBFEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 00:04:50 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 21:04:47 -0800
In-Reply-To: <20051102043643.GA5577@vcr.star-c.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: ibedonc@star-c.com, linux-ide@vger.kernel.org

On Tue, 1 Nov 2005 22:36:43 -0600 Don Carroll wrote:

> I think it was , I can try again
> 
> the next one is without MSI
> 

I'm sorry to put you to all of that trouble.

I've seen some very similar issues which turned out to be MSI-related,
but this one doesn't seem to be that way -- unless MSI + irqpoll
(your next test) happens to work for you -- then manybe it will
give us some more evidence.  If it does boot, please send us
the contents of /proc/interrupts .

---
~Randy
