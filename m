From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: [PATCH] sata_mv: new exception handling (hotplug, NCQ framework)
Date: Sat, 19 May 2007 13:47:53 +0200
Message-ID: <464EE3E9.80708@wpkg.org>
References: <20070519054201.GA32686@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:48996 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763842AbXESLsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 May 2007 07:48:37 -0400
In-Reply-To: <20070519054201.GA32686@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik schrieb:
> Below is a refresh of my on-going effort to convert sata_mv to the new
> exception handling framework.  sata_mv is one of the last hold-outs, and
> its old-EH implementation blocks new features like hotplug and NCQ.
> 
> It works for me on the one 50xx and one 60xx card I tested it on, but
> other testers reported regressions, which is why it is not yet upstream.

Hi,

If I'm correct, this patch won't make to 2.6.22, and the first possible 
inclusion would be 2.6.23?

Could you summarize what other regressions were reported? I can't find 
much information about sata_mv regressiobs on linux-ide list (at least 
when looking at the subjects: lots of patches from you, and two reports 
from me).


-- 
Tomasz Chmielewski
