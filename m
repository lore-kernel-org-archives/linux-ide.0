From: Alfonso Gazo <agazo@users.berlios.de>
Subject: Issuing IDE standby command to shutdown disk before poweroff or reboot
Date: Mon, 08 Nov 2004 17:57:44 +0100
Message-ID: <418FA588.5050205@users.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [147.83.33.10] ([147.83.33.10]:41096 "EHLO roura.ac.upc.es")
	by vger.kernel.org with ESMTP id S261858AbUKHQ6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Nov 2004 11:58:06 -0500
Received: from [147.83.34.212] (dync-34-212.ac.upc.es [147.83.34.212])
	by roura.ac.upc.es (8.12.8/8.12.8) with ESMTP id iA8Gvpjj000588
	for <linux-ide@vger.kernel.org>; Mon, 8 Nov 2004 17:57:51 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,

 From some time ago, I've noticed that when rebooting or powering off my 
laptop, its HDD emits an audible sound like a "clonk". It's the same 
sound when powering off incorrectly (i.e., after a hang or something 
like that). I'm using 2.6.8.1 on athlon xp.

My worries come when I read the specs of the hdd vendor (it's an Hitachi 
80GN family drive):

"The product supports a minimum of 300,000 normal load/unloads. The 
drive supports a minimum of 20,000 emergency unloads."

The spec states that the emergency unload is caused when the power is 
cut off for the HDD without previously issuing any of the following IDE 
commands: (hard reset, standby, standby immediate, sleep), and it causes 
mechanical stress to heads. I'm not sure if the Linux kernel currently 
is ussing any of this commands, but I guess no, as I said before.

I think that this issue is solved when halting, as it is possible to use 
the -h parameter in "halt" command, but this is not possible when 
rebooting or suspending (with Software Suspend 2 patch). I'm not sure if 
the drive is doing emergency unloads when shutting down properly the 
kernel, and even knowing that 20.000 unloads is a good number of 
unloads, maybe it could be better for the drive to unload the proper way.

Any idea, confirmation, etc. about this?

Regards,

  --
  Alfonso
