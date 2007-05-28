From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] aec62xx: kill speedproc() method wrapper (take 2)
Date: Mon, 28 May 2007 22:44:54 +0200
Message-ID: <200705282244.54862.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705242046.14109.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:64621 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760952AbXE1VFs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 May 2007 17:05:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1705526ugf
        for <linux-ide@vger.kernel.org>; Mon, 28 May 2007 14:05:48 -0700 (PDT)
In-Reply-To: <200705242046.14109.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 24 May 2007, Sergei Shtylyov wrote:
> There's no reason to have the speedproc() method wrapper for the two quite
> different chip families, so just get rid of it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Tthis version of the patch properly installs the speedproc() method.
> Again, the patch has only been compile tested...

applied after fixing the following trivial reject (not a problem
but I thought I would let you know in case I missed something):

***************
*** 1,5 ****
  /*
-  * linux/drivers/ide/pci/aec62xx.c            Version 0.23    May 23, 2007
   *
   * Copyright (C) 1999-2002    Andre Hedrick <andre@linux-ide.org>
   * Copyright (C) 2007         MontaVista Software, Inc. <source@mvista.com>
--- 1,5 ----
  /*
+  * linux/drivers/ide/pci/aec62xx.c            Version 0.24    May 24, 2007
   *
   * Copyright (C) 1999-2002    Andre Hedrick <andre@linux-ide.org>
   * Copyright (C) 2007         MontaVista Software, Inc. <source@mvista.com>

I don't know why but it was:

linux/drivers/ide/pci/aec62xx.c             Version 0.23    Apr 27, 2007
