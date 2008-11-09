From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.28-rc3: OOPS libata-eh.c:3259
Date: Sun, 09 Nov 2008 12:43:25 +0900
Message-ID: <49165C5D.9090403@gmail.com>
References: <f7848160811081814q1dff8fa5t82a226a354766c6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:13332 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYKIDnc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Nov 2008 22:43:32 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1066681tic.23
        for <linux-ide@vger.kernel.org>; Sat, 08 Nov 2008 19:43:30 -0800 (PST)
In-Reply-To: <f7848160811081814q1dff8fa5t82a226a354766c6c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>

Hello,

Parag Warudkar wrote:
> Got the below oopses while trying to burn a CDRW.
> 
> libata-eh.c:3259 is -
> /* make sure nr_active_links is zero after EH */
> WARN_ON(ap->nr_active_links);

(cc'ing Jens) I saw this yesterday too and am debugging it.  I think
it's related to recent conversion to block layer tagging.  I'll
investigate and let you know when I know more.

Thanks.

-- 
tejun
