From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/3] libata: blackfin Pata Driver: Add proper PM operation
 into ATAPI driver
Date: Mon, 29 Sep 2008 00:34:21 -0400
Message-ID: <48E05ACD.8000807@garzik.org>
References: <200809222147.m8MLlALw031656@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40947 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbYI2EeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:25 -0400
In-Reply-To: <200809222147.m8MLlALw031656@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, sonic.zhang@analog.com, cooloney@kernel.org

akpm@linux-foundation.org wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> [akpm@linux-foundation.org: remove ifdefs, make things static]
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_bf54x.c |   34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)

applied 1-3


