From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sil680: compile fix
Date: Mon, 21 May 2007 20:02:33 -0400
Message-ID: <46523319.8010802@garzik.org>
References: <464ED193.2020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46657 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280AbXEVACf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 20:02:35 -0400
In-Reply-To: <464ED193.2020805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Tejun Heo wrote:
> Recent mmio change broke compilation if PM is turned on.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  pata_sil680.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

applied


