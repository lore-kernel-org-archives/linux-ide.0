From: Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH] [STACK] >3k call path in ide
Date: Wed, 16 Jun 2004 09:11:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406160911.11985.jolt@tuxbox.org>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ipx-98-250-190-80.ipxserver.de ([80.190.250.98]:19212 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S266201AbUFPHLP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jun 2004 03:11:15 -0400
In-Reply-To: <20040615163445.6b886383.rddunlap@osdl.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>, akpm <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

>  failed:
>      ide_release(link);
>      link->state &= ~DEV_CONFIG_PENDING;
>
> +    /* memory allocation errors */
> +err_cisparse:
> +    kfree(cfginfo);
> +err_cfginfo:
> +    kfree(def_cte);
> +err_def_cte:
> +    kfree(tbuf);
> +err_tbuf:
> +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
> +    goto failed;
>  } /* ide_config */

Huh? This will either leak memory (non alloc error case) or deadlock (mem 
alloc error case). I'm missing something?

Best,
   Florian
