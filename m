From: Danny Cox <Danny.Cox@ECWeb.com>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 15:00:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085166052.833.87.camel@vom>
References: <1084717146.3576.3.camel@patibmrh9>
	 <200405211746.35015.bzolnier@elka.pw.edu.pl> <1085163796.833.61.camel@vom>
	 <200405212036.08190.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blackbox.ecweb.com ([199.72.99.40]:34830 "EHLO
	blackbox.ecweb.com") by vger.kernel.org with ESMTP id S266002AbUEUS6T
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 14:58:19 -0400
In-Reply-To: <200405212036.08190.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Bartlomiej,

On Fri, 2004-05-21 at 14:39, Bartlomiej Zolnierkiewicz wrote:
> You do 'goto abort' while not holding locks.

	Please disregard the previous email.  I figured it out.  Part of that
patch came from an earlier version where I was doing the kmalloc() later
in the routine.  I didn't reason very well when I still had the error
flow going to the abort.

	Sorry about the wasted bandwidth!  Although it wasn't wasted entirely. 
I learned a thing or two.

	Thanks!

-- 
Daniel S. Cox
Electronic Commerce Systems

