From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PROBLEM: Silicon Image 3112 Lockups
Date: Tue, 06 Sep 2005 22:13:46 -0400
Message-ID: <431E4CDA.6090909@pobox.com>
References: <Pine.LNX.4.63.0509061835230.2270@xmission.xmission.com> <431E4A0A.3060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51690 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750722AbVIGCOA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 22:14:00 -0400
In-Reply-To: <431E4A0A.3060504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeremy Smith <alceste@xmission.com>, Alexander Shaposhnikov <shaposh@isp.nsc.ru>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Paul Taylor <Paul.Taylor@siliconimage.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  In the following mail, I've attached a patch which might alleviate 
> errors during writes (as Alexander was reporting CRC errors with write 
> commands), but it won't do any good if you're getting errors during 
> reading.
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=112602112819183&w=2

Note that I would put BIG CAPITAL LETTER WARNINGS on that patch, since 
it messes with the voltage.

	Jeff



