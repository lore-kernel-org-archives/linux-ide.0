From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: replace ap->cbl tests with ATA_FLAG_SATA tests
Date: Mon, 21 May 2007 17:58:05 +0100
Message-ID: <20070521175805.56b8000a@the-village.bc.nu>
References: <4651C9EB.2040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50240 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755610AbXEUQx0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 12:53:26 -0400
In-Reply-To: <4651C9EB.2040707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 21 May 2007 18:33:47 +0200
Tejun Heo <htejun@gmail.com> wrote:

> ap->cbl == ATA_CBL_SATA indicates SATA cable while ap->flags &
> ATA_FLAG_SATA indicates SATA host port.  Till now they always gave the
> same result but SATA/PATA bridge handling will change that.  Switch to
> ATA_FLAG_SATA test if we're testing for host port type.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Acked-by: Alan Cox <alan@redhat.com>
