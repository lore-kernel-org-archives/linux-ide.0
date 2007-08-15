From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for AEC6880[R]
Date: Wed, 15 Aug 2007 04:17:29 -0400
Message-ID: <46C2B699.3080408@garzik.org>
References: <200708092319.34828.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41731 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbXHOIRc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Aug 2007 04:17:32 -0400
In-Reply-To: <200708092319.34828.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Maximum supported UDMA mode for AEC6280[R] is UDMA5 (not UDMA4)
> and for AEC6880[R] it is UDMA6 (not UDMA5):
> 
> * Fix the problem by adding missing struct ata_port_info to artop_init_one().
> 
> * Use the right naming (s/626/628/).
> 
> * Bump driver version.
> 
> Fixes IDE->libata regression, problem was never present in IDE aec62xx driver.
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_artop.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

applied to #upstream-fixes


