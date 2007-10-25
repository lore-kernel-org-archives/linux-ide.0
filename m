From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/12] ide: add struct ide_taskfile
Date: Thu, 25 Oct 2007 20:37:33 +0400
Message-ID: <4720C64D.3000902@ru.mvista.com>
References: <200710082311.10925.bzolnier@gmail.com> <47164894.9080007@ru.mvista.com> <200710250016.29315.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:46439 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755786AbXJYQhZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 12:37:25 -0400
In-Reply-To: <200710250016.29315.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:

>>>Index: b/drivers/ide/ide-disk.c
>>>===================================================================
>>>--- a/drivers/ide/ide-disk.c
>>>+++ b/drivers/ide/ide-disk.c

>>[...]

>>>+	if ((tf->command & 0x01) == 0) {
>>>+		u32 high, low;

>>    Isn't newline needed after declarations?

> Well, it is not stricly needed, this code should compile and work without it.

> ;)

> fixed (FWIW the original code also lacked newline)

    Yeah, I saw but that's hardly worth imitating. :-)

[...]

> New revision of the patch (it also uses the suggestion about using unnamed
> unions for error/feature and status/command, thanks!):

> [PATCH] ide: add struct ide_taskfile (take 2)

> * Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hobRegister[7]
>   in idedisk_set_max_address_ext().

> * Add struct ide_taskfile and use it in ide_task_t instead of tfRegister[]
>   and hobRegister[].

> * Remove no longer needed IDE_CONTROL_OFFSET_HOB define.

> * Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_struct_t.

> While at it:

> * Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.

> v2:
> * Add missing newlines. (Noticed by Sergei)

> * Use ~ATA_LBA instead of 0xBF. (Noticed by Sergei)

> * Use unnamed unions for error/feature and status/command.
>   (Suggested by Sergei).

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
>  drivers/ide/ide-disk.c     |  156 ++++++++++++++++++++++++---------------------
>  drivers/ide/ide-io.c       |   80 +++++++++++++----------
>  drivers/ide/ide-iops.c     |   12 +--
>  drivers/ide/ide-lib.c      |    3
>  drivers/ide/ide-acpi.c     |    8 ---
>  drivers/ide/ide-disk.c     |  120 +++++++++++++++++++++------------------------
>  drivers/ide/ide-io.c       |   61 ++++++++++++----------
>  drivers/ide/ide-iops.c     |   12 ++--
>  drivers/ide/ide-lib.c      |    3 -

    Don't know how but ide-disk.c, ide-io[ps].c and ide-lib.c appear twice in 
the diffstat output... 8-)

MBR, Sergei
