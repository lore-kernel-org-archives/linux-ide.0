From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (resend)
Date: Wed, 19 Mar 2008 15:36:28 +0900
Message-ID: <47E0B46C.6030302@gmail.com>
References: <20080214184700.0bd3837d@highlander.home.lan> <47B4D02E.9030101@gmail.com> <20080215191215.430ee2e0@highlander.home.lan> <47BCE71F.2000309@gmail.com> <20080221172757.44882428@highlander.home.lan> <20080317210045.GG3189@fi.muni.cz> <20080318140116.GC8480@fi.muni.cz> <47E08762.9090704@gmail.com> <20080319061958.GK3189@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:61772 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbYCSUbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 16:31:31 -0400
Received: by el-out-1112.google.com with SMTP id v27so477777ele.17
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 13:31:30 -0700 (PDT)
In-Reply-To: <20080319061958.GK3189@fi.muni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: =?UTF-8?B?TWFsdGUgU2NocsO2ZGVy?= <maltesch@gmx.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Kasprzak wrote:
> Tejun Heo wrote:
> : Hmm... I still wanna know why it got broke in the first place.  The only
> : thing I can think of is IRQ routing problem in which case pci=nomsi or
> : irqpoll should help.  Any chance you can test the old BIOS?
> 
> 	Yes, I can. What data are you interested in? Boot logs with
> pci=nomsi and irqpoll ? Anything else?

pci=nomsi, then, irqpoll should be enough for now.

Thanks.

-- 
tejun
