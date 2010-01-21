From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 23/64] pata_via: store UDMA masks in via_isa_bridges table
Date: Wed, 20 Jan 2010 23:25:14 -0500
Message-ID: <4B57D72A.2040905@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171712.14623.9408.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62935 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab0AUEZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:25:17 -0500
In-Reply-To: <20100118171712.14623.9408.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:17 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_via: store UDMA masks in via_isa_bridges table
>
> * store UDMA masks in via_isa_bridges[] and while at it make "flags"
>    field to be u8 instead of u16
>
> * convert the driver to use UDMA masks from via_isa_bridges[]
>
> * remove no longer needed VIA_UDMA* defines
>
> Make some minor documentation and CodingStyle fixes while at it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_via.c |  198 +++++++++++++++++++++++--------------------------
>   1 file changed, 93 insertions(+), 105 deletions(-)

applied


