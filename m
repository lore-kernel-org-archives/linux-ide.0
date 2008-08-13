From: Tejun Heo <htejun@gmail.com>
Subject: Re: bad sectors, suspicious behaviour
Date: Wed, 13 Aug 2008 19:50:05 +0900
Message-ID: <48A2BC5D.5060801@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:30463 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbYHMKun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 06:50:43 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1513704tic.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 03:50:42 -0700 (PDT)
In-Reply-To: <48A2BBDC.2090201@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Artem Bokhan wrote:
> patch did not help,  but I found additional necessary condition (I
> didn't take it into account before system reboot):
> 
> to reproduce the problem from scratch it is necessary to
> 
> echo 1 > 
> /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:02.0/host4/target4:0:0/4:0:0:0/timeout
> 
> 
> returning the value to 30 do not help.
> 
> With default 30 secs the problem can not be reproduced

Can you please post full kernel log?

-- 
tejun
