From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_nv: don't use legacy DMA in ADMA mode (v3)
Date: Mon, 26 Nov 2007 11:20:21 +0900
Message-ID: <474A2D65.2090302@gmail.com>
References: <4749FE58.4060800@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:65253 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbXKZCU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Nov 2007 21:20:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so400425rvb
        for <linux-ide@vger.kernel.org>; Sun, 25 Nov 2007 18:20:26 -0800 (PST)
In-Reply-To: <4749FE58.4060800@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> We need to run any DMA command with result taskfile requested in ADMA mode
> when the port is in ADMA mode, otherwise it may try to use the legacy DMA engine
> in ADMA mode which is not allowed. Enforce this with BUG_ON() since data
> corruption could potentially result if this happened. Also, fail any attempt to
> try and issue NCQ commands with result taskfile requested, since the hardware
> doesn't allow this.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks.

-- 
tejun
