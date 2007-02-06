From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] (2.6.20) cmd64x: fix PIO mode setup (take 3)
Date: Tue, 6 Feb 2007 22:11:58 +0100
Message-ID: <17864.61214.161696.671172@alkaid.it.uu.se>
References: <200702032309.43867.sshtylyov@ru.mvista.com>
	<200702040004.24918.sshtylyov@ru.mvista.com>
	<200702061745.37517.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:56505 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965465AbXBFVMR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 16:12:17 -0500
In-Reply-To: <200702061745.37517.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov writes:
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

Worked fine on my SPARC Ultra5 with a CMD646 IDE controller.

/Mikael
