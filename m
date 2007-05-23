From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: kill speedproc() method wrapper
Date: Thu, 24 May 2007 01:33:03 +0200
Message-ID: <200705240133.03704.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200705152343.12956.bzolnier@gmail.com> <464B1310.2080808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:3072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbXEXBX7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 21:23:59 -0400
Received: by ug-out-1314.google.com with SMTP id 70so758433ugb
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 18:23:58 -0700 (PDT)
In-Reply-To: <464B1310.2080808@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Wednesday 16 May 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>There's no reason to have the speedproc() method wrapper for the two quite
> >>different chip families, so just get rid of it.
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > applied
> 
>     I forgot to notice/mention the side effect: there would be no speedproc() 
> method installed if hwif->dma_base happens to be 0.

It doesn't sound too nice since ->autotune is always set and ->tuneproc
uses ->speedproc unconditionally (=> OOPS).

Looks like we really need an extra

if (atp850)
	choose atp850 speedproc
else
	choose atp86x speedproc

before hwif->dma_base check... or maybe even separate ->init_hwif
methods for atp850 and atp86x.

Thanks,
Bart
