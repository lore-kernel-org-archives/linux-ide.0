From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Tue, 6 Nov 2007 10:49:59 +0000
Message-ID: <20071106104959.726d51d5@the-village.bc.nu>
References: <1194327550227-git-send-email-htejun@gmail.com>
	<11943275502226-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59677 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757334AbXKFKtX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 05:49:23 -0500
In-Reply-To: <11943275502226-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue,  6 Nov 2007 14:39:02 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ata_id_to_dma_mode() isn't quite generic.  The function is basically
> privately implemented ata_id_xfermask() combined with hardcoded mode
> printing and configuration which are specific to ata_generic.

I anticpiated other users. This seems a backward move - we end up
exporting lots of low level detail into the drivers which should be none
of their business.

