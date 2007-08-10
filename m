From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Fri, 10 Aug 2007 19:39:24 +0400
Message-ID: <46BC86AC.4060108@ru.mvista.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com>	<200708092248.44675.bzolnier@gmail.com>	<20070809235213.391ab6c9@the-village.bc.nu>	<200708100152.32753.bzolnier@gmail.com> <20070810142424.55c60cac@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55512 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752583AbXHJPhO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 11:37:14 -0400
In-Reply-To: <20070810142424.55c60cac@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, rah@bash.sh

Hello.

Alan Cox wrote:

>>>one. Actually by now it bears almost no resemblence any of them

>>Indeed, unfortunately...

> Oh I think its very fortunate. The original IDE one is 3 semi-related
> drivers in one file all falling over one another. At least we can now
> break them individually 8)

    I'm still thinking that only HPT36x chips were worth moving into another 
driver -- couldn't help myself not saying that once more. :-)
    Curse on HighPoint for their stupid chips, device IDs, and drivers. >:-Q

> Alan

WBR, Sergei
