From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY (take 2)
Date: Tue, 08 May 2007 22:59:52 +0800
Message-ID: <46409068.4040902@tw.ibm.com>
References: <463EAB4D.3000309@tw.ibm.com>	<463ED8B9.4060501@gmail.com>	<463F0B25.40103@tw.ibm.com>	<463F0DAD.5060307@gmail.com>	<463F1374.1010100@tw.ibm.com>	<463F1509.30100@gmail.com>	<46405F50.5090901@tw.ibm.com>	<20070508130025.7693980c@the-village.bc.nu>	<464066A4.1010008@gmail.com>	<20070508132046.70a4d9ed@the-village.bc.nu>	<46406C9A.4000802@gmail.com> <20070508134540.509f4704@the-village.bc.nu> <464073B1.80303@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:48030 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934156AbXEHPAQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 11:00:16 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l48F0FWm023706
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 11:00:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l48F0F71175438
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 09:00:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l48F0Eek005941
	for <linux-ide@vger.kernel.org>; Tue, 8 May 2007 09:00:15 -0600
In-Reply-To: <464073B1.80303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:

> 
> I guess it's about time to listen what Jeff thinks.
> 
> Albert, if Jeff agrees with pushing HSM or data transfer to workqueue,
> are you interested in doing that?  The HSM is your baby after all.  :-)
> 

Moving HSM task to the workqueue looks good idea. The mouse cursor of my
X desktop doesn't move smoothly when blocks of PIO are going in hard irq.
Hopefully we can do better with that.

Yes, I am interested in doing it, if Jeff also ack.
--
albert

