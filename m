From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: implement BROKEN_HPA horkage and apply it to
 HDS724040KLSA80
Date: Tue, 7 Aug 2007 17:53:40 +0100
Message-ID: <20070807175340.0439b055@the-village.bc.nu>
References: <20070807054250.GQ13674@htj.dyndns.org>
	<20070807162529.1781b21c@the-village.bc.nu>
	<46B89177.2040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59807 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755988AbXHGQrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 12:47:10 -0400
In-Reply-To: <46B89177.2040209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org, kelk1@comcast.net, lcapitulino@mandriva.com.br

> > I'd rather know what is going on here. A drive can legitimately
> > support LBA48 and HPA and refuse READ_NATIVE_MAX_EXT.
> 
> READ_NATIVE_MAX_EXT is mandatory if HPA && LBA48, no?

No - and we hit this specific case in old IDE with some Maxtor drives.

> Haven't tried that but the problem is that the drive times out
> READ_NATIVE_MAX_EXT so it doesn't really matter whether the drive
> succeeds READ_NATIVE_MAX or not.  For more detail, please read the
> following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/21322

Thanks will do:

> device reports in words 85-87 and 120, which libata currently doesn't
> do.  Are we leaving this out intentionally (for broken devices) or just
> did we just miss it?

We missed it. I assume the drive in the blacklist sets it correctly
however ?

Alan
