From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] aec62xx: kill speedproc() method wrapper (take 2)
Date: Fri, 8 Jun 2007 14:22:10 +0200
Message-ID: <200706081422.10662.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200705282244.54862.bzolnier@gmail.com> <46657E21.8090804@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48213 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968116AbXFHNJP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:09:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950349ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:09:14 -0700 (PDT)
In-Reply-To: <46657E21.8090804@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 05 June 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>There's no reason to have the speedproc() method wrapper for the two quite
> >>different chip families, so just get rid of it.
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> >>---
> >>Tthis version of the patch properly installs the speedproc() method.
> >>Again, the patch has only been compile tested...
> 
> > applied after fixing the following trivial reject (not a problem
> > but I thought I would let you know in case I missed something):
> 
>     Yes, you did. I've also recast the patch killing init_dma() method. Do I 
> need to resend it?

Please do.
