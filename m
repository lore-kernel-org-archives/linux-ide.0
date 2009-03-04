From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Mysteriously slow writes SiI 3124
Date: Wed, 4 Mar 2009 14:06:02 -0500
Message-ID: <87f94c370903041106g3aba0155l6bd0ca0232a268e@mail.gmail.com>
References: <49AB079A.9090407@rabbit.us> <49AE294D.2020002@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17166 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656AbZCDTGF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 14:06:05 -0500
Received: by qw-out-2122.google.com with SMTP id 5so5150465qwi.37
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2009 11:06:03 -0800 (PST)
In-Reply-To: <49AE294D.2020002@rabbit.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Rabbitson <rabbit+list@rabbit.us>
Cc: linux-ide@vger.kernel.org

On Wed, Mar 4, 2009 at 2:10 AM, Peter Rabbitson <rabbit+list@rabbit.us> wrote:
> No takers? Can I provide more info/measurements/whatever? I would
> really like to get to the bottom of this, pretty frustrating.
>
> Peter Rabbitson wrote:
>> Hello,
>>
>> I have a sil 3124 PCI-X SATA card with 4 drives attached to it.
>> When I read simultaneously from all 4 drives, I get the expected
>> ~220MB/s combined read speed, limited by the presence of a 32bit
>> card on the same bus (entire bus runs on 66mhz, mix of 64 and 32
>> bit cards). When I write to the drives however I only get half of
>> that ~106MB/s combined. Can someone shed some light?
>>
>> All measurements are made on an idle system in single-user mode
>>
>>
>> Combined read:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if="/dev/${d}2" of=/dev/null count=500 bs=1M & done
>> [1] 30243
>> [2] 30244
>> [3] 30245
>> [4] 30246
>> root@Arzamas:~/tr# 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.23146 s, 56.8 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.3649 s, 56.0 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.59152 s, 54.7 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 9.60045 s, 54.6 MB/s
>>
>>
>> Combined write:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of="/dev/${d}2" if=/dev/zero count=500 bs=1M & done
>> [1] 30239
>> [2] 30240
>> [3] 30241
>> [4] 30242
>> root@Arzamas:~/tr# 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.4508 s, 27.0 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.6314 s, 26.7 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.7663 s, 26.5 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 19.7598 s, 26.5 MB/s
>>
>>
>> Individual read (making sure disks are good):
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd if="/dev/${d}2" of=/dev/null count=500 bs=1M ; done
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.00963 s, 105 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.15979 s, 102 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.19258 s, 101 MB/s
>> 500+0 records in
>> 500+0 records out
>> 524288000 bytes (524 MB) copied, 5.24153 s, 100 MB/s
>> root@Arzamas:~/tr#
>>
>>
>> Individual write:
>> root@Arzamas:~/tr# for d in sde sdb sdc sdd ; do dd of="/dev/${d}2" if=/dev/zero count=500 bs=1M ; done
<snip>

Did you verify /dev/zero is not the problem.

It has been known to have throughput bugs that limit its ability to
generate zeros.  Strange I know.

I always do a quick dd if=/dev/zero of=/dev/null bs=1m count=10000

type test to make sure I have good functionality in /dev/zero and
/dev/null.  (Never heard of an issue with /dev/null, but I have to
send those zeros somewhere.)

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
