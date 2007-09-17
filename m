From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Mon, 17 Sep 2007 15:43:22 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701555C08@az33exm24.fsl.freescale.net>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com> <16939.1190068482@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:43577 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbXIQWn2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 18:43:28 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l8HMhOkZ020026
	for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 15:43:24 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8HMhOLn017058
	for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 17:43:24 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <16939.1190068482@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dhowells@redhat.com
Cc: paulus@samba.org, Gala Kumar-B11780 <kumar.gala@freescale.com>, linuxppc-dev@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hi David,


I've seen you patch earlier, but I'm not trying to solve the BSG related
problem/warnings. That's why I put a reference to an already existing
commit addressing the BSG/bsg.h warnings. I'm trying to address a
slightly different problem in the PowerPC code only.


Cheers,
Emil.


> -----Original Message-----
> From: dhowells@redhat.com [mailto:dhowells@redhat.com] 
> Sent: Monday, September 17, 2007 5:35 PM
> To: Medve Emilian-EMMEDVE1
> Cc: dhowells@redhat.com; paulus@samba.org; Gala Kumar-B11780; 
> linuxppc-dev@ozlabs.org; bzolnier@gmail.com; linux-ide@vger.kernel.org
> Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=n
> 
> 
> Try the attached.
> 
> David
> ---
> [PATCH] VFS: Make BSG declarations dependent on CONFIG_BLOCK
> 
> From: David Howells <dhowells@redhat.com>
> 
> Make BSG function declarations dependent on CONFIG_BLOCK as 
> they are not
> compilable if the block layer is compiled out.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  include/linux/bsg.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/bsg.h b/include/linux/bsg.h
> index 60e377b..28f5d44 100644
> --- a/include/linux/bsg.h
> +++ b/include/linux/bsg.h
> @@ -52,6 +52,7 @@ struct sg_io_v4 {
>  };
>  
>  #ifdef __KERNEL__
> +#ifdef CONFIG_BLOCK
>  
>  #if defined(CONFIG_BLK_DEV_BSG)
>  struct bsg_class_device {
> @@ -73,6 +74,7 @@ static inline void 
> bsg_unregister_queue(struct request_queue *rq)
>  }
>  #endif
>  
> +#endif /* CONFIG_BLOCK */
>  #endif /* __KERNEL__ */
>  
>  #endif
