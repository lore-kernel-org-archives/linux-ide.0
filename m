From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Thu, 11 May 2006 15:22:02 +0100
Message-ID: <1147357322.26130.17.camel@localhost.localdomain>
References: <11473536881889-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60299 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751784AbWEKOLU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:11:20 -0400
In-Reply-To: <11473536881889-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

On Iau, 2006-05-11 at 22:21 +0900, Tejun Heo wrote:
> Convert sata_sil to new EH.  As these controllers have hardware
> interrupt mask and are known to have screaming interrupts issues, use
> hardware IRQ masking for freezing.  sil_freeze() masks interrupts for
> the port and sil_thaw() unmasks them.  As ports are automatically
> frozen before probing reset, there is no need to initialize interrupt
> masks sil_init_onde().  Remove related code.

Word of caution. When you mask an interrupt on chip like this remember
that an IRQ may still be pending so the freeze is *not* safe for
synchronization, merely for shutting the chip up. Otherwise this patch
set looks pretty nice.

Patchsets all look good with my PATA hat on. The dev->ap stuff tidies up
the ->data_xfer methods I need to add and the other stuff fits nicely.

Alan

