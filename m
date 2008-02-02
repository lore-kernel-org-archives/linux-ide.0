From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/9] libata: implement and use SHT initializers and ops
 inheritance
Date: Sat, 02 Feb 2008 09:06:50 +0900
Message-ID: <47A3B41A.9020702@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432907-git-send-email-htejun@gmail.com> <47A385E4.5000901@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:49659 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761544AbYBBAHA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 19:07:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so925208rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 16:06:57 -0800 (PST)
In-Reply-To: <47A385E4.5000901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Jeff Garzik wrote:
> Two comments:
> 
> 1) Please split into SHT and ops patches (SHT first, I presume)

Sure.

> 2) It seems like inheritance would be easier and less error-prone if the
> ops were copied, rather than modifying the structures in-place.  Comments?

I thought about making per-port copies on host allocation or host start.
 The pros of such approach would be...

* LLD's ops table can be made const.

* LLD can modify ops table freely after the copying happens.  To take
advantage of this, host allocation is probably the best place to copy
the ops tables.

Cons are...

* It changes the way a libata LLD should handle ops table.  The current
usage model is based on that ops table is used directly and shared and a
separate table should be defined for different variants.  I think it's
better to keep the current way and inheritance makes it easy.  This
almost cancels out the second pro point.

* More overhead (doesn't really matter tho).

I don't see where modifying the ops table in-place is more difficult or
error-prone.  Only LLD's own ops tables need to drop const and it's not
like ops tables are directly manipulated by any code other than the
finalization code.

Another thing is that what was needed here was static class inheritance
and the in-place finalization is run-time variant of inheritance
resolving done by OO compilers.  I think it's nice to keep that familiar
semantics.

Thanks.

-- 
tejun
