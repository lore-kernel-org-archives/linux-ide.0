From: Justin Madru <jdm64@gawab.com>
Subject: Re: [2.6.28-rc] Sata soft reset filling log
Date: Mon, 22 Dec 2008 13:51:30 -0800
Message-ID: <49500BE2.6050106@gawab.com>
References: <494318F5.4060007@gawab.com> <494EFD79.7020008@kernel.org> <494F3AD2.3060201@gawab.com> <494F3E41.60304@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:64621 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614AbYLVVvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2008 16:51:39 -0500
In-Reply-To: <494F3E41.60304@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Hello,
>
> (cc'ing Mark)
>
> Justin Madru wrote:
>   
>> Well, it's good to hear that you don't think my drive is failing (sure
>> hope it's not failing!)
>>     
>
> Yeap, it's your DVD drive.
>
>   
>> I posted the full dmesg in reply to Alan in
>> http://lkml.org/lkml/2008/12/19/30.
>>     
>
> Ah.. oops, missed the other messages.  Sorry.
>
>   
>> Also, more information about my computer can be found at:
>> http://jdserver.homelinux.org/bugreports/
>> If you need me to run anything else not found in the above links then
>> let me know.
>>     
>
> Ah.. strange.  The command protocol is ATAPI_PROT_NODATA and the drive
> should be setting DRQ to receive CDB but it's not doing that.
> Strange.  It could be that the drive is a little bit tardy with DRQ -
> ie. setting DRQ after clearing BUSY and ata_piix is now successfully
> hitting the small window for some reason.
>
> Does the attached patch make any difference?
>
> Thanks.
>
>   
Ok, I applied your patch. Unfortunately, it didn't fix my problem.
I now get a different, but similar message; not sure if it happens less 
frequently - still often though.

What changes happened between .27 and .28 could've caused this?
Anyways, below is what I get now (with your patch), including the 
frequency of occurrence.

Dec 22 11:40:28 : ata2: XXX DRQ set after 100 tries
Dec 22 11:40:28 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 11:40:28 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 11:40:28 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 11:40:28 :          cdb 1e 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 11:40:28 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 11:40:28 : ata2.00: status: { DRDY }
Dec 22 11:40:28 : ata2: soft resetting link
Dec 22 11:40:28 : ata2.00: configured for UDMA/33
Dec 22 11:40:28 : ata2: EH complete
. . . .
Dec 22 12:20:32 : ata2: XXX DRQ set after 100 tries
Dec 22 12:20:32 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 12:20:32 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 12:20:32 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 12:20:32 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 12:20:32 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 12:20:32 : ata2.00: status: { DRDY }
Dec 22 12:20:32 : ata2: soft resetting link
Dec 22 12:20:32 : ata2.00: configured for UDMA/33
Dec 22 12:20:32 : ata2: EH complete
. . . .
Dec 22 12:27:28 : ata2: XXX DRQ set after 100 tries
Dec 22 12:27:28 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 12:27:28 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 12:27:28 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 12:27:28 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 12:27:28 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 12:27:28 : ata2.00: status: { DRDY }
Dec 22 12:27:28 : ata2: soft resetting link
Dec 22 12:27:28 : ata2.00: configured for UDMA/33
Dec 22 12:27:28 : ata2: EH complete
. . . .
Dec 22 12:38:16 : ata2: XXX DRQ set after 100 tries
Dec 22 12:38:16 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 12:38:16 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 12:38:16 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 12:38:16 :          cdb 1e 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 12:38:16 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 12:38:16 : ata2.00: status: { DRDY }
Dec 22 12:38:16 : ata2: soft resetting link
Dec 22 12:38:16 : ata2.00: configured for UDMA/33
Dec 22 12:38:16 : ata2: EH complete
. . . .
Dec 22 12:47:06 : ata2: XXX DRQ set after 100 tries
Dec 22 12:47:06 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 12:47:06 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 12:47:06 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 12:47:06 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 12:47:06 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 12:47:06 : ata2.00: status: { DRDY }
Dec 22 12:47:06 : ata2: soft resetting link
Dec 22 12:47:06 : ata2.00: configured for UDMA/33
Dec 22 12:47:06 : ata2: EH complete
. . . .
Dec 22 12:49:26 : ata2: XXX DRQ set after 100 tries
Dec 22 12:49:26 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 12:49:26 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 12:49:26 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 12:49:26 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 12:49:26 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 12:49:26 : ata2.00: status: { DRDY }
Dec 22 12:49:26 : ata2: soft resetting link
Dec 22 12:49:26 : ata2.00: configured for UDMA/33
Dec 22 12:49:26 : ata2: EH complete
. . . .
Dec 22 13:01:04 : ata2: XXX DRQ set after 100 tries
Dec 22 13:01:04 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 13:01:04 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 13:01:04 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 13:01:04 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 13:01:04 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 13:01:04 : ata2.00: status: { DRDY }
Dec 22 13:01:04 : ata2: soft resetting link
Dec 22 13:01:04 : ata2.00: configured for UDMA/33
Dec 22 13:01:04 : ata2: EH complete
. . . .
Dec 22 13:02:18 : ata2: XXX DRQ set after 100 tries
Dec 22 13:02:18 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 13:02:18 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 13:02:18 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 13:02:18 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 13:02:18 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 13:02:18 : ata2.00: status: { DRDY }
Dec 22 13:02:18 : ata2: soft resetting link
Dec 22 13:02:18 : ata2.00: configured for UDMA/33
Dec 22 13:02:18 : ata2: EH complete
. . . .
Dec 22 13:03:30 : ata2: XXX DRQ set after 100 tries
Dec 22 13:03:30 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 13:03:30 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 13:03:30 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 13:03:30 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 13:03:30 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 13:03:30 : ata2.00: status: { DRDY }
Dec 22 13:03:30 : ata2: soft resetting link
Dec 22 13:03:30 : ata2.00: configured for UDMA/33
Dec 22 13:03:30 : ata2: EH complete
. . . .
Dec 22 13:04:26 : ata2: XXX DRQ set after 100 tries
Dec 22 13:04:26 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 13:04:26 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 13:04:26 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 13:04:26 :          cdb 1e 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 13:04:26 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 13:04:26 : ata2.00: status: { DRDY }
Dec 22 13:04:26 : ata2: soft resetting link
Dec 22 13:04:26 : ata2.00: configured for UDMA/33
Dec 22 13:04:26 : ata2: EH complete
. . . .
Dec 22 13:11:58 : ata2: XXX DRQ set after 100 tries
Dec 22 13:11:58 : ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
0x6 frozen
Dec 22 13:11:58 : ata2.00: ST_FIRST: !(DRQ|ERR|DF)
Dec 22 13:11:58 : ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Dec 22 13:11:58 :          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 
00 00 00
Dec 22 13:11:58 :          res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 
0x2 (HSM violation)
Dec 22 13:11:58 : ata2.00: status: { DRDY }
Dec 22 13:11:58 : ata2: soft resetting link
Dec 22 13:11:58 : ata2.00: configured for UDMA/33
Dec 22 13:11:58 : ata2: EH complete

