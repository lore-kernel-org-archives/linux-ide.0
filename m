From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/6] sata_sil24: kill ops->tf_read() and use ata_std_noop_check_status()
Date: Fri, 19 May 2006 11:48:12 -0400
Message-ID: <446DE8BC.4060500@pobox.com>
References: <11480530901961-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:23464 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932384AbWESPsV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:48:21 -0400
In-Reply-To: <11480530901961-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> sil24 doesn't have single TF image.  Result TF is bound to each
> command.  As libata now allows TF-less implementation, kill
> ops->tf_read and use ata_std_noop_check_status() for check_status
> callbacks.  Result TF is loaded directly from LRAM into qc->result_tf
> if necessary.
> 
> This patch also makes sil24_hardreset() to request followup SRST as
> that's the only way to wait for !BSY.  Note that the original
> implementation never worked - if the cached status was !BSY,
> ata_busy_sleep() finished immediately; otherwise, it timed out
> regardless of the actual device status.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK, for reasons described in previous patchset.


