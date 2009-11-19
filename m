From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] pata_hpt37x: add proper cable detection methods
Date: Thu, 19 Nov 2009 18:23:25 +0000
Message-ID: <20091119182325.21a23953@lxorguk.ukuu.org.uk>
References: <200911191910.44609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37697 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752904AbZKSSV1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 13:21:27 -0500
In-Reply-To: <200911191910.44609.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Nov 2009 19:10:44 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_hpt37x.c |   86 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 30 deletions(-)
> 
> Index: b/drivers/ata/pata_hpt37x.c

Acked-by: Alan Cox <alan@linux.intel.com>

I suspect this may also need the udelay(10) adding but even if it does
its cleaner this way.
