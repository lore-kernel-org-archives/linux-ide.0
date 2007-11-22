From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] sata_nv: don't use legacy DMA in ADMA mode
Date: Thu, 22 Nov 2007 09:48:47 +0900
Message-ID: <4744D1EF.5010406@gmail.com>
References: <473A7628.3010907@shaw.ca> <473BA447.6090909@gmail.com> <473BA4D8.508@gmail.com> <474382D8.1050507@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:1342 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbXKVAtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Nov 2007 19:49:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2979263wah
        for <linux-ide@vger.kernel.org>; Wed, 21 Nov 2007 16:49:00 -0800 (PST)
In-Reply-To: <474382D8.1050507@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> Tejun Heo wrote:
>> Tejun Heo wrote:
>>> If so, can you please add that switching into register mode is okay as
>>> long as there's no other ADMA commands in flight and add
>>> WARN_ON((qc->flags & ATA_QCFLAG_RESULT_TF) && link->sactive)?
>>
>> More accurately, link->sactive test can be substituted with
>> (ap->qc_allocated & ~(1 << qc->tag)).
> 
> Unfortunately we only get the ata_port and ata_taskfile in the tf_read
> callback, so I'm not sure if we can do the equivalent of the qc->flags &
> ATA_QCFLAG_RESULT_TF test (i.e. distinguishing between the
> error-handling case where we care if we abort outstanding commands and
> the normal case with a RESULT_TF command where we do)..

You can test it in ->qc_issue(), no?

-- 
tejun
