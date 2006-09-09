From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] optical /proc/ide/*/media
Date: Sat, 09 Sep 2006 16:18:18 +0100
Message-ID: <1157815098.6877.36.camel@localhost.localdomain>
References: <20060907110846.GB5470@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60385 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932240AbWIIOzQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Sep 2006 10:55:16 -0400
In-Reply-To: <20060907110846.GB5470@martell.zuzino.mipt.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-09-07 am 15:08 +0400, ysgrifennodd Alexey Dobriyan:
> Sergey Vlasov reported that his "FUJITSU MCC3064AP, ATAPI OPTICAL drive"
> pops up as UNKNOWN in /proc/ide/*/media .
> 
> Closes #4145.

Harmless but yes this seems sensible

Acked-by: Alan Cox <alan@redhat.com>

