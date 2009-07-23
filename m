From: KueiHuan Chen <kueihuan.chen@gmail.com>
Subject: Re: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
	(Resent)
Date: Thu, 23 Jul 2009 10:24:06 +0800
Message-ID: <788014650907221924i68621102r938fc35b813e7cd3@mail.gmail.com>
References: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
	 <4A667F40.8060309@pobox.com>
	 <788014650907220004l7367c2cfwc42f88282bfa02f6@mail.gmail.com>
	 <c70ff3ad0907220127o3891b886k88e8bf43e22f9e38@mail.gmail.com>
	 <788014650907220456n149ea406s8dc1d1acf78c2650@mail.gmail.com>
	 <c70ff3ad0907220509j4c5be2a4r1d384c570b37a318@mail.gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f197.google.com ([209.85.210.197]:37807 "EHLO
	mail-yx0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbZGWCYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 22:24:08 -0400
Received: by yxe35 with SMTP id 35so1094979yxe.33
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 19:24:06 -0700 (PDT)
In-Reply-To: <c70ff3ad0907220509j4c5be2a4r1d384c570b37a318@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, saeed@marvell.com, linux-ide@vger.kernel.org

Hi Saeed,

  The result is  same as what you guess, all register is ending with
FFFF. If there has any tip to work through this, please kindly let us
know.

Thanks.
---------------
#cat /proc/iomem
00000000-07ffffff : System RAM
  00025000-0035ffff : Kernel text
  00360000-003c4a0b : Kernel data
e8000000-efffffff : PEX Memory
  e8000000-e80fffff : 0000:00:01.0
    e8000000-e80fffff : mvSata
f1012000-f10120ff : serial8250.0
  f1012000-f101201f : serial
f1012100-f101211f : serial
f10a0000-f10a3fff : mv88fx_snd
f8000000-f83fffff : physmap-flash.0
  f8000000-f83fffff : physmap-flash.0


Strating to build software raid5 and execute devmem2.
Value at address 0xE8022000 (0x40000000): 0xC2213E
Value at address 0xE8024000 (0x40000000): 0xC2213E
Value at address 0xE8026000 (0x40000000): 0xC2213E
Value at address 0xE8028000 (0x40000000): 0xC2213E
------------------------
Value at address 0xE8022030 (0x40000030): 0xFE
Value at address 0xE8024030 (0x40000030): 0xE8
Value at address 0xE8026030 (0x40000030): 0xE2
Value at address 0xE8028030 (0x40000030): 0xC4
=======repeate
Value at address 0xE8022000 (0x40000000): 0xC2213E
Value at address 0xE8024000 (0x40000000): 0xC2213E
Value at address 0xE8026000 (0x40000000): 0xC2213E
Value at address 0xE8028000 (0x40000000): 0xC2213E
------------------------
Value at address 0xE8022030 (0x40000030): 0xF9
Value at address 0xE8024030 (0x40000030): 0xED
Value at address 0xE8026030 (0x40000030): 0xF7
Value at address 0xE8028030 (0x40000030): 0xD8
=======repeate
Value at address 0xE8022000 (0x40000000): 0xC2213E
Value at address 0xE8024000 (0x40000000): 0xC2213E
Value at address 0xE8026000 (0x40000000): 0xC2213E
Value at address 0xE8028000 (0x40000000): 0xC2213E
------------------------
Value at address 0xE8022030 (0x40000030): 0xE1
Value at address 0xE8024030 (0x40000030): 0xC17B
Value at address 0xE8026030 (0x40000030): 0xE5
Value at address 0xE8028030 (0x40000030): 0xCC
=======repeate
Value at address 0xE8022000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8024000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8026000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8028000 (0x40000000): 0xFFFFFFFF
------------------------
Value at address 0xE8022030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8024030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8026030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8028030 (0x40000030): 0xFFFFFFFF
=======repeate
Value at address 0xE8022000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8024000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8026000 (0x40000000): 0xFFFFFFFF
Value at address 0xE8028000 (0x40000000): 0xFFFFFFFF
------------------------
Value at address 0xE8022030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8024030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8026030 (0x40000030): 0xFFFFFFFF
Value at address 0xE8028030 (0x40000030): 0xFFFFFFFF
...

first time call trace
WARNING: at drivers/ata/mvSata_4_2_2/CoreDriver/mvSata.c:4811 deactivateEdma()
[<c002a99c>] (dump_stack+0x0/0x14) from [<c01f8dcc>] (deactivateEdma+0x7c/0xec)
[<c01f8d50>] (deactivateEdma+0x0/0xec) from [<c01f8e6c>]
(mvSataDisableChannelDma+0x30/0x40)
[<c01f8e3c>] (mvSataDisableChannelDma+0x0/0x40) from [<c01ec54c>]
(mv_ial_ht_abort+0x48/0xe0)
[<c01ec504>] (mv_ial_ht_abort+0x0/0xe0) from [<c01bd394>]
(__scsi_try_to_abort_cmd+0x2c/0x34)
 r7:c775c000 r6:c77cb800 r5:c7fe8200 r4:c77c93c0
[<c01bd368>] (__scsi_try_to_abort_cmd+0x0/0x34) from [<c01be938>]
(scsi_error_handler+0x128/0x2f4)
[<c01be810>] (scsi_error_handler+0x0/0x2f4) from [<c0069fc4>]
(kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c01be810 r4:c77cb800
[<c0069f70>] (kthread+0x0/0x80) from [<c0059894>] (do_exit+0x0/0x6f8)
 r5:00000000 r4:00000000

second time call trace
WARNING: at drivers/ata/mvSata_4_2_2/CoreDriver/mvSata.c:4811 deactivateEdma()
[<c002a99c>] (dump_stack+0x0/0x14) from [<c01f8dcc>] (deactivateEdma+0x7c/0xec)
[<c01f8d50>] (deactivateEdma+0x0/0xec) from [<c01f8e6c>]
(mvSataDisableChannelDma+0x30/0x40)
[<c01f8e3c>] (mvSataDisableChannelDma+0x0/0x40) from [<c01ef8a4>]
(mvRestartChannel+0xa4/0x108)
[<c01ef800>] (mvRestartChannel+0x0/0x108) from [<c01ec584>]
(mv_ial_ht_abort+0x80/0xe0)
[<c01ec504>] (mv_ial_ht_abort+0x0/0xe0) from [<c01bd394>]
(__scsi_try_to_abort_cmd+0x2c/0x34)
 r7:c775c000 r6:c77cb800 r5:c7fe8200 r4:c77c93c0
[<c01bd368>] (__scsi_try_to_abort_cmd+0x0/0x34) from [<c01be938>]
(scsi_error_handler+0x128/0x2f4)
[<c01be810>] (scsi_error_handler+0x0/0x2f4) from [<c0069fc4>]
(kthread+0x54/0x80)
 r7:00000000 r6:00000000 r5:c01be810 r4:c77cb800
[<c0069f70>] (kthread+0x0/0x80) from [<c0059894>] (do_exit+0x0/0x6f8)
 r5:00000000 r4:00000000
 0 3: deactivateEdma: Edma Failed (EDMA status = ffffffff)

... loop ..
Best Regards,
KueiHuan-Chen
