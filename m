From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 09/11] pata_hpt3x3: major reworking and testing
Date: Tue, 10 Jul 2007 21:38:31 -0400
Message-ID: <46943497.8010506@garzik.org>
References: <200707091846.l69IkMTQ001390@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37655 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbXGKBid (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 21:38:33 -0400
In-Reply-To: <200707091846.l69IkMTQ001390@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, bzolnier@gmail.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> The HPT343/345 (aka 363) is a bit of a warped device.  For many setups you
> need to access the other registers via BAR4 offsets.  PIO is now rock
> solid, DMA isn't.  Unfortunately the drivers/ide hpt34x driver is
> completely broken so doesn't help further debug.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/Kconfig       |   10 +++-
>  drivers/ata/pata_hpt3x3.c |   90 ++++++++++++++++++++++++++++++------
>  2 files changed, 85 insertions(+), 15 deletions(-)

applied, with fix posted to linux-ide


