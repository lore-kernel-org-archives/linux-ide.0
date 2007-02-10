From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) piix/slc90e66: more tuneproc() fixing (take 2)
Date: Sat, 10 Feb 2007 01:14:15 +0100
Message-ID: <200702100114.16045.bzolnier@gmail.com>
References: <200702062214.28136.sshtylyov@ru.mvista.com> <200702100041.07997.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:56003 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946773AbXBJAJG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 19:09:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so94395uga
        for <linux-ide@vger.kernel.org>; Fri, 09 Feb 2007 16:09:05 -0800 (PST)
In-Reply-To: <200702100041.07997.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Friday 09 February 2007 22:41, Sergei Shtylyov wrote:
> The tuneproc() method in both these drivers failed to set the drive's own speed.
> Fix this by renaming the function and "wrapping around it" the new tuneproc()
> method.  Switch back to calling tuneproc() in the PIO fallback code.
> While at it, also convert the rest of the PIO timing code into proper C. :-)
> 
> Has been kind of tested on SLC90E66.  I'm too lazy to reboot my box and test
> on ICH4... :-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

thanks, I replaced the old version with this one
