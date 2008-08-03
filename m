From: Hong Tran Duc <hongtd2k@gmail.com>
Subject: Oops when read/write or mount/unmount continuously ~ 600.000 times
Date: Sun, 03 Aug 2008 19:49:50 +0700
Message-ID: <4895A96E.2040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:31074 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbYHCMtz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 08:49:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2578919wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 05:49:55 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org

Hi all,

I=92m using kernel 2.4.20 with fully preemptive enable (patch & set the=
=20
CONFIG option). My CPU is PowerPC 750FX, HDD 80GB, RAM 512,

I got many Oops when try to mount/unmount or read/write on ATA HDD=20
continuously about 600.000 times (in several hours). Oops often occurre=
d=20
when CPU trap SIGSEGV or SIGILL, sometime on page management module,=20
sometimes on scheduler, block I/O manipulation, filesystem.

The most frequently happened on:
Block I/O : make_request, generic_make_request, submit_bh, bdfind, bmap=
,=20
__wait_on_buffer ..
=46ilesystem: journal_commit_transaction, kill_super, invalidate_inode,=
=20
invalidate_list ..

The reasons is almost linked list on those function was broken. Ex:=20
linkedlist->next linkedlist->prev =3D NULL or set to invalid address.
In the situation SIGILL, the instruction pointer (NIP) is same as the=20
return address register (LR).

The newest Oops, I got on function __wait_on_buffer(). The main=20
sequences of __wait_on_buffer() are:
1. put_bh -> atomic_inc(bh->b_count);
2. add wait queue
3. loop: do some thing task manipulation, call *schedule()*
4. remove wait queue
5. get_bh -> atomic_dec(bh->b_count); *<- Got Oops here, SEGV because=20
bh->b_count =3D R25 =3D 0x02 *

After analysis assembly code (I upload on pastebin bellow) at this=20
point, I found that:
* At the point (1) -> address of bh->b_count stored in register r25.
* The point from (2) ->(4) all of affect to register 25 will be restore=
d=20
from stack (r25 act as non violent register in gcc ABI).
* An step 5, *r25 =3D 0x02 ??? I don=92t know why r25 is changed ? May =
be=20
stack on somewhere was corrupted ?*

This Oops is very difficult to replicate (about 2 hours run stress test=
=20
program). I try to increase/reduce the HZ 10 times, but the frequency o=
f=20
bug is no change. And, I tried on ext2/ext3, it=92s same result.

I=92m really confusing now, I don=92t know where the real problem is, a=
nd=20
what is effected with the frequency of Oops, how to debug and figure=20
this bug ?

I post my situation to this ML and hope to get some advice from you,

Some Oops, I uploaded on pastebin here:
http://vnoss.net/p/5783
http://vnoss.net/p/5785

Sources and assembly of __wait_on_buffer()
http://vnoss.net/p/5784


Thanks for your help,

--=20
nm.

GPG Key ID: 0xDD253B25
=46ingerprint: 2B17 D64A 9561 A443 2ABC 1302 4641 D0B7 DD25 3B25

