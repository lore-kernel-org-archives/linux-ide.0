From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] sata_nv: don't use legacy DMA in ADMA mode
Date: Thu, 15 Nov 2007 10:46:00 +0900
Message-ID: <473BA4D8.508@gmail.com>
References: <473A7628.3010907@shaw.ca> <473BA447.6090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:23510 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbXKOBqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 20:46:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so452126wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 17:46:08 -0800 (PST)
In-Reply-To: <473BA447.6090909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> If so, can you please add that switching into register mode is okay as
> long as there's no other ADMA commands in flight and add
> WARN_ON((qc->flags & ATA_QCFLAG_RESULT_TF) && link->sactive)?

More accurately, link->sactive test can be substituted with
(ap->qc_allocated & ~(1 << qc->tag)).

-- 
tejun
