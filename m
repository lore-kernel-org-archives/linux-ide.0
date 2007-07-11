From: Tejun Heo <htejun@gmail.com>
Subject: Re: Freeze after disabling write cache with hdparm -W0 /dev/sda
Date: Wed, 11 Jul 2007 17:36:52 +0900
Message-ID: <469496A4.7070902@gmail.com>
References: <46935C4D.40003@onelan.co.uk> <4694669E.7060600@gmail.com> <46949555.9060208@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:15850 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbXGKIg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jul 2007 04:36:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2213161wah
        for <linux-ide@vger.kernel.org>; Wed, 11 Jul 2007 01:36:57 -0700 (PDT)
In-Reply-To: <46949555.9060208@onelan.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-ide@vger.kernel.org

Simon Farnsworth wrote:
> Tejun Heo wrote:
>> Simon Farnsworth wrote:
>>> From a machine that's just done this freeze:
>> [--snip--]
>>> BUG: warning at kernel/softirq.c:138/local_bh_enable() (Not tainted)
>>>  [<c042afff>] local_bh_enable+0x45/0x96
>>>  [<c0603cde>] cond_resched_softirq+0x2d/0x43
>>>  [<c05d55bf>] established_get_first+0x17/0xac
>>>  [<c05d8f93>] tcp_seq_next+0x71/0x86
>>>  [<c048c004>] seq_read+0x181/0x268
>>>  [<c048be83>] seq_read+0x0/0x268
>>>  [<c0476651>] vfs_read+0xab/0x15a
>>>  [<c0476fb7>] sys_read+0x41/0x67
>>>  [<c0404ecc>] syscall_call+0x7/0xb
>>>  =======================
>> Hmmmm.. This is the only suspicious looking part of the kernel log and
>> doesn't have too much to do with ATA freeze.  30sec - 2min delay sounds
>> awfully like something caused by ATA commands timing out but libata
>> always complains verbosely about those.  Can you check dmesg again after
>> the freeze?
>>
> This is a dmesg output from after the freeze.
> 
> On machines that don't freeze, the following appears in dmesg after the
> hdparm -W0 command:
> 
> ata3.00: configured for UDMA/100
> ata3: EH complete
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
> 
> Note that the freeze appears to be drive specific; we've seen it with
> SATA Samsung drives on ata_piix, and with newer PATA Maxtor drives on
> pata_via, but not with SATA Seagates on ata_piix, or with older PATA
> Maxtor drives on pata_via.
> 
> Just a thought; is it possible to trigger libata EH from userspace? If
> so, we could write a small utility to disable write cache, then force EH
> to detect the change.

That's automatically done.  libata snoops cache on/off and triggers
revalidation but you can request manual rescan by echoing "- - -" to
/sys/class/scsi_host/hostX/scan.

-- 
tejun
