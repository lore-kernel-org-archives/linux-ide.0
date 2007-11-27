From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/12] libata: kill ata_id_to_dma_mode()
Date: Tue, 27 Nov 2007 11:30:35 +0000
Message-ID: <20071127113035.46806f39@the-village.bc.nu>
References: <11961602293422-git-send-email-htejun@gmail.com>
	<11961602303295-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46593 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751125AbXK0Ldp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 06:33:45 -0500
In-Reply-To: <11961602303295-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue, 27 Nov 2007 19:43:41 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ata_id_to_dma_mode() isn't quite generic.  The function is basically
> privately implemented ata_id_xfermask() combined with hardcoded mode
> printing and configuration which are specific to ata_generic.
> 
> Kill the function and open code it in generic_set_mode() using generic
> xfermode handling functions.

That one I still think is a bad idea. This sort of internal knowledge
belongs in library routines. It is a pretty generic function for the case
where the device is using existing modes and wants to display them.

