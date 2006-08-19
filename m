From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: fix ghost device probing by honoring PCS present
 bits
Date: Sat, 19 Aug 2006 17:35:23 -0400
Message-ID: <44E7841B.6050004@pobox.com>
References: <20060810052347.GC6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10656 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751533AbWHSVf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Aug 2006 17:35:26 -0400
In-Reply-To: <20060810052347.GC6371@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Move out PCS handling from piix_sata_prereset() into
> piix_sata_present_mask() and use it from newly implemented
> piix_sata_softreset().  Class codes for devices which are indicated to
> be absent by PCS are cleared to ATA_DEV_NONE.  This fixes ghost device
> problem reported on ICH6 and 7 (and probably 8).
> 
> This patch moves PCS handling from prereset to softreset, which makes
> ata_piix perform softreset even when PCS indicates no device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, but doesn't apply to upstream-fixes


