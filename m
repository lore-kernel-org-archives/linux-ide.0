From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 09:03:14 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040909090314.A24950@flint.arm.linux.org.uk>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269364AbUIIIDS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Sep 2004 04:03:18 -0400
Content-Disposition: inline
In-Reply-To: <200409082127.04331.bzolnier@elka.pw.edu.pl>; from bzolnier@elka.pw.edu.pl on Wed, Sep 08, 2004 at 09:27:04PM +0200
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>

On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> [patch] block: remove bio walking
> 
> IDE driver was the only user of bio walking code.

The MMC driver also uses this.  Please don't remove.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
