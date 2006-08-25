From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Sat, 26 Aug 2006 05:32:04 +0900
Message-ID: <44EF5E44.1010002@gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>	 <8202f4270608231349v5aabace2xaff8fe93c133a7ca@mail.gmail.com>	 <20060824070257.GD21866@htj.dyndns.org>	 <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>	 <44EDDB91.1050102@gmail.com>	 <8202f4270608241701g494bfadaw74dd3d059182e4cc@mail.gmail.com>	 <8202f4270608250826h67edf5d7n8436961374896348@mail.gmail.com>	 <44EF18BC.8040505@gmail.com>	 <8202f4270608251027j4ae31243laab8a6bd3e433697@mail.gmail.com>	 <44EF3AA8.6040100@gmail.com> <8202f4270608251319g275ca996qb413ad41b920c044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:34769 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422889AbWHYUcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 16:32:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so1378441pyg
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 13:32:10 -0700 (PDT)
In-Reply-To: <8202f4270608251319g275ca996qb413ad41b920c044@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> On 8/25/06, Tejun Heo <htejun@gmail.com> wrote:
>> Fajun Chen wrote:
>> > Hi Tejun,
>> >
>> > Below are the tests I performed:
>> > Test1:
>> > a) Power off the drive
>> > b) echo "scsi remove-single-device h b t l" > /proc/scsi/scsi
>> > or delete using sysfs
>> > c) Power on the drive
>> > d) echo "scsi add-single-device h b t l" > /proc/scsi/scsi
>> > or scan using sysfs
>> > The kernel error in my first email is induced in this test but not
>> > consistently reproducible. In most of the case, no kernel error but sg
>> > was not reattached when adding device.
>> >
>> > Test2:
>> > Ignore step c) in test1. Basically, try to add device while the device
>> > is still powered off.
>> >
>> > Hope this helps.
>>
>> Was the drive loaded with commands issued via /dev/sgX when you did
>> above operation?
> 
> No.   One note: the kernel error I reported in my first email
> happened in ARM XSCale IOP80321 platform.

I could regenerate an oops while the drive was loaded w/ command from 
sg.  Mine occurs earlier than yours because kmalloc debug is turned on 
(the memory is poisoned on free and the the next access oopses).  It 
seems that sg has refcounting bug.

You can issue all raw commands via high level device node - e.g. 
/dev/sdX or /dev/srX, so you don't really need to use sg devices in many 
cases.

Other than sg related, I couldn't find any problem with hot/warm/pervert 
plugging.  Can you please try without any sg use?  If you need loaded 
test, just load them with regular IO or use /dev/sdX to issue raw 
commands.  I'm not sure I'll track down the sg problem.

-- 
tejun
