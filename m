From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/5] sata_sil24: update sil24_hardreset()
Date: Tue, 30 May 2006 00:16:18 -0400
Message-ID: <447BC712.5080501@pobox.com>
References: <1148884482615-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3300 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751477AbWE3EQa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:16:30 -0400
In-Reply-To: <1148884482615-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Use phy debouncing instead of unconditional wait after DEV_RST and
> make sil24_hardreset() to request followup SRST as that's the only way
> to wait for !BSY.  Note that the original implementation never worked
> - if the cached status was !BSY, ata_busy_sleep() finished
> immediately; otherwise, it timed out regardless of the actual device
> status.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 4-5


