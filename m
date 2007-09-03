From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 03 Sep 2007 21:50:22 +0900
Message-ID: <46DC030E.9070704@gmail.com>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:45790 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbXICMua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 08:50:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so946611rvb
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 05:50:29 -0700 (PDT)
In-Reply-To: <46DBDA84.3050505@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org

Hello,

Petr Vandrovec wrote:
> I have recompiled kernel with all debugging disabled, and it brought me
> 1.5MBps, so it is still consistently 1MBps slower than on sil. Disabling
> NCQ seems to improve concurrent access a bit (for which I have no
> explanation), while slows down single drive scenario:
> 
> With NCQ:
> 
> 1TB alone: 81.22, 79.86
> 1TB+1TB:   56.28+56.70, 53.51+56.11
> 
> Without NCQ:
> 
> 1TB alone: 79.78, 80.82
> 1TB+1TB:   57.99+58.12, 56.50+56.46
> 
> 3512 sil, no NCQ:
> 
> 1TB alone: 82.28, 82.18
> 1TB+1TB:   47.20+47.54    # Here apparently command based switching or
> 1.5Gbps link between device and PMP becomes bottleneck

Hmmmm.... Weird.  Is the different still there if you take PMP out of
the picture?

> And it seems that I observe what other poster pointed out - that
> apparently all SiI chips are limited somewhere around 120-130MBps, and
> cannot do more even if you pretty ask...

Yeah, that seems to be the hardware limit and is consistent with what I
hear from non-linux people too.

-- 
tejun
