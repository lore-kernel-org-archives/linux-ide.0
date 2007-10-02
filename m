From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?
Date: Tue, 2 Oct 2007 21:20:23 +0200
Message-ID: <1128907118.20071002212023@zonnet.nl>
References: <1097480701.20070927155135@zonnet.nl> <46FCF2A1.30204@gmail.com> <1619914792.20070928172536@zonnet.nl> <20070928165150.2a93524e@the-village.bc.nu> <46FD3213.6050204@gmail.com>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:1268 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbXJBTRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 15:17:51 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 42-md50000101440.msg
	for <linux-ide@vger.kernel.org>; Tue, 02 Oct 2007 21:17:46 +0200
In-Reply-To: <46FD3213.6050204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

Hello Tejun,

I build another setup with almost the same hardware.
This motherboard had already the latest bios.
I notice that the computer does almost never find the hard drive
although the controller is found every time (with lspci). So i get no
drive (sda) assigned. I don't always see the "bios" screen from the
controller at startup. And in the past it showed the hard drive.
So i could not experiment with this motherboard.

After that i installed Windows XP and used the orginal (sweex)
drivers with the first motherboard. This also makes the data corrupt.
So it seems not to be an linux problem. So there is something wrong with
the motherboard or the 3512 controller.

After that i plugged both hard drives (ide with windows and sata disk)
to the Asus board. No data corruption. So the hard disks are'nt the
problem either.

I'm thinking of replacing both 3512 controllers with a Promise SATA300
TX4. Do you know if there are problems with this device?


Friday, September 28, 2007, 6:55:47 PM, you wrote:

> Alan Cox wrote:
>>> sda1 are corrupted (2 to 4 blocks missing). Copying that data back to
>>> Windows and it give the same results in Quickpar. So reading does not
>>> have problems. The data written to hda1 is correct.
>> 
>> We've got a whole pile of reports like this with the 3512 and almost
>> always Nvidia chipset, plus reports of BIOS updates fixing it. That you
>> see something similar on intel boards is a bit worrying.

> Multiple sil3112/3512 + nvidia chipset problem doesn't usually involve
> device errors or timeouts.  It usually corrupts data silently.  And,
> yeah, data corruption on intel board is really disturbing.

> MisterE, do you have any processor powersaving mechanism enabled?  If
> so, can you disable all and see whether that changes anything?




-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


