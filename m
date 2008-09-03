From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/4] ide: Implement disk shock protection support
Date: Wed, 03 Sep 2008 23:33:39 +0200
Message-ID: <8763pc29u4.fsf@denkblock.local>
References: <87wshzplvk.fsf@denkblock.local>
	<20080829211345.4355.93873.stgit@denkblock.local>
	<200809012129.14979.bzolnier@gmail.com>
	<87ljy90zin.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:46138 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYICVfB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Sep 2008 17:35:01 -0400
In-Reply-To: <87ljy90zin.fsf@denkblock.local> (Elias Oltmanns's message of
	"Wed, 03 Sep 2008 22:01:52 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns <eo@nebensachen.de> wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
[...]
>> Also could you please move the new code to a separate file (i.e.
>> ide-park.c) instead of stuffing it all in ide.c?
>
> This is probably a sensible idea especially since there may be more once
> we go ahead with the in-kernel solution.

Sorry, I forgot to mention that I haven't a clue as to what headers to
include explicitly in such a file. Actually, ide-park.c compiles on my
system just with ide.h included. This would, however, be an unsuitably
minimal approach, I fear. Some advice would be most welcome.

Regards,

Elias
