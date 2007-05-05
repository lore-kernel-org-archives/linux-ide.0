From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] hpt366: don't check enablebits for HPT36x
Date: Sat, 5 May 2007 23:20:16 +0200
Message-ID: <200705052320.16144.bzolnier@gmail.com>
References: <200705042318.37367.sshtylyov@ru.mvista.com> <200705052130.53793.bzolnier@gmail.com> <463CE681.9050000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:58070 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933605AbXEEVJs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 17:09:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so860156uga
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 14:09:47 -0700 (PDT)
In-Reply-To: <463CE681.9050000@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: michal.kepien@poczta.onet.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 05 May 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>HPT36x chip don't seem to have the channel enable bits, so prevent the IDE core
> >>from checking them...
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > applied
> 
>     I'm getting "403 Forbidden" trying to browse this patch (and 
> ide-cs-recognize-2gb-compactflash-from-transcend.patch as well).

Should be fixed now - sorry for that.

While at it I replaced mine version of "the hpt366: simplify UltraDMA
filtering (take 2)" with the official one ;) and fixed my damn scripts
to always do "chmod 644 pata-2.6/patches/*.patch" before pushing updates
to kernel.org.

Bart
