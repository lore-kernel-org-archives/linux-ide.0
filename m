From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Wed, 25 Feb 2009 20:43:44 +0900
Message-ID: <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <20090224171044.52e70a6b@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp05.mail.tnz.yahoo.co.jp ([203.216.246.68]:31413 "HELO
	smtp05.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752846AbZBYLoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Feb 2009 06:44:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Chuck Ebbert wrote:
> Norman Diamond wrote:
>
>> Kernel 2.6.27.7 in Slax gets a panic or oops (I can't tell which).
>> Of course I had to recompile the Slax kernel with CONFIG_IDE_TASK_IOCTL
>> enabled.
>> Kernel 2.6.19 in Knoppix handles the same HDIO_DRIVE_TASKFILE perfectly.
>> 100% reproduced in four configurations: [WRITE_DMA_EXT and WRITE_DMA].
>> (Of course the real purpose of the program will not be to write 126
>> sectors starting at 0.)
>>
>> kernel BUG at block/cfg-iosched.c:2001!
>> invalid opcode: 0000 [#1] SMP
>> Pid: 3634, comm: pee3en Tainted: G        W (2.6.27.7 #1)
>> EIP: 0060:[<c03be1a5>] EFLAGS: 00010046 CPU: 0
>> EIP is at cfq_put_request+0x45/0x50
>>  [<c03b20c0>] elv_put_request+0x10/0x20
>>  [<c03b4441>] __blk_put_request+0x71/0x80
>>  [<c03b4829>] blk_put_request+0x29/0x50
>>  [<c045e308>] ide_raw_taskfile+0x78/0x90
>>  [<c045f273>] ide_taskfile_ioctl+0x283/0x4c0
>
> block/cfq-iosched.c:
> static void cfq_put_request(struct request *rq)
> BUG_ON(!cfqq->allocated[rw]);     <================
>
> You should try 2.6.27.6 and 2.6.27.19 to see if they have the bug too.

The latest kernel available from Slax with their build script is 2.6.27.8. 
Today I modified their config to enable CONFIG_IDE_TASK_IOCTL and reproed 
the bug with 2.6.27.8.

Tomorrow I will try to figure out if I can combine 2.6.27.19 with Slax's
build script but I might not be able to figure it out.

Does anyone know when this bug was added?  2.6.19 is too old for my needs,
but the range 2.6.24 to 2.6.26 might be OK if they had taskfiles working.
Maybe I should look for a Slax version that had a kernel from 2.6.24 or so,
since I can probably customize it in a single day by now.  But if the bug
was already present in 2.6.24 then it would be a waste of time. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
