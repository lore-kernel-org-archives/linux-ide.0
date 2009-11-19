From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_fsl: Split hard and soft reset
Date: Thu, 19 Nov 2009 18:18:31 -0500
Message-ID: <4B05D247.8040506@garzik.org>
References: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38022 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbZKSXSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 18:18:41 -0500
In-Reply-To: <20091016164436.GA12897@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, Jiang Yutang <b14898@freescale.com>, Ashish Kalra <Ashish.Kalra@freescale.com>, Li Yang <leoli@freescale.com>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On 10/16/2009 12:44 PM, Anton Vorontsov wrote:
> From: Jiang Yutang<b14898@freescale.com>
>
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient&  device and PMP detection more
> reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726,
> Sil4726&  Exar PMP controllers.
>
> [AV: Also fixes resuming from deep sleep on MPC8315 CPUs]
>
> Signed-off-by: Jiang Yutang<b14898@freescale.com>
> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> ---
>   drivers/ata/sata_fsl.c |   84 +++++++++++++++++++++++++-----------------------
>   1 files changed, 44 insertions(+), 40 deletions(-)

applied #upstream-fixes


