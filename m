From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ICH10R and Samsung HDS724040KLSA80
Date: Sun, 21 Dec 2008 18:03:15 -0600
Message-ID: <494ED943.10904@shaw.ca>
References: <b1dab3a10812211242q29515f80n54cd3b9d8b3edc34@mail.gmail.com> <alpine.DEB.1.10.0812211556540.24116@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41428 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbYLVADa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Dec 2008 19:03:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEYGc-0002hk-O6
	for linux-ide@vger.kernel.org; Mon, 22 Dec 2008 00:03:26 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2008 00:03:26 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2008 00:03:26 +0000
In-Reply-To: <alpine.DEB.1.10.0812211556540.24116@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: n37 <n37lkml@gmail.com>

Justin Piszcz wrote:
> 
> 
> On Sun, 21 Dec 2008, n37 wrote:
> 
>> I have a P5Q Deluxe motherboard which comes with ICH10R. One of my
>> hard disks is a Samsung Deskstar 7K400 HDS724040KLSA80
>> (http://www.hitachigst.com/hdd/support/7k400/7k400.htm). I have set
>> ICH10R in AHCI mode in BIOS. It is almost impossible to get the hard
>> disk to initialize properly. Here is the relevant portion of the
>> kernel log:
> 
> General question: Is it possible a/the drive is not AHCI-compliant?  For 
> example if one uses older (non-3.0Gbps SATA drives) or IDE->SATA 
> converters, can one use AHCI with these drives or do they have to be 
> true sata drives w/out a bridge?

It shouldn't matter. There's no such thing as a hard drive being AHCI 
compliant or not.

