From: Danny Cox <Danny.Cox@ECWeb.com>
Subject: Re: [PATCH] kmalloc old_hwif
Date: Fri, 21 May 2004 14:55:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085165718.833.83.camel@vom>
References: <1084717146.3576.3.camel@patibmrh9>
	 <200405211746.35015.bzolnier@elka.pw.edu.pl> <1085163796.833.61.camel@vom>
	 <200405212036.08190.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blackbox.ecweb.com ([199.72.99.40]:30731 "EHLO
	blackbox.ecweb.com") by vger.kernel.org with ESMTP id S265988AbUEUSwp
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 14:52:45 -0400
In-Reply-To: <200405212036.08190.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Bartlomiej,

On Fri, 2004-05-21 at 14:39, Bartlomiej Zolnierkiewicz wrote:
> You do 'goto abort' while not holding locks.

	Yes, you're correct.  Should I be holding the locks?  I didn't think
that you'd want to call kmalloc() with GFP_KERNEL inside a spinlock
because it might sleep.  So, I moved the kmalloc() to be one of the
first things done to avoid being inside the lock(s).  The comment at the
top of the function is correct: it IS bonkers!

> Anyway this is the minor issue,
> the major issue is that...  you are late 52 hours... ;-)
> 
> Similar patch from Chris Wedgwood has been merged recently.

	Cool!  Like I said, I mainly wanted to get some form of this idea into
ide_unregister().

	Thanks!

-- 
Daniel S. Cox
Electronic Commerce Systems

