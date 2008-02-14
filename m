From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC-UGLYPATCH] ata: small optimization in linux/libata.h
Date: Fri, 15 Feb 2008 08:39:21 +0900
Message-ID: <47B4D129.8060308@gmail.com>
References: <1203016578.2748.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:41446 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308AbYBNXj2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 18:39:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so848701wah.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 15:39:27 -0800 (PST)
In-Reply-To: <1203016578.2748.69.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> This patch may be too ugly to live, it suppresses a lot of
> sparse warnings in the libata build and produces slightly
> tighter code. (4 instructions vs 5 and a few bytes saved).
> 
> include/linux/libata.h:1214:13: warning: potentially expensive pointer subtraction
> 
> Original:
> 	if (++link - ap->pmp_link < ap->nr_pmp_links)
> 		return link;
> 
>      52b:	89 d8                	mov    %ebx,%eax
>      52d:	2b 82 60 26 00 00    	sub    0x2660(%edx),%eax
>      533:	c1 f8 02             	sar    $0x2,%eax
>      536:	69 c0 dd 3d c8 44    	imul   $0x44c83ddd,%eax,%eax
>      53c:	3b 82 5c 26 00 00    	cmp    0x265c(%edx),%eax
>      542:	7d 04                	jge    548 <sata_pmp_detach+0xbe>
> 
> Next:
> 	if ((char*)++link - (char *)ap->pmp_link < ap->nr_pmp_links * sizeof(*link))
> 		return link;
> 
>      52b:	69 81 5c 26 00 00 d4 	imul   $0x9d4,0x265c(%ecx),%eax
>      532:	09 00 00
>      535:	89 da                	mov    %ebx,%edx
>      537:	2b 91 60 26 00 00    	sub    0x2660(%ecx),%edx
>      53d:	39 c2                	cmp    %eax,%edx
>      53f:	73 04                	jae    545 <sata_pmp_detach+0xbb>
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
> I know it's ugly, but I had it done anyways.  The one real problem I have
> with it is that if link and ap->pmp_link ever get changed to different types
> the compiler will not even warn as we cast away to (char *).  To make it
> a bit more robust, a BUILD_BUG_ON checking the pointer types may be a
> good idea.

Sorry, but Nacked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
