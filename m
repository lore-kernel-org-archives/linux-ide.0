From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 5/5] libata: Add support for TRIM
Date: Thu, 16 Apr 2009 16:25:41 -0400
Message-ID: <49E79445.3080806@rtr.ca>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com> <1238683047-13588-5-git-send-email-willy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:59324 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbZDPUZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 16:25:43 -0400
In-Reply-To: <1238683047-13588-5-git-send-email-willy@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com

Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  drivers/ata/libata-scsi.c |   46 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 46 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b9747fa..d4c8b8b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
...

It works.  :)

I'm using TRIM on a 120GB OCZ Vertex SSD here now,
and instrumented ata_discard_fn() to log what it does.
Seems to work perfectly, and the sector ranges for TRIM
match those given by "hdparm --fibmap" for the files I've tried.

Does this also TRIM metadata (eg. block bitmaps and the like) ?

Thanks Matthew (and others).
