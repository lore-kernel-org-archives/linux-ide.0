From: Brad Campbell <brad@wasp.net.au>
Subject: Re: sata media errors not propagated? (was Re: sata_via issue)
Date: Tue, 17 Aug 2004 16:38:57 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4121FC61.3000107@wasp.net.au>
References: <1092741447.1581.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:17857 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266212AbUHQMi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 08:38:28 -0400
In-Reply-To: <1092741447.1581.33.camel@localhost>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Kevin Shanahan wrote:

> Perhaps this is already a known limitation of the SATA drivers (still
> developing features I guess), but if I can help get this working I'm
> willing to test patches or provide more info if needed. In terms of just
> getting my data back, I guess another option is to buy a PATA->SATA
> adapter and see if the "ide" drivers fare any better.

Well I'm in the opposite situation. I'm using an ATA drive via an SATA->PATA adaptor and the "ide" 
drivers do just fine. They just flag the error and keep on keeping on.
In fact, a HPT 1540 running with the kernel Highpoint drivers will behave in the same fashion.

I'm also willing to test or perhaps donate one of my toasted drives for testing.

Regards,
Brad
