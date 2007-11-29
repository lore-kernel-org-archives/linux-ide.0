From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/14] libata: rename ATA_PROT_ATAPI_* to ATAPI_PROT_*
Date: Thu, 29 Nov 2007 15:52:23 +0000
Message-ID: <20071129155223.7249fe1a@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468182270-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36918 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755470AbXK2P5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 10:57:06 -0500
In-Reply-To: <11963468182270-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Thu, 29 Nov 2007 23:33:26 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ATA_PROT_ATAPI_* are ugly and naming schemes between ATA_PROT_* and
> ATA_PROT_ATAPI_* are inconsistent causing confusion.  Rename them to
> ATAPI_PROT_* and make them consistent with ATA counterpart.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com> 

Acked-by: Alan Cox <alan@redhat.com>
