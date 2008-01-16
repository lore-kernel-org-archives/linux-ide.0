From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/5] libata: factor out ata_pci_activate_sff_host() from
 ata_pci_one()
Date: Wed, 16 Jan 2008 05:13:29 -0500
Message-ID: <478DD8C9.3090405@garzik.org>
References: <1199439744356-git-send-email-htejun@gmail.com> <11994397443430-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45776 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbYAPKNb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jan 2008 05:13:31 -0500
In-Reply-To: <11994397443430-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: torvalds@linux-foundation.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Factor out ata_pci_activate_sff_host() from ata_pci_one().  This does
> about the same thing as ata_host_activate() but needs to be separate
> because SFF controllers use different and multiple IRQs in legacy
> mode.
> 
> This will be used to make SFF LLD initialization more flexible.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  drivers/ata/libata-sff.c  |  184 +++++++++++++++++++++++++--------------------
>  include/linux/libata.h    |    3 +
>  3 files changed, 107 insertions(+), 81 deletions(-)

ACK patches 3-5, but they failed to apply to #upstream


