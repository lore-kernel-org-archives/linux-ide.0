From: Mark Lord <liml@rtr.ca>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Wed, 11 Jul 2007 14:46:51 -0400
Message-ID: <4695259B.20701@rtr.ca>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3182 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587AbXGKSqx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jul 2007 14:46:53 -0400
In-Reply-To: <4694669E.7060600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Simon Farnsworth <simon.farnsworth@onelan.co.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Simon Farnsworth wrote:
>> Hello,
>>
>> We're trying to consistently disable write caching on our systems (one
>> PATA disk on /dev/sda), by running the following command during boot:
>>
>> hdparm -W0 /dev/sda
>>
>> However, on some disks, we see a freeze of between 30 seconds and 2
>> minutes after issuing this command. How do we avoid this freeze? We're
>> happy to write our own userspace utility, or change the kernel.
>>
>> We're using the pata_via driver, with a kernel that's the same code as
>> the Fedora 3189 kernel, but with CONFIG_DEBUG_STACKOVERFLOW set to n.
>>
>> From a machine that's just done this freeze:
> [--snip--]
>> BUG: warning at kernel/softirq.c:138/local_bh_enable() (Not tainted)
>>  [<c042afff>] local_bh_enable+0x45/0x96
>>  [<c0603cde>] cond_resched_softirq+0x2d/0x43
>>  [<c05d55bf>] established_get_first+0x17/0xac
>>  [<c05d8f93>] tcp_seq_next+0x71/0x86
>>  [<c048c004>] seq_read+0x181/0x268
>>  [<c048be83>] seq_read+0x0/0x268
>>  [<c0476651>] vfs_read+0xab/0x15a
>>  [<c0476fb7>] sys_read+0x41/0x67
>>  [<c0404ecc>] syscall_call+0x7/0xb
>>  =======================
> 
> Hmmmm.. This is the only suspicious looking part of the kernel log and
> doesn't have too much to do with ATA freeze.  30sec - 2min delay sounds
> awfully like something caused by ATA commands timing out but libata
> always complains verbosely about those.  Can you check dmesg again after
> the freeze?

Regardless of that, the above  WARN_ON_ONCE(irqs_disabled())
does indicate another bug in the kernel, that needs to be reported/tracked.

Who should he send that one to ?

