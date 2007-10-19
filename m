From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.22.5] irq X: nobody cared but X is successfully used by
 libata
Date: Fri, 19 Oct 2007 12:23:15 +0900
Message-ID: <47182323.10706@gmail.com>
References: <20070826203513.4fa35f68@tux.DEF.witbe.net> <6bffcb0e0708261637s3369dd6fl1f833461e41c4daa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:52746 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbXJSDX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 23:23:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so330736wra
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 20:23:26 -0700 (PDT)
In-Reply-To: <6bffcb0e0708261637s3369dd6fl1f833461e41c4daa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Paul Rolland <rol@as2917.net>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

> On 26/08/07, Paul Rolland <rol@as2917.net> wrote:
>> My machine (an ASUS P5W-DH-Deluxe, Core2, 4Go RAM, 3 SATA and 2IDE) is
>> reporting a :
>> irq 23: nobody cared (try booting with the "irqpoll" option)
>> together with a Call Trace, but :
>>  - irqpoll is present on the command line,
>>  - the irq is reported to be used by libata,
>>  - the irqpoll option is mandatory if I want _some_ of my SATA disks to be
>>    accessible.
>>
>> I've attached a file with :
>>  - dmesg,
>>  - cat /proc/interrupts
>>  - lspci
>>  - lspci -vvv
>>  - my .config
>>
>> I've tried mounting and accessing all the disks, and it works.
>> The last weird thing : though reported as used by libata, the irq 23 counter
>> seems to be fixed at 200001, though I've mounted and accessed all the
>> disks !

Does this still happen with 2.6.23?  If so, please post boot log.  Thanks.

-- 
tejun
