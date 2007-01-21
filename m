From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19.2 -> 2.6.20-rc5 libata regression
Date: Sun, 21 Jan 2007 11:26:53 +0100
Message-ID: <20070121102653.GH9093@stusta.de>
References: <Pine.LNX.4.64.0701210515510.3703@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3067 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751309AbXAUK0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jan 2007 05:26:47 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701210515510.3703@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Jan 21, 2007 at 05:16:21AM -0500, Justin Piszcz wrote:
> 2.6.19.2:
> # hddtemp /dev/sda
> /dev/sda: WDC WD740GD-00FLC0: 27C
> 
> 2.6.20-rc5:
> # hddtemp /dev/sda
> /dev/sda: ATA WDC WD740GD-00FL: S.M.A.R.T. not available


Subject    : `hddtemp' no longer works
References : http://lkml.org/lkml/2006/12/14/272
             http://bugzilla.kernel.org/show_bug.cgi?id=7581
Submitter  : Alistair John Strachan <s0348365@sms.ed.ac.uk>
             Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
Handled-By : Jens Axboe <jens.axboe@oracle.com>
Status     : bug in hddtemp: http://bugzilla.kernel.org/show_bug.cgi?id=7581


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

