From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 23:57:44 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10310082355530.12324-100000@master.linux-ide.org>
References: <20031008164851.GT29736@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15891
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261901AbTJIHAk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Oct 2003 03:00:40 -0400
In-Reply-To: <20031008164851.GT29736@redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


The rules are different in POLLing.

Totally different state machine, and nothing seen here to date.
You can not call any kernel services you can not depend upon.

Using altstat is actually required but that is another day.

Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 Oct 2003, Dave Jones wrote:

> On Wed, Oct 08, 2003 at 09:36:36AM -0700, Andre Hedrick wrote:
>  > 
>  > Does not matter, priority is to get content to platter and the hell with
>  > everything else.
> 
> I don't buy this. Without correct udelay()'s, how is code like this..
> 
>         for (i = 0; i < 10; i++) {
>                 dump_udelay(1);
>                 if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
>                         return 0;
>         } 
> 
> expected to work ? It won't wait for 10usec at all, but be over almost instantly.
> Ramming commands at the drive before its status has settled doesn't strike
> me as a particularly safe thing to do.
> 
> 		Dave
> 
> -- 
>  Dave Jones     http://www.codemonkey.org.uk
> 

