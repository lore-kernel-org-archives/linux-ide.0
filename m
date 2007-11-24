From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: fix sg table sizing
Date: Fri, 23 Nov 2007 19:24:37 -0500
Message-ID: <47476F45.9090004@garzik.org>
References: <20071122094657.GF30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36789 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbXKXAYi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:24:38 -0500
In-Reply-To: <20071122094657.GF30919@htj.mynetwork.cxm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> sil24 unnecessarily used LIBATA_MAX_PRD and ATAPI sg table was short
> by one entry which might cause very obscure problems.  This patch
> updates sg table sizing such that
> 
> * One full page is used for PRB + sg table.  On 4k page,
>   this results in 253 sg's.
> 
> * Make ATAPI sg block properly sized.
> 
> * Make build fail if command block size doesn't equal PAGE_SIZE.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, this one is for #upstream-fixes.
> 
>  drivers/ata/sata_sil24.c |   26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

applied


