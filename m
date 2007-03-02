From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil24: kill unused local variable idx in sil24_fill_sg()
Date: Thu, 01 Mar 2007 20:16:38 -0500
Message-ID: <45E77AF6.1010702@garzik.org>
References: <20070226071100.GC20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46223 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161155AbXCBBQk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:16:40 -0500
In-Reply-To: <20070226071100.GC20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Kill unused local variable idx in sil24_fill_sg().
> 
> Spotted by Jeff Garzik.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>

applied


