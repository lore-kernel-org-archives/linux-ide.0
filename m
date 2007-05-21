From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: disable 64bit dma on sb600
Date: Mon, 21 May 2007 19:58:48 -0400
Message-ID: <46523238.4090809@garzik.org>
References: <830792.81640.qm@web52605.mail.re2.yahoo.com> <464DA7A6.3010303@gmail.com> <464DB6D7.8040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46557 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755343AbXEUX6x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 19:58:53 -0400
In-Reply-To: <464DB6D7.8040206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, wolke.liu@amd.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> SB600 claims it can do 64bit DMA but it can't.  Disable it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this one is for #upstream-fixes.
> 
>  ahci.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

applied


