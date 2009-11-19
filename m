From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
Date: Thu, 19 Nov 2009 07:51:27 -0600
Message-ID: <FF648E22-3953-4121-9DCE-862BAC5995B9@kernel.crashing.org>
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru> <795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60970 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbZKSNvo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 08:51:44 -0500
In-Reply-To: <795A2621-9D6C-4D1F-B07B-24E15C55B03F@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux-ppc list <linuxppc-dev@ozlabs.org>, Ashish Kalra <Ashish.Kalra@freescale.com>, Jiang Yutang <b14898@freescale.com>


On Nov 5, 2009, at 9:02 AM, Kumar Gala wrote:

>
> On Oct 16, 2009, at 11:44 AM, Anton Vorontsov wrote:
>
>> From: Jiang Yutang <b14898@freescale.com>
>>
>> Split sata_fsl_softreset() into hard and soft resets to make
>> error-handling more efficient & device and PMP detection more
>> reliable.
>>
>> Also includes fix for PMP support, driver tested with Sil3726,
>> Sil4726 & Exar PMP controllers.
>>
>> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>>
>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> drivers/ata/sata_fsl.c |   84 ++++++++++++++++++++++++ 
>> +-----------------------
>> 1 files changed, 44 insertions(+), 40 deletions(-)
>
> Jeff,
>
> any update on this going in for .32?

Jeff?

- k
