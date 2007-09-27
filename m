From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Stardom SATA HSM violation
Date: Thu, 27 Sep 2007 19:37:01 +0100
Message-ID: <20070927193701.6230d77f@the-village.bc.nu>
References: <46CFA08E.6090604@arbores.ca>
	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>
	<46DBCB6C.8080206@gmail.com>
	<20070905095327.6277d054.akpm@linux-foundation.org>
	<46DEE617.4050004@rtr.ca>
	<46E0A253.7060803@gmail.com>
	<46E154DE.2060602@rtr.ca>
	<46FB563A.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38498 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753797AbXI0Sbw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 14:31:52 -0400
In-Reply-To: <46FB563A.80108@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

> I think there have been enough cases where this draining was necessary.
>  IIRC, ata_piix was involved in those cases, right?  If so, can you
> please submit a patch which applies this only to affected controllers?
> I don't feel too confident about applying this to all SFF controllers.

Old IDE does it on all controllers bar a couple. So we have a very good
knowledge of what does/doesn't work. The one that needs care in old ide
is an ordering issue where a state machine reset done first causes the
drain of the I/O to hang.
