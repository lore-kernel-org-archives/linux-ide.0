From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20) cmd64x: fix PIO mode setup (take 3)
Date: Wed, 07 Feb 2007 00:48:00 +0100
Message-ID: <45C913B0.7070103@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com>	 <200702040004.24918.sshtylyov@ru.mvista.com>	 <200702061745.37517.sshtylyov@ru.mvista.com> <58cb370e0702061500g3047b8ccpca894962491b588a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:61895 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030595AbXBFXm5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 18:42:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so35677uga
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 15:42:55 -0800 (PST)
In-Reply-To: <58cb370e0702061500g3047b8ccpca894962491b588a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Sergei Shtylyov wrote:
> 
> The driver's tuneproc() method fails to set the drive's own speed -- fix this
> by renaming the function to cmd64x_tune_pio(), making it return the mode set,
> and "wrapping" the new tuneproc() method around it; while at it, also get rid
> of the non-working prefetch control code (filtering out related argument values
> in the "wrapper"), remove redundant PIO5 mode limitation, make cmdprintk() give
> more sensible mode info, and remove mention about the obsolete /proc/ interface.
> Get rid of the broken config_chipset_for_pio() which always tried to set PIO4,
> switch to always auto-tuning PIO instead.
> Oh, and add the missing PIO5 support to the speedproc() method while at it. :-)
> 
> Warning: compile tested only -- getting to the real hardware isn't that easy...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

thanks for updating the patch

applied
