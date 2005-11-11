From: Spencer Tuttle <rodeojones@fastmail.fm>
Subject: Re: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Fri, 11 Nov 2005 10:08:43 -0700
Message-ID: <4374D01B.9010706@fastmail.fm>
References: <1131648518.26701.247242836@webmail.messagingengine.com> <437471D0.3090404@pobox.com> <20051111121447.GQ3699@suse.de> <4374A4AC.8010007@pobox.com> <20051111142905.GV3699@suse.de> <20051111143850.GX3699@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.contentwatch.com ([64.90.206.132]:6796 "EHLO
	mail.contentwatch.com") by vger.kernel.org with ESMTP
	id S1750860AbVKKRIY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Nov 2005 12:08:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.contentwatch.com (Postfix) with ESMTP id 4B89A4DAC1
	for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2005 10:08:22 -0700 (MST)
Received: from mail.contentwatch.com ([127.0.0.1])
 by localhost (mail.contentwatch.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26160-20 for <linux-ide@vger.kernel.org>;
 Fri, 11 Nov 2005 10:08:21 -0700 (MST)
Received: from [10.1.1.143] (vlxgw.contentwatch.com [64.90.206.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.contentwatch.com (Postfix) with ESMTP id 9BB944E94
	for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2005 10:08:20 -0700 (MST)
In-Reply-To: <20051111143850.GX3699@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

>>>>>Spencer Tuttle wrote:
>>>>>
>>>>>
>>>>>>I have just compiled the new 2.6.14 kernel from the gentoo-sources tree.
>>>>>>
>>>>>>I can access the drives just fine, but it seems really slow.  Here is
>>>>>>the dmesg output when I load the kernel module
>>>>>
>>>>>That's expected, since the driver in 2.6.14 only does PIO mode.
>>>>>
>>>>>Try 2.6.14-gitN which supports EDMA.


Ok I will seek this out and compile it.

Its a bummer i didn't ask sooner, before i tried to create a software 
raid 5 array, (which took 5 days to build) :-)

>>>>
>>>>
>>>>Did you see these as well:
>>>>
>>>>blk_queue_max_hw_segments: set to minimum 1

Yes I did, they appeared 32 times for each drive.

Thank You,
