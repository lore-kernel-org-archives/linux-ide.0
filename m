From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Mon, 14 Apr 2008 09:47:34 -0400
Message-ID: <20080414134734.GB7385@csclub.uwaterloo.ca>
References: <200804021524.27222.elendil@planet.nl> <200804021820.04610.elendil@planet.nl> <20080402194938.GI24237@csclub.uwaterloo.ca> <200804031947.07674.elendil@planet.nl> <48017248.4030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:44710 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbYDNNre (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 09:47:34 -0400
Content-Disposition: inline
In-Reply-To: <48017248.4030600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, Apr 13, 2008 at 11:39:04AM +0900, Tejun Heo wrote:
> Please be advised that some modern controllers are dual interfaced. 
> Native one and legacy one.  The legacy one is SFF compliant and 
> depending on configuration may appear at legacy IO addresses, so if you 
> aren't careful, you can end up with two drivers driving the same 
> hardware which usually doesn't end too well.  Loading generic drivers 
> w/o knowing that it's needed is quite dangerous.  I would strongly 
> advise against it.

If you can't safely load the generic driver then the kernel is very
broken and needs fixing.

After all there is no reason I couldn't have multiple IDE controllers,
some of which have dual interfaces, and some of which only have the old
generic interface (like the IDE port on my old ISA sound card).

If a driver supports a device with dual interfaces, then it better
reserve both sets of ports to prevent the generic driver from trying to
use them.

-- 
Len Sorensen
