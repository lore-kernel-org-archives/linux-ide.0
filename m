From: Mark Lord <liml@rtr.ca>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Wed, 23 Apr 2008 09:30:24 -0400
Message-ID: <480F39F0.7050207@rtr.ca>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi> <480DE3C4.5@ru.mvista.com> <480DE6F5.8060403@gmail.com> <480DE9E8.2070809@ru.mvista.com> <480DEB1F.5060500@gmail.com> <480DF7B7.9030000@rtr.ca> <480DF876.7070800@gmail.com> <480DF9BD.1080104@rtr.ca> <480DFE76.8000809@ru.mvista.com> <480E345D.9090406@ru.mvista.com> <480E9C15.6080103@gmail.com> <480EB930.1040308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2097 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbYDWNa1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 09:30:27 -0400
In-Reply-To: <480EB930.1040308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Aik... We can do s/sff/tf/ and leave bmdma alone to avoid even more 
>> confusion but sff has meant tf base interface for quite some time now 
>> in libata and I think it'll be better to remember that sff is the new 
>> tf. Sorry about the mess.
> 
> 
> This renaming was discussed at the time on lkml and linux-ide, the 
> patches and git pushes were CC'd, and I do not recall these complaints 
> being raised at the time.
> 
> At this point, it's too ingrained in libata.  Another rename would IMO 
> just cause more needless churn.
..

I heartily agree.

Besides, we all seem to understand that -sff means the register level
programming interface for ATA, with and without the old style bmdma.

As opposed to some funky modern host queue style of interface.

It's as good a split as any.

cheers
