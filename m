From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] [POWERPC] Fix build errors when BLOCK=n
Date: Wed, 19 Sep 2007 22:00:56 +0200
Message-ID: <200709192200.56605.bzolnier@gmail.com>
References: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:40972 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXISUI3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 16:08:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so272662nfb
        for <linux-ide@vger.kernel.org>; Wed, 19 Sep 2007 13:08:27 -0700 (PDT)
In-Reply-To: <1190227172-593-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emil Medve <Emilian.Medve@freescale.com>
Cc: paulus@samba.org, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

On Wednesday 19 September 2007, Emil Medve wrote:
> These are the symptom error messages:
> 
>   CC      arch/powerpc/kernel/setup_32.o
> In file included from include/linux/blkdev.h:17,
>                  from include/linux/ide.h:13,
>                  from arch/powerpc/kernel/setup_32.c:13:
> include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
> include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
> In file included from arch/powerpc/kernel/setup_32.c:13:
> include/linux/ide.h:857: error: field 'wrq' has incomplete type
> 
>   CC      arch/powerpc/kernel/ppc_ksyms.o
> In file included from include/linux/blkdev.h:17,
>                  from include/linux/ide.h:13,
>                  from arch/powerpc/kernel/ppc_ksyms.c:15:
> include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
> include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
> In file included from arch/powerpc/kernel/ppc_ksyms.c:15:
> include/linux/ide.h:857: error: field 'wrq' has incomplete type
> 
> The fix tries to use the smallest scope CONFIG_* symbols that will fix the build
> problem. In this case <linux/ide.h> needs to be included only if IDE=y or
> IDE=m were selected. Also, ppc_ide_md is needed only if BLK_DEV_IDE=y or
> BLK_DEV_IDE=m
> 
> Moved the EXPORT_SYMBOL(ppc_ide_md) from ppc_ksysms.c next to its declaration
> in setup_32.c
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

looks OK for me

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
