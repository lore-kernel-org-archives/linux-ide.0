From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh set tf flags in NCQ EH result_tf
Date: Thu, 24 Apr 2008 11:43:52 +0900
Message-ID: <480FF3E8.9010601@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FF229.2060808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.251]:22585 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095AbYDXCoA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 22:44:00 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1686072rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 19:43:59 -0700 (PDT)
In-Reply-To: <480FF229.2060808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Fix mis-reporting of NCQ errors by ensuring that result_tf->flags
> is properly initialized in libata-eh.  This allows ata_gen_ata_sense()
> to report the failed block number correctly to SCSI after a media error
> during NCQ.
> 
> This patch may also be a candidate for backporting to earlier kernels.
> Without this fix, SCSI will fail I/O on the entire request rather
> than just the bad sector.  That can be bad for a request that was
> merged from many independent read reads from different tasks.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com> ---
> 
> This is an alternative version of the original patch
> which safely copied the outgoing tf.flags to result_tf.flags.
> Both work.  Pick one.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
