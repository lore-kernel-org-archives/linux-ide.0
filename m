From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] [LibATA] sata_mv: Remove dumplicated host template
Date: Tue, 18 Dec 2007 16:48:48 -0500
Message-ID: <47684040.8000105@garzik.org>
References: <11978143164051-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53999 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbXLRVsv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:48:51 -0500
In-Reply-To: <11978143164051-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: linux-ide@vger.kernel.org, saeed.bishara@gmail.com, htejun@gmail.com, liml@rtr.ca

Saeed Bishara wrote:
> The mv5_sht and mv6_sht structures are identical. This patch removes one of
> those structures and renames the other to mv_sht.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |   22 ++--------------------
>  1 files changed, 2 insertions(+), 20 deletions(-)

Quite true -- but we must re-add mv6_sht once NCQ support is added. 
Therefore I'll drop this patch for now.

Mark Lord is working on this (at the behest of Marvell, I believe).  I 
also created a preliminary NON-WORKING implementation of NCQ that I made 
available to Mark as a starting point:

Branch 'mv-ncq' of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

If nothing happens in six months, we can revisit your patch :)

Regards,

	Jeff



