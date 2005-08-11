From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 01/07] sil24: implement status register
 emulation
Date: Thu, 11 Aug 2005 15:18:58 -0400
Message-ID: <42FBA4A2.5080609@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org> <20050730101344.623D22BD@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50599 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932386AbVHKTTC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:19:02 -0400
In-Reply-To: <20050730101344.623D22BD@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 01_sil24_add-status-emulation.patch
> 
> 	Add back status register emulation.  It's very simple.  If the
> 	previous command completed successfully, we return ATA_DRDY
> 	for all following status register queries; otherwise, we
> 	return ATA_DRDY | ATA_ERR.  We can improve error reporting by
> 	reading CMD_ERROR register and emulating status/error values
> 	accordingly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK.  As described and demonstrated in other emails, we want to obtain 
the Error/Status values from the D2H Register FIS, -not- emulate them.

	Jeff



