From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: don't use legacy DMA in ADMA mode (v3)
Date: Tue, 04 Dec 2007 14:02:34 -0500
Message-ID: <4755A44A.90003@garzik.org>
References: <4749FE58.4060800@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50114 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbXLDTCl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:02:41 -0500
In-Reply-To: <4749FE58.4060800@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, Allen Martin <AMartin@nvidia.com>

Robert Hancock wrote:
> We need to run any DMA command with result taskfile requested in ADMA mode
> when the port is in ADMA mode, otherwise it may try to use the legacy DMA engine
> in ADMA mode which is not allowed. Enforce this with BUG_ON() since data
> corruption could potentially result if this happened. Also, fail any attempt to
> try and issue NCQ commands with result taskfile requested, since the hardware
> doesn't allow this.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied #upstream-fixes

Please make sure to copy relevant NVIDIA engineers on your patches, 
since they are actively contributing patches to Linux too (and, well, 
its their hardware :))

	Jeff



