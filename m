From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_scc.c: Workaround	for errata A308
Date: Tue, 10 Jul 2007 21:38:45 -0400
Message-ID: <469434A5.40906@garzik.org>
References: <200707100929.l6A9TOf3017780@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37688 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816AbXGKBis (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:48 -0400
In-Reply-To: <200707100929.l6A9TOf3017780@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Akira Iguchi wrote:
> Workaround for errata A308: turn down the UDMA mode and retry
> the DMA command when the data lost condition is detected.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

applied


