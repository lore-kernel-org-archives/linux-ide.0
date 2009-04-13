From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Mon, 13 Apr 2009 16:28:17 -0400
Message-ID: <49E3A061.7070400@pobox.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com> <49E36F3F.6080907@ru.mvista.com> <49E37385.6070506@pobox.com> <200904132142.49279.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39014 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZDMU2a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 16:28:30 -0400
In-Reply-To: <200904132142.49279.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> As I see it, there was absolutely no need to rush things -- I simply didn't
> get to processing newer submissions yet and I would just push Sergei's patch
> in the next IDE pull request (which happened on March 13th).

That is an IDE-centric perspective.  It was a cross-tree depedency, and 
_I_ should not need to wait for you, particularly when you are 
constantly complaining about lacking time for IDE maintenance.


> Simple reminder/query about the patch status would be more than enough but
> instead you wasted time for everybody by splitting libata part from Sergei's
> patch (without updating patch summary+description which I had to fix) and
> later forgotting about it.  Moreover instead of simply pushing forgotten
> part yourself you requested Sergei to resubmit it and at the same time you
> tried to put the blame about the whole situation on me.

The onus is always on the submittor to monitor their patches, resubmit, 
etc.  It is simply not scalable to constantly ping submittors, keep 
track of their individual development schedules, etc.

	Jeff


