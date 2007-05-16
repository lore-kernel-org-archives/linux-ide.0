From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/9] libata: separate out ata_dev_reread_id()
Date: Wed, 16 May 2007 01:21:50 -0400
Message-ID: <464A94EE.9010206@garzik.org>
References: <11791672951781-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53453 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762679AbXEPFV5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 01:21:57 -0400
In-Reply-To: <11791672951781-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Separate out ata_dev_reread_id() from ata_dev_revalidate().
> ata_dev_reread_id() reads IDENTIFY page and determines whether the
> same device is still there.  ata_dev_revalidate() reconfigures after
> reread completes.  This will be used by ACPI update.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   47 ++++++++++++++++++++++++++++++++------------
>  drivers/ata/libata.h      |    3 +-
>  2 files changed, 36 insertions(+), 14 deletions(-)

applied 1-3 to #upstream-fixes


