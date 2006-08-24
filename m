From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
	side speed detection
Date: Thu, 24 Aug 2006 15:56:25 +0100
Message-ID: <1156431385.3007.153.camel@localhost.localdomain>
References: <1156188229.18887.56.camel@localhost.localdomain>
	 <44ED4DB5.10400@pobox.com> <1156417070.3007.64.camel@localhost.localdomain>
	 <44EDAEFC.6000609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13204 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751565AbWHXOfk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 10:35:40 -0400
In-Reply-To: <44EDAEFC.6000609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-24 am 09:51 -0400, ysgrifennodd Jeff Garzik:
> The standard policy, in place since you began, has been to push core 
> stuff into #upstream, and the driver side into #pata-drivers.

Jeff, I've no problem with putting it in upstream but all this talk of
"standard policy" is crap. Or at least "standard policy" is a concept
existing only in Jeff's brain and not documented clearly externally in
this case...


