From: Tejun Heo <htejun@gmail.com>
Subject: Re: [BUG] IT8212 libata driver *still* hard-freezes system on boot
 on	2.6.22 final.
Date: Mon, 09 Jul 2007 16:23:53 +0900
Message-ID: <4691E289.80101@gmail.com>
References: <1183944204.8932.8.camel@ghreen.sphere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:33742 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbXGIHYA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 03:24:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1283518wah
        for <linux-ide@vger.kernel.org>; Mon, 09 Jul 2007 00:23:59 -0700 (PDT)
In-Reply-To: <1183944204.8932.8.camel@ghreen.sphere>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rodney Gordon II <meff@spherevision.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[cc'ing linux-ide and Bartlomiej.]

Rodney Gordon II wrote:
> Have been quite busy, and I regret I haven't tried a rc kernel in
> awhile, but, this bug has gone un-fixed still.. Thought I'd throw in
> another "heads up"..
> 
> 2.6.22 hang: http://spherevision.org/sync/visual/itelock.jpg
> lspci -vvv: http://spherevision.org/sync/tmp/lspci.out
> 
> Pentium-D 830 3.0GHz Dualcore on a ASUS P5LD2 with latest bios rev.
> 1804.
> 
> SysRq does not work when this locks up.
> 
> Patches, info, things to try, anything is welcome, I am available for
> awhile now and will try anything to get this working.
> 
> Cheers,
> -r
> 


-- 
tejun
