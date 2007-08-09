From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_artop: fix UDMA5 for AEC6280[R] and UDMA6 for
 AEC6880[R]
Date: Thu, 9 Aug 2007 23:54:55 +0100
Message-ID: <20070809235455.3117d5dc@the-village.bc.nu>
References: <200708092319.34828.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35019 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbXHIWrk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:47:40 -0400
In-Reply-To: <200708092319.34828.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 9 Aug 2007 23:19:34 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
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

Have you tested this ??

