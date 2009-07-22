From: KueiHuan Chen <kueihuan.chen@gmail.com>
Subject: Re: Marvell 7042 has some problem on Marvell 6281(kirkwood) platform
	(Resent)
Date: Wed, 22 Jul 2009 15:04:32 +0800
Message-ID: <788014650907220004l7367c2cfwc42f88282bfa02f6@mail.gmail.com>
References: <788014650907211910j443d4d31y88001319acf8c1d4@mail.gmail.com>
	 <4A667F40.8060309@pobox.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:8510 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbZGVHEd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jul 2009 03:04:33 -0400
Received: by an-out-0708.google.com with SMTP id d40so5481170and.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 00:04:33 -0700 (PDT)
In-Reply-To: <4A667F40.8060309@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, saeed@marvell.com, linux-ide@vger.kernel.org

Dear Mark & Saeed,

2009/7/22 Mark Lord <mlord@pobox.com>:
>
> Are you using a discrete 7042 chip on a PCIe bus
> along with a 6281 chip ??
> Or are you simply using the built-in SATA controller inside the 6281 ?
>

   We use a standalone 7042 chip on a PCIe bus with 6281 platform. And
we choose four channels from 7042 to build a software raid 5. We had
experimented that even though we disable the sata channels of 6281
soc, the problem is still remain.

> In either event, Marvell did not deem to share *any* technical info
> about the 6281 with me, so I really cannot help you.
>
> Saeed Bishara from Marvell did everything to do with that chip.
>
>
> ..
>
> I think the messages that happened before those above are the important
> ones,
> and you did not show those messages here.

  There is no any messages before the "unable to disable eDMA".  It
just freeze for a while and then output these messages. I had tried to
use the sata driver from Marvell BSP driver 4.2.2. The problem is the
same. The BSP are also cannot disable eDMA.  Then we unmount this chip
from that board and remount it into the other platform(powerpc). It
works fine without any problem ... So we suspicion the problem may due
to 7042 work on 6281 platform.

  If you have any ideas , please kindly tell us. We would try it !

Thanks!
