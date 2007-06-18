From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 13:28:49 +0200
Message-ID: <46766C71.6030607@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com> <46766208.1080305@effenberger.org> <467664F6.4060607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:41206 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760118AbXFRL2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 07:28:50 -0400
In-Reply-To: <467664F6.4060607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi Tejun,

> Hmmm... Can you use a separate PSU to power two of the four drives and
> see what happens?  Just power up a PSU as directed in the following
> webpage and connect two of the harddrives to the PSU.
> 
>   http://modtown.co.uk/mt/article2.php?id=psumod

thanks for that link, we will try that and keep you updated what happens!

> I don't know.  Till now all the problem cases have been isolated to a
> specific controller / drive combination (sata_promise and newer seagate
> drives) or hardware configuration problem (most of them being PSU
> issues), so I don't think we need such option yet.  If you have a
> problematic hardware which pukes on 3.0Gbps, libata should do the right
> thing after complaining a bit which IMHO isn't too bad.

So, loss of data or data corruption can't occur, even when we have to 
wait until the speed is limited?

Florian













