From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Tue, 07 Apr 2009 13:20:20 -0400
Message-ID: <49DB8B54.7050402@garzik.org>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com> <1238683047-13588-2-git-send-email-willy@linux.intel.com> <1238683047-13588-3-git-send-email-willy@linux.intel.com> <1238683047-13588-4-git-send-email-willy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42416 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbZDGRUY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 13:20:24 -0400
In-Reply-To: <1238683047-13588-4-git-send-email-willy@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Woodhouse <David.Woodhouse@intel.com>

Matthew Wilcox wrote:
> From: David Woodhouse <David.Woodhouse@intel.com>
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> [modified to reduce amount of special casing needed for discard]
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> ---
>  drivers/ide/ide-disk.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 49 insertions(+), 0 deletions(-)

OK, the linux/ata.h portion of TRIM support is now upstream.  This can 
go via Bart's tree.


