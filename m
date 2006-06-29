From: Tejun Heo <htejun@gmail.com>
Subject: Re: [DOC] SATA status report updated
Date: Fri, 30 Jun 2006 02:51:27 +0900
Message-ID: <44A4131F.8020904@gmail.com>
References: <44A0B50F.40404@garzik.org> <87f94c370606290741v45e63336n30df5fdc6a5c2bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:59567 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751112AbWF2RvG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 13:51:06 -0400
Received: by wr-out-0506.google.com with SMTP id 50so119911wri
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 10:51:05 -0700 (PDT)
In-Reply-To: <87f94c370606290741v45e63336n30df5fdc6a5c2bac@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greg Freemyer wrote:
> On 6/27/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Updated the SATA status report(s) found at
>>
>>         http://linux-ata.org/
>>
>> In particular, I created a matrix of drivers and features, to give
>> people an idea of fine-grained driver status:
>>
>>         http://linux-ata.org/driver-status.html#matrix
>>
>> As always, comments, questions, and additions are welcome.
>>
>>         Jeff
> Jeff / Tejun,
> 
> Great work.  If the feedback about reversion issues continues to be as
> minimal as it currently is it appears you appear to have rolled out a
> great enhancement with minimal errors introduced.  I expect to be
> using sata/e-sata much more extensively now that this new EH process
> is in place.
> 
> Any practical experience about which PCI controllers and/or enclosures
> would be best to get if I wanted to use e-Sata and the
> hotplug/warmplug logic?

I primarily work on sil controllers and ICH7R piix/ahci because I have 
access to the hardware and docs.  So, those tend to get new features 
first and get a lot of testing.

If you're planning on using Port Multiplier, sil3124/32 would be the 
best bet ATM.

-- 
tejun
