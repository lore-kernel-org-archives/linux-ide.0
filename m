From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 15:01:29 +0000
Message-ID: <20070316150129.5bd65c9d@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
	<45FA8D7A.3040504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53743 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933844AbXCPN6S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 09:58:18 -0400
In-Reply-To: <45FA8D7A.3040504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> The fussy bit is that these commands require a non-standard
> sector size, usually 520 bytes instead of 512.

Do we always know the worst case here as this breaks my pending patch to
use bounce buffers for PIO so we transfer with IRQ enabled and I need to
know the correct new worst case size.

> This patch adds support to libata for READ/WRITE LONG commands
> issued via SG_IO/ATA_16.
> 
> This patch was generated against a 2.6.21-rc3-git7 base:
> 
> drivers/ata/libata-core.c |   20 ++++++++++----------
> drivers/ata/libata-scsi.c |   12 ++++++++++++
> include/linux/ata.h       |    6 ++++++
> include/linux/libata.h    |    2 ++
> 4 files changed, 30 insertions(+), 10 deletions(-)
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>

Acked-by: Alan Cox <alan@redhat.com>

I'll fix my bounce patches up to match and queue them to Jeff after this
is all in and settled.
