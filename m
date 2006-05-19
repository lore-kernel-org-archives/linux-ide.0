From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/6] sata_sil24: use sata_phy_debounce() in sil24_hardreset()
Date: Fri, 19 May 2006 11:47:41 -0400
Message-ID: <446DE89D.80007@pobox.com>
References: <11480530901495-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:19624 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932365AbWESPrx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:47:53 -0400
In-Reply-To: <11480530901495-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Do phy debouncing instead of unconditional wait after DEV_RST.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 4 - 5


