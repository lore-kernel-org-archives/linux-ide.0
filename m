From: walt <w41ter@gmail.com>
Subject: Re: [PATCH] block: fix residual byte count handling
Date: Tue, 04 Mar 2008 11:18:11 -0800
Message-ID: <fqk77b$cdn$1@ger.gmane.org>
References: <20080304175302T.fujita.tomonori@lab.ntt.co.jp> <20080304085944.GG6704@kernel.dk> <20080304180648W.fujita.tomonori@lab.ntt.co.jp> <20080304182228Z.fujita.tomonori@lab.ntt.co.jp> <20080304093536.GH6704@kernel.dk> <1204634238.5997.5.camel@homer.simson.net> <20080304123939.GM6704@kernel.dk> <fqk15l$lgq$1@ger.gmane.org> <47CD8E02.1020207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:58821 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763444AbYCDTRO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Mar 2008 14:17:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWcdQ-0006wl-W5
	for linux-ide@vger.kernel.org; Tue, 04 Mar 2008 19:17:09 +0000
Received: from adsl-69-234-180-221.dsl.irvnca.pacbell.net ([69.234.180.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 19:17:08 +0000
Received: from w41ter by adsl-69-234-180-221.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 19:17:08 +0000
In-Reply-To: <47CD8E02.1020207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> walt wrote:
>> Jens Axboe wrote:
>>> On Tue, Mar 04 2008, Mike Galbraith wrote:
>>>> On Tue, 2008-03-04 at 10:35 +0100, Jens Axboe wrote:
>>>>
>>>>> Looks excellent to me, has a variant of this been tested as OK by the
>>>>> users reporting the regression?
>>>> K3b burning seems to be a nogo here.  This is git pulled this morning
>>>> though, so it's a somewhat different tree than previously tested fwtw.
>>> can you please try git as of this morning without any patches applied,
>>> and then pull
>>>
>>> git://git.kernel.dk/linux-2.6-block.git for-linus
>>>
>>> into that and see if that works?
>> Unfortunately this doesn't fix a problem I've discussed off-list with
>> Kiyoshi Ueda, who suggested that I should follow this thread and try
>> any patches posted here.
>>
>> Here is what happens when I try to mount a CD (before and after I
>> pull 'for-linus'):
>>
>> hdc: ide_cd_check_ireason: wrong transfer direction!
>> cdrom: failed setting lba address space
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>> ide: failed opcode was: unknown
>> hdc: drive not ready for command
>> hdc: status timeout: status=0xd0 { Busy }
>> ide: failed opcode was: unknown
>> hdc: DMA disabled
>> hdc: drive not ready for command
>> hdc: ATAPI reset complete
>> ISO 9660 Extensions: Microsoft Joliet Level 3
>> ISOFS: changing to secondary root
>> VFS: busy inodes on changed media.
>>
>> The mount can take from 5 seconds on up to a minute or so before the
>> CD can be accessed.
>
> Which version did you try?  There was a recent IDE bug fix which
> affected CD recording.  Commit bcd88ac3b2ff2eae3d0fa57a6b02d4fce5392f32
> which is included in 2.6.25-rc3.

I pulled from Jens to Linus' latest git, as Jens instructed.  I noticed
no difference at all.

> Also, did 2.6.24 work?

Yes, vanilla 2.6.24 works fine.  Your patchlet of earlier today also
didn't fix it, so I'm beginning to think that maybe I'm in the wrong
thread :o)



