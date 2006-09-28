From: justin@jmicron.com
Subject: Re: [PATCH] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 16:52:06 +0800
Message-ID: <OFA0C9EAEA.6E470068-ON482571F7.002FA13E-482571F7.0030BE1D@jmicron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:29314 "EHLO
	spamfilter.jmicron.com") by vger.kernel.org with ESMTP
	id S1751791AbWI1Iui (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Sep 2006 04:50:38 -0400
Received: from jms10 (pop3.jmicron.com [192.168.101.166])
	by spamfilter.jmicron.com (8.13.1/8.13.1) with ESMTP id k8S8vRui010022
	for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 16:57:32 +0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mail@philipp-wagner.com, linux-ide@vger.kernel.org, jeff@garzik.org, justin@jmicron.com

Dear Tejun,

> Justing, the solution doesn't seem to work.  Have you guys verified
> that the controller doesn't send the second H2D regsiter FIS clearing
> SRST w/ 20us delay?  If you guys did, the patch needs to make into
> tree whether it helps this particular case or not.  If not, I think
> it's best to leave it alone.

Sure , we did it.

the hotplug problem happened on some sata enclosure
but It sounds like for particular case.

Thanks.

