From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix PMP initialization
Date: Fri, 16 Oct 2009 06:27:03 -0400
Message-ID: <4AD84A77.10004@garzik.org>
References: <4AD733AC.4020808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44580 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451AbZJPK1s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Oct 2009 06:27:48 -0400
In-Reply-To: <4AD733AC.4020808@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ethanhsiao@jmicron.com, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

On 10/15/2009 10:37 AM, Tejun Heo wrote:
> Commit 842faa6c1a1d6faddf3377948e5cf214812c6c90 fixed error handling
> during attach by not committing detected device class to dev->class
> while attaching a new device.  However, this change missed the PMP
> class check in the configuration loop causing a new PMP device to go
> through ata_dev_configure() as if it were an ATA or ATAPI device.
>
> As PMP device doesn't have a regular IDENTIFY data, this makes
> ata_dev_configure() tries to configure a PMP device using an invalid
> data.  For the most part, it wasn't too harmful and went unnoticed but
> this ends up clearing dev->flags which may have ATA_DFLAG_AN set by
> sata_pmp_attach().  This means that SATA_PMP_FEAT_NOTIFY ends up being
> disabled on PMPs and on PMPs which honor the flag breaks hotplug
> support.
>
> This problem was discovered and reported by Ethan Hsiao.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Ethan Hsiao<ethanhsiao@jmicron.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-eh.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

applied


