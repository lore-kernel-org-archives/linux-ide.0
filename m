From: Ricky Cheng <rickycheng@qnap.com.tw>
Subject: Re: [info] Silicon Image device hotplug debounce
Date: Mon, 1 Aug 2005 04:23:34 +0000 (UTC)
Message-ID: <loom.20050801T061802-766@post.gmane.org>
References: <42E672C1.4000502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261527AbVHAFki (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2005 01:40:38 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DzT2Q-0004fM-1f
	for linux-ide@vger.kernel.org; Mon, 01 Aug 2005 07:40:34 +0200
Received: from mail.qnap.com.tw ([mail.qnap.com.tw])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 01 Aug 2005 07:40:34 +0200
Received: from rickycheng by mail.qnap.com.tw with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 01 Aug 2005 07:40:34 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik <at> pobox.com> writes:

> 
> 
> This is some info that Silicon Image provided, for use in developing 
> SATA hotplug.  This info is public and not NDA as of the publishing of 
> the SiI 311x hardware documentation at
> 
> 	http://gkernel.sourceforge.net/specs/sii/
> 
> Kudos again to SiI for opening their 311x and CMD680 [PATA] docs.
> 
> 	Jeff
> 
> 
> 
> 
> Here are some writeups for our 3112/3152 hot plug/unplug handling.  Hope it 
will
>  help in your open source development.
> 
> For the 3114 controller, the sequence is essentially the same as the 3112 
except
>  that the PHYRDY change handler does not need to reset the channel and of 
course
>  obvious changes to handle the two additional channels of the 3114.
> 
> Best regards,
> [silicon image person]
> 


Hi, This is Ricky. I am finding solution of sil 3512 chip hotswap problem.
I think this doc can help some. But I don't really understand libata very much.
Can someone help some ideas?..Thanks
I know I should do something in interrupt handler in libata.c like check 
status of plug/unplug. Is is right?



