From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] sata_nv: use hardreset only for post-boot probing
Date: Wed, 08 Jul 2009 13:17:33 +0900
Message-ID: <4A541DDD.7090608@kernel.org>
References: <4A2F60C3.2070805@kernel.org> <alpine.DEB.1.10.0906291148580.9159@asgard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60064 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbZGHESi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 00:18:38 -0400
In-Reply-To: <alpine.DEB.1.10.0906291148580.9159@asgard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: david@lang.hm
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, lament.email.si@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

david@lang.hm wrote:
> this does not apply to 2.6.30, is there a version of this patch that
> would apply to 2.6.30?

There isn't one.

> also, what testing would need to be done on this before it is a
> candidate for -stable?

sata_nv saw many disruptions with recent reset protocol update and a
lot of changes which looked perfectly okay caused interesting and
twisted regressions.  I'm not all that confident about pushing this to
-stable.  It's not like a lot of systems are broken on current 2.6.30
after all.

Thanks.

-- 
tejun
