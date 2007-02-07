From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20) cmd64x: fix PIO mode setup (take 3)
Date: Wed, 7 Feb 2007 01:28:43 +0100
Message-ID: <200702070128.43716.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702061745.37517.sshtylyov@ru.mvista.com> <17864.61214.161696.671172@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:63097 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030256AbXBGAXs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 19:23:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so349868nfa
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 16:23:46 -0800 (PST)
In-Reply-To: <17864.61214.161696.671172@alkaid.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


On Tuesday 06 February 2007 22:11, Mikael Pettersson wrote:
> Sergei Shtylyov writes:
>  > The driver's tuneproc() method fails to set the drive's own speed -- fix this
>  > by renaming the function to cmd64x_tune_pio(), making it return the mode set,
>  > and "wrapping" the new tuneproc() method around it; while at it, also get rid
>  > of the non-working prefetch control code (filtering out related argument values
>  > in the "wrapper"), remove redundant PIO5 mode limitation, make cmdprintk() give
>  > more sensible mode info, and remove mention about the obsolete /proc/ interface.
>  > Get rid of the broken config_chipset_for_pio() which always tried to set PIO4,
>  > switch to always auto-tuning PIO instead.
>  > Oh, and add the missing PIO5 support to the speedproc() method while at it. :-)
>  > 
>  > Warning: compile tested only -- getting to the real hardware isn't that easy...
> 
> Worked fine on my SPARC Ultra5 with a CMD646 IDE controller.

Thanks!  I updated the patch description accordingly.

Bart
