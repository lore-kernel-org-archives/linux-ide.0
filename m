From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/6] ide-pmac: PIO fixes
Date: Fri, 13 Jul 2007 10:52:59 +1000
Message-ID: <1184287979.6059.165.camel@localhost.localdomain>
References: <200707110204.07540.bzolnier@gmail.com>
	 <200707122133.09054.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60733 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbXGMAxJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 20:53:09 -0400
In-Reply-To: <200707122133.09054.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Kyle McMartin <kyle@mcmartin.ca>


> > This patch should have no effect on the default kernel behavior because
> > IDE pmac driver doesn't enable ->autotune (this would also explain why some
> > of the above bugs remained unfixed for so long).
> 
> This part of the patch description is actually incorrect: ->tuneproc is used
> unconditionally during suspend so the patch has the real effect (hopefully
> positive :) on the default kernel behavior.

I need to spend some time looking in details and testing. Thanks for
doing it though. I'll try to get through it next week. Please don't
hesitate to ping me if you don't hear back from me soon.

Ben.


