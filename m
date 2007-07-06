From: Ruairi Hickey <Ruairi.Hickey@collon.ie>
Subject: Re: libata-tj-stable
Date: Fri, 06 Jul 2007 12:20:07 +0100
Message-ID: <468E2567.8090405@collon.ie>
References: <468CE343.7050407@collon.ie> <468CE4C0.6020102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.dkit.ie ([193.1.42.16]:43072 "EHLO mx2.dkit.ie"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758857AbXGFMGm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jul 2007 08:06:42 -0400
Received: from [172.16.22.18] (helo=mailserver01.dkit.ie)
	by mx2.dkit.ie with esmtp (Exim 4.63)
	(envelope-from <Ruairi.Hickey@collon.ie>)
	id 1I6lrR-00089r-0C
	for linux-ide@vger.kernel.org; Fri, 06 Jul 2007 12:20:29 +0100
In-Reply-To: <468CE4C0.6020102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
>
> Ruairi Hickey wrote:
>   
>> Hi Tejun,
>>    I've being testing a storage box from Norco (DS-1220) which comes
>> with 12 SATA drives and is connected to a Linux server via a PCI-e
>> e-sata card based on the Sil3124.  To get this to be recognised I used
>> your latest patch libata-tj-2.6.22-rc6-20070702 and the vanilla
>> 2.6.22-rc6 kernel.  Under load testing I get exceptions in my logs, (see
>> below).  Can I be of any assistance to you to help debugging this... (I
>> can program / read reasonably well in most languages)
>>
>>
>> Ruairi
>>
>> Jul  5 14:20:09 samba01 kernel: ata2.03: cmd
>> 60/08:00:47:c7:f5/00:00:2c:00:00/40 tag 0 cdb 0x0 data 4096 in
>> Jul  5 14:20:09 samba01 kernel:          res
>> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>     
>
> Hmm... it's timeout on FPDMA_READ command.  It could be a transient
> hardware problem or fluctuating power, what not.  I need more info to
> diagnose the problem.
>
> 1. Please cc linux-ide@vger.kernel.org
>
> 2. How reproducible is the problem?
>
> 3. If the problem is reproducible, is the problem confined a specific
> drive?  If so, what happens if you move the drive to different slot (ie.
> exchange two drives)?  Does the error follow the drive or stay with the
> slot?
>
> 4. Your drive probably has a dip switch which forces 1.5Gbps link speed.
>  Does that help?
>
> Thanks.
>
>   
Hi Tejun,
    Thanks for your pointers, I got sidetracked yesterday with other 
work.... The problem is reproducible by doing a simple 'dd' to create a 
multiple GB file.  The error occurs on different drives at the moment.  
I am on vacation for the next week but I will remove the linux Raid 
array and test the drives individually (hopefully today, but maybe when 
I get back from vacation) and report back to you then...

Ruairi

