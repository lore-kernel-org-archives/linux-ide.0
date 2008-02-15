From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC-UGLYPATCH] ata: small optimization in linux/libata.h
Date: Fri, 15 Feb 2008 10:58:05 +0900
Message-ID: <47B4F1AD.3060808@gmail.com>
References: <1203016578.2748.69.camel@brick>  <47B4D129.8060308@gmail.com> <1203033902.10192.7.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:57375 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbYBOB6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 20:58:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so366024rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 17:58:11 -0800 (PST)
In-Reply-To: <1203033902.10192.7.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
>>> I know it's ugly, but I had it done anyways.  The one real problem I have
>>> with it is that if link and ap->pmp_link ever get changed to different types
>>> the compiler will not even warn as we cast away to (char *).  To make it
>>> a bit more robust, a BUILD_BUG_ON checking the pointer types may be a
>>> good idea.
>> Sorry, but Nacked-by: Tejun Heo <htejun@gmail.com>
>>
> 
> Can't say I really blame you, other than this one error, drivers/ata
> builds almost sparse-clean, and I had it done anyways.  I wonder if
> a helper similar in spirit would be any better.  This doesn't have
> any typechecking, but perhaps that could be dealt with too.
> 
> Ran into a similar problem with mmzone.h, akpm has the patch, but
> maybe a helper (kernel.h?) would be cleaner.  Or maybe it's just
> better to live with the sparse warnings....
> 
> /*
>  * return the offset of the ptr from the base, in bytes.
>  */
> #define PTR_OFF(base, ptr) \
> ((char *)ptr - (char *)base)
> 
> if (PTR_OFF(ap->pmp_link, ++link) < ap->nr_pmp_links * sizeof(*link))
> 	return link;

Can you please explain why it warns against pointer substraction?  Is it
because it can generate division?

Thanks.

-- 
tejun
