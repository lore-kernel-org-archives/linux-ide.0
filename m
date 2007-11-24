From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/12] libata: xfer_mask is unsigned int not unsigned
 long
Date: Fri, 23 Nov 2007 20:13:06 -0500
Message-ID: <47477AA2.40204@garzik.org>
References: <1194327550227-git-send-email-htejun@gmail.com> <11943275501285-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34609 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXKXBNI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:13:08 -0500
In-Reply-To: <11943275501285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> xfer_mask is unsigned int not unsigned long.  Change ->mode_filter to
> take and return unsigned int.
> 
> While at it, rename @adev of ata_pci_default_filter() to @dev for
> consistency.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-sff.c       |    5 +++--
>  drivers/ata/pata_acpi.c        |    2 +-
>  drivers/ata/pata_ali.c         |    2 +-
>  drivers/ata/pata_hpt366.c      |    2 +-
>  drivers/ata/pata_hpt37x.c      |    4 ++--
>  drivers/ata/pata_pdc2027x.c    |    4 ++--
>  drivers/ata/pata_scc.c         |    2 +-
>  drivers/ata/pata_serverworks.c |    4 ++--
>  include/linux/libata.h         |    5 +++--
>  9 files changed, 16 insertions(+), 14 deletions(-)

as I noted I permit unsigned long, which is a naturally aligned machine 
int on our platforms.

Consistency patches in the other direction (moving ATA_MASK_* to a 
separate enum and marking with UL suffix) are welcome.


