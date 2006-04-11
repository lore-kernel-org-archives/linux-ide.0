From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] sata_sil24: fix timeout calculation in sil24_softreset
Date: Tue, 11 Apr 2006 13:19:37 -0400
Message-ID: <443BE529.7070805@pobox.com>
References: <11447617492943-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11653 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751031AbWDKRT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:19:56 -0400
In-Reply-To: <11447617492943-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> sil24_softreset calculated timeout by adding ATA_TMOUT_BOOT * HZ to
> jiffies; however, as ATA_TMOUT_BOOT is already in jiffies, multiplying
> by HZ makes the value way off.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-5


