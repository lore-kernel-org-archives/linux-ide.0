From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Fri, 11 Jan 2008 12:11:30 +0900
Message-ID: <4786DE62.6090604@gmail.com>
References: <200801051734.18088.marc@fallon.classyad.com> <478434C4.5000209@gmail.com> <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com> <Pine.LNX.4.64.0801102143150.11200@classyad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:53852 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439AbYAKDLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 22:11:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1465660wah.23
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 19:11:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801102143150.11200@classyad.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Howard Zuckman <marc@fallon.classyad.com>
Cc: linux-ide@vger.kernel.org

Marc Howard Zuckman wrote:
> On Thu, 10 Jan 2008, Tejun Heo wrote:
> 
>>
>> Oh... I thought you were using libata drivers because you mentioned
>> pata_it821x on the subject.  The IDE driver supports 'hdparm -d 1' fine.
>> I wonder why that's not working.  Also, the driver is configuring your
>> disk to PIO0.
>>
>> Cc'ing Alan and Bartlomiej.  Guys, is this the smart mode problem?  Do
>> ide and libata have this fixed in 2.6.24-rc?
>>
> And I thought I was using pata_it821x because pata_it821x.o is compiled
> as an object file in my source tree.  On the other hand, it821x.o  is
> also compiled.
> Looking back at the .config file, CONFIG_ATA is not set, so I'm not
> quite sure why pata_821x.o does exist.
> 
> Is it possible that both drivers are present in the kernel and conflict
> with one another in some fashion?

The don't conflict.  If both are in the kernel, IDE drivers have
priority.  Can you please try the libata driver and see if anything is
different?

-- 
tejun
