From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
	side speed detection
Date: Thu, 24 Aug 2006 11:57:49 +0100
Message-ID: <1156417070.3007.64.camel@localhost.localdomain>
References: <1156188229.18887.56.camel@localhost.localdomain>
	 <44ED4DB5.10400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42180 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751066AbWHXKiB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 06:38:01 -0400
In-Reply-To: <44ED4DB5.10400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-24 am 02:56 -0400, ysgrifennodd Jeff Garzik:
> ACK, but you need to split this up into core (#upstream) and PATA 
> (#pata-drivers) patches.

Its not really needed until you have pata drivers so I was planning to
submit it only for the pata-drivers side of things ?

Alan

