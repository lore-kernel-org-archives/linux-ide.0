From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 12:44:24 +0200
Message-ID: <46766208.1080305@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:41055 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064AbXFRKob (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 06:44:31 -0400
In-Reply-To: <4675F84D.3060207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi,

> The controller being ich8, I'm pretty sure it isn't a driver problem.

I think so, too. The Intel chipsets have shown to be very good in the past.

> Do the errors occur on all four drives?  Also, if things work after
> speed is downgraded to 1.5Gbps, it doesn't really matter.  There's no
> noticeable performance difference for single disk anyway.

Yes, they do occur on all drives, as far as I know. With 1.5Gbps, the 
error doesn't occur much as often and not under normal circumstances, 
only when doing a real hard stress test.

Would it make sense to downgrade to 1.5 Gbps via a boot option?

Florian
