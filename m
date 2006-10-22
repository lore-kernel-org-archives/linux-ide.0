From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4 (updated) II
Date: Sun, 22 Oct 2006 10:36:14 -0600
Message-ID: <453B9DFE.9070802@shaw.ca>
References: <45397D22.4030200@shaw.ca> <p73ejt1m5gj.fsf_-_@verdi.suse.de>
 <453B1946.3070201@shaw.ca> <200610221519.20721.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6940 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751272AbWJVQgY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 12:36:24 -0400
In-reply-to: <200610221519.20721.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andi Kleen wrote:
>> Hmm.. The system hanging up for 5 minutes 
> 
> I've actually seen that before on different systems. Sometimes
> under some IO loads writes can be really starved for that long
> and they block the calling process. Normally it only happened
> when a very slow IO device (like slow USB storage) was involved
> 
> e.g. typical trace:
> 
> sshd          D ffff810001072b20     0 11554   3381         11556 11127 (NOTLB)
>  ffff810114dffb08 0000000000000086 5353535353535353 5353535353535353
>  5353535353535353 000000000000057e ffff81014b344af0 ffff81014b404770
>  000001ede41c7140 ffff81014b344cc8 5353535300000001 5353535353535353
> Call Trace:
>  [<ffffffff802e8cc2>] start_this_handle+0x2f4/0x37b
>  [<ffffffff802e8e16>] journal_start+0xcd/0x105
>  [<ffff81014b11e800>]
> DWARF2 unwinder stuck at 0xffff81014b11e800
> Leftover inexact backtrace:
>  [<ffffffff802da5f5>] ext3_dirty_inode+0x28/0x7b
>  [<ffffffff80291bbb>] __mark_inode_dirty+0x2c/0x17d
>  [<ffffffff80256611>] do_generic_mapping_read+0x3b0/0x3c2
>  [<ffffffff80255415>] file_read_actor+0x0/0xd6
>  [<ffffffff80256d8b>] generic_file_aio_read+0x164/0x1b8
>  [<ffffffff80278774>] do_sync_read+0xc9/0x10c
>  [<ffffffff80241ecc>] autoremove_wake_function+0x0/0x2e
>  [<ffffffff80531aef>] cond_resched+0x34/0x3b
>  [<ffffffff80258f27>] __alloc_pages+0x5e/0x2ae
>  [<ffffffff8027365a>] cache_alloc_refill+0xf1/0x1f8
>  [<ffffffff80278ade>] vfs_read+0xa8/0x14e
>  [<ffffffff8027bbbd>] kernel_read+0x38/0x4c
>  [<ffffffff8027d6d4>] do_execve+0x105/0x1f9
>  [<ffffffff80207bc9>] sys_execve+0x33/0x8b
>  [<ffffffff80209857>] stub_execve+0x67/0xb0
> 
> 
> I've got quite a lot of processes in journal_start -> start_this_handle.
> I suppose they're waiting for the transaction to finish.

It could be that with 8GB of RAM you've got a ton of buffered writes 
piled up which the kernel has decided need to be written out and which 
takes 5 minutes.. That amount of time seems a bit extreme to be blocking 
other IO, though..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
