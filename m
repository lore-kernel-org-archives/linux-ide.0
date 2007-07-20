From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_scc.c: small fixes (Workaround for errata A308)
Date: Fri, 20 Jul 2007 07:47:30 -0400
Message-ID: <46A0A0D2.9000107@garzik.org>
References: <200707170309.l6H39t4i007720@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49783 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbXGTLre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:47:34 -0400
In-Reply-To: <200707170309.l6H39t4i007720@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: alan@lxorguk.ukuu.org.uk, kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Akira Iguchi wrote:
> This patch fixes some issues of the previous patch:
> - Use mode_filter() hook to limit ATAPI UDMA mode
> - "data loss" warning message
> - handling of udma_mask
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied


