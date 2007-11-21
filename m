From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 1/2] sata_nv: don't use legacy DMA in ADMA mode
Date: Tue, 20 Nov 2007 18:59:04 -0600
Message-ID: <474382D8.1050507@shaw.ca>
References: <473A7628.3010907@shaw.ca> <473BA447.6090909@gmail.com>
 <473BA4D8.508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:34441 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbXKUA7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 19:59:41 -0500
In-reply-to: <473BA4D8.508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Tejun Heo wrote:
>> If so, can you please add that switching into register mode is okay as
>> long as there's no other ADMA commands in flight and add
>> WARN_ON((qc->flags & ATA_QCFLAG_RESULT_TF) && link->sactive)?
> 
> More accurately, link->sactive test can be substituted with
> (ap->qc_allocated & ~(1 << qc->tag)).

Unfortunately we only get the ata_port and ata_taskfile in the tf_read 
callback, so I'm not sure if we can do the equivalent of the qc->flags & 
ATA_QCFLAG_RESULT_TF test (i.e. distinguishing between the 
error-handling case where we care if we abort outstanding commands and 
the normal case with a RESULT_TF command where we do)..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

