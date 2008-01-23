From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: factor out ata_pci_activate_sff_host() from
 ata_pci_one()
Date: Wed, 23 Jan 2008 05:12:21 -0500
Message-ID: <47971305.7050101@garzik.org>
References: <12006489901911-git-send-email-htejun@gmail.com> <12006489903674-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35887 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYAWKMX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jan 2008 05:12:23 -0500
In-Reply-To: <12006489903674-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

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
>  drivers/ata/libata-sff.c  |  187 +++++++++++++++++++++++++--------------------
>  include/linux/libata.h    |    3 +
>  3 files changed, 107 insertions(+), 84 deletions(-)

applied


