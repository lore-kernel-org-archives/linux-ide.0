From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 126X DVD drive? (odd ide-cd output)
Date: Thu, 21 Jun 2007 14:38:32 +0200
Message-ID: <20070621123831.GM18863@kernel.dk>
References: <Pine.LNX.4.64.0706202155440.1605@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([80.160.20.94]:8063 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499AbXFUMjW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 08:39:22 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706202155440.1605@lancer.cnet.absolutedigital.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel IDE Mailing List <linux-ide@vger.kernel.org>

On Wed, Jun 20 2007, Cal Peake wrote:
> Hello,
> 
> It seems if I boot with a disc in the drive (in this case a dual fs 
> ISO-9660/UDF DVD-R) the drive speed gets reported incorrectly:
> 
> hdc: DVDRW DRW-6S160P, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 126X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
> 
> normal output (w/ no disc) is:
> 
> hdc: DVDRW DRW-6S160P, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
> 
> Kernel is 2.6.22-rc5-gf1518a08.
> 
> Harmless, but odd...

Sounds like a firmware bug. From a drive with a 'DVDRW' vendor string,
that's not highly surprising :-)

-- 
Jens Axboe

