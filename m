From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/5] libata: sync result_tf.flags w/ command tf.flags
Date: Tue, 14 Nov 2006 14:33:48 -0500
Message-ID: <455A1A1C.40209@pobox.com>
References: <11635114553644-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:61129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966278AbWKNTdv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 14:33:51 -0500
In-Reply-To: <11635114553644-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> libata didn't initialize result_tf.flags which indicates transfer type
> (RW/FUA) and address type (CHS/LBA/LBA48).  ata_gen_fixed_sense()
> assumed result_tf.flags equals command tf.flags and failed to report
> the first failed block to SCSI layer because zero tf flags indicates
> CHS and bad block reporting for CHS is not implemented.
> 
> Implement fill_result_tf() which sets result_tf.flags to command
> tf.flags and use it to fill result_tf.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied patches 1-5

consider combining patch #4 and patch #5, when a similar situation 
arises in the future


