From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22/-stable] libata: add FUJITSU MHV2080BH to NCQ blacklist
Date: Tue, 10 Jul 2007 21:38:38 -0400
Message-ID: <4694349E.8000209@garzik.org>
References: <20070710071618.GB23568@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37678 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399AbXGKBik (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:40 -0400
In-Reply-To: <20070710071618.GB23568@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Serge van Thillo <nulleke@hotmail.com>, stable@kernel.org

Tejun Heo wrote:
> Please warmly welcome the first member from FUJITSU to the prestigious
> NCQ spurious completion club.
> 
> This is reported by Serge Van Thillo in bugzilla bug 8730.
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=8730
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Serge van Thillo <nulleke@hotmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied


