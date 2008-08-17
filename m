From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Add support for Long Logical Sectors and Long Physical
 Sectors
Date: Sun, 17 Aug 2008 19:19:45 -0400
Message-ID: <48A8B211.8030103@pobox.com>
References: <1217957207-23116-1-git-send-email-matthew@wil.cx> <1217957207-23116-3-git-send-email-matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48556 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbYHQXTu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 17 Aug 2008 19:19:50 -0400
In-Reply-To: <1217957207-23116-3-git-send-email-matthew@wil.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Matt_Domsch@dell.com, Matthew Wilcox <willy@linux.intel.com>

Matthew Wilcox wrote:
> From: Matthew Wilcox <willy@linux.intel.com>
> 
> ATA 8 adds support for devices that have sector sizes larger than 512
> bytes.  We record the sector size in the ata_device and use it instead
> of the ATA_SECT_SIZE when the data transfer is a multiple of sectors.
> 
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  drivers/ata/libata-core.c |  127 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata-scsi.c |   52 +++++++++++++-----
>  include/linux/libata.h    |    4 +-
>  3 files changed, 168 insertions(+), 15 deletions(-)

Was this ever updated regarding Alan's final comments?

I only have this patch (the one initiating the email sub-thread).

	Jeff



