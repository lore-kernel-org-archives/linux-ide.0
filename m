From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Stop mapping ROMs
Date: Sat, 23 Jun 2007 19:42:30 +0200
Message-ID: <200706231942.31049.bzolnier@gmail.com>
References: <20070622142252.2ec0d148@the-village.bc.nu> <467BD5B9.3080307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbXFWRwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019617ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:50 -0700 (PDT)
In-Reply-To: <467BD5B9.3080307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org


Hi,

On Friday 22 June 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Alan Cox wrote:
> 
> > Various old IDE drivers go mapping ROM devices for no apparent reason and
> > without using the ROM mapping API we now have. They don't actually use
> 
>     Hm, do you mean the sysfs based aproach? I've tried that and somehow it 
> failed to work for me -- that's because I deferred removing this stuff from 
> the drivers.

Could you elaborate a bit about sysfs based approach?

If it indeed doesn't work we should ping PCI people about it.

> > the ROM they map and the new libata drivers are happy without it being
> 
>     I guess ROMs used to be mappen just for dumping BIOSes...
> 
> > mapped so rather than port them lets just junk it for the next -rc1.
> 
>     I'd agree to the patch -- the drivers were mapping ROMs in a bad way, 
> often using the default addresses.

I added your ACK to the patch.

Thanks,
Bart
