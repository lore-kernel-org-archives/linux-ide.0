From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 07/10] ide: add ->dma_check method
Date: Mon, 09 Mar 2009 01:32:33 +0300
Message-ID: <49B44781.6050708@ru.mvista.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain> <20090220171229.25429.16478.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:6087 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753794AbZCHWck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Mar 2009 18:32:40 -0400
In-Reply-To: <20090220171229.25429.16478.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> * Add (an optional) ->dma_check method for checking if DMA can be
>   used for a given command and fail DMA setup in ide_dma_prepare()
>   if necessary.
>
> * Convert alim15x3 and trm290 host drivers to use ->dma_check.
>
> * Rename ali15x3_dma_setup() to ali_dma_setup() while at it.
>   

   ali_dma_check() you mean?

> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


