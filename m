From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Thu, 24 Aug 2006 04:24:18 +0900
Message-ID: <44ECAB62.8030804@gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>	 <44EC8128.2040204@gmail.com> <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:32789 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965133AbWHWTZV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Aug 2006 15:25:21 -0400
Received: by nz-out-0102.google.com with SMTP id n1so178225nzf
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2006 12:25:20 -0700 (PDT)
In-Reply-To: <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com

Fajun Chen wrote:
> On 8/23/06, Tejun Heo <htejun@gmail.com> wrote:
>> Fajun Chen wrote:
>> > Hi Folks,
>> >
>> > I used Linux 2.6.18-rc2 with Jeff Garzik's git libata patch for new EH,
>> > hotplug,
>> > and pata support. Hardware is ARM IOP80321 with PCI-X. Host adapters
>> > is pata Sil680.  The sequence of actions are "power off drive ->
>> > remove drive -> power on drive -> add drive" and there's kernel errors
>> > while adding the drive.  Complete dmesg traces attached. Has anyone
>> > seen this problem before?
>>
>> Can you please try the latest -mm?
> We have had issues with -mm to get it to run on our ARM IOP80321
> board.  Do you have any patches which can be applied to 2.6.18 rc2?

ISTR there has been some SCSI ref counting bug fixed recently.  I can't 
really pinpoint it.  I've taken a long look at libata-scsi after reading 
your bug report but couldn't find anything wrong although I found out 
that things can be simplified quite a bit.  I'll submit patch for that 
after resolving this issue.

Does 2.6.18-rc4 work on your platform albeit without sil680 support?  If 
so, I can send you a patch for sil680 over 2.6.18-rc4.

-- 
tejun
