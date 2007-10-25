From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2/4] libata: implement ata_wait_after_reset()
Date: Thu, 25 Oct 2007 06:12:19 -0400
Message-ID: <47206C03.8080902@garzik.org>
References: <200710162121.l9GLLOv5017808@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45898 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbXJYKMV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 06:12:21 -0400
In-Reply-To: <200710162121.l9GLLOv5017808@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: Tejun Heo <htejun@gmail.com>
> 
> On certain device/controller combination, 0xff status is asserted
> after reset and doesn't get cleared during 150ms post-reset wait.  As
> 0xff status is interpreted as no device (for good reasons), this can
> lead to misdetection on such cases.
> 
> This patch implements ata_wait_after_reset() which replaces the 150ms
> sleep and waits upto ATA_TMOUT_FF_WAIT if status is 0xff.
> ATA_TMOUT_FF_WAIT is currently 800ms which is enough for
> HHD424020F7SV00 to get detected but not enough for Quantum GoVault
> drive which is known to take upto 2s.
> 
> Without parallel probing, spending 2s on 0xff port would incur too
> much delay on ata_piix's which use 0xff to indicate empty port and
> doesn't have SCR register, so GoVault needs to wait till parallel
> probing.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/ahci.c          |   11 +----
>  drivers/ata/libata-core.c   |   67 +++++++++++++++++++++++++++-------
>  drivers/ata/pata_scc.c      |   13 +-----
>  drivers/ata/sata_inic162x.c |    2 -
>  include/linux/libata.h      |    8 ++++
>  5 files changed, 67 insertions(+), 34 deletions(-)

applied


