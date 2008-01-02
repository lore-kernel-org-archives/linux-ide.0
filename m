From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/4] libata: implement ATAPI per-command-type DMA
 horkages
Date: Wed, 2 Jan 2008 13:34:45 +0000
Message-ID: <20080102133445.338b4296@the-village.bc.nu>
References: <11992723701811-git-send-email-htejun@gmail.com>
	<1199272371169-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34726 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753800AbYABNnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 08:43:49 -0500
In-Reply-To: <1199272371169-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

> This patch implement ATAPI per-command-type DMA horkages and EH logic
> to set those quickly.  This way, failures localized to certain command
> type don't affect other operations (most importantly READs) and
> working configuration is found quickly such that the device can be
> used.

Seems sensible to treat them differently for different controllers. Have
you considered re-issuing failing ATAPI DMA commands as PIO as an EH
response ?
