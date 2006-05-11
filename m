From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/6] sata_sil: new interrupt handler
Date: Thu, 11 May 2006 16:40:44 +0100
Message-ID: <1147362044.26130.39.camel@localhost.localdomain>
References: <11473604982155-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25474 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030257AbWEKP3N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:29:13 -0400
In-Reply-To: <11473604982155-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Gwe, 2006-05-12 at 00:14 +0900, Tejun Heo wrote:
> The DMA complete bit of these controllers reflects ATA IRQ status
> while no DMA command is in progress.  So, we can tell whether the
> controller is raising an interrupt or not in deterministic manner.
> This patch gives sata_sil its own interrupt handler which behaves much
> better than the original one in terms of error detection and handling.
> This change is also necessary for later hotplug support.
> 

Is it not possible to avoid duplicating so much code. If the
sil_host_intr and a few other _intr routines end up with their own
host_intr functions closely based on the core one and intimate state
machine knowledge then fixes are going to get missed in one or the other
over time 

