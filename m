From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ide: add dcache flushing after PIO
Date: Wed, 21 Dec 2005 14:03:45 +0000
Message-ID: <20051221140344.GA1736@flint.arm.linux.org.uk>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com> <20051221094847.GA12279@htj.dyndns.org> <20051221140022.GA25001@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40203 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932422AbVLUODx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 09:03:53 -0500
Content-Disposition: inline
In-Reply-To: <20051221140022.GA25001@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, Dec 21, 2005 at 11:00:22PM +0900, Tejun Heo wrote:
> Block drivers are responsible for cache coherency before and after IO.
> When using DMA, DMA API takes care of it but drivers should do manual
> flushing with PIO.

Are you sure you need the ones in the write path?  No other driver
seems to do this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
