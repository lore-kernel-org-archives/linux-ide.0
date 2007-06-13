From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Wed, 13 Jun 2007 12:37:53 +0200
Message-ID: <466FC901.4060907@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:59668 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbXFMKiA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jun 2007 06:38:00 -0400
In-Reply-To: <4667D4F5.1060302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi Tejun,

> Okay, there was a bug in link speed limit logic.  That's probably why
> speed down to 1.5Gbps didn't kick in.  The attached patch contains the
> fix and hack to force 1.5Gbps.  Please give it a shot.

thanks a lot for your patch, it seems to work, at least better than 
without patch. :-)

When rsyncing about 12 GB, no trouble occured. When doing heavy stress 
tests, I receive errors again, but okay, maybe that's due to a hardware bug.

Will your patch go into the vanilla kernel?

Florian
