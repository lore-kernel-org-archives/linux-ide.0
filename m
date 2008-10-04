From: bbee <bumble.bee@xs4all.nl>
Subject: pata_ninja32 plea
Date: Sat, 4 Oct 2008 19:17:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810041846250.13914@dolores.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:3466 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYJDRRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 13:17:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@redhat.com

Hi,

I was looking for a way to add SSD to my laptop, while keeping the capacity 
of the hard disk (250G) available. I spotted a CF->Cardbus card in a shop 
and found that it was supported by pata_ninja32 and delkin_cb. The card is 
branded Delock, it identifies as: "Workbit Corporation Device [1145:f021]".

What I didn't realize then was that the drivers only offer PIO support. 
With a Transcend 16G 133x CF card, I can get the card to write at ~3Mb/s 
and read at ~6-7Mb/s sequential with the old IDE driver, which would be 
fine were it not for the fact that it makes the system lag like mad, using 
100% CPU.
In Windows it gets ~10Mb/s perfomance with <25% CPU load.

With the perf it has in Windows, it would make an excellent root drive and 
a great upgrade path to SSD for slightly older laptops like mine.

The windows driver is 27Kb, the OSX one is ~100Kb. Somewhere in those 27K 
is something that will make it perform great on linux, all it would take is 
someone with a lot more clue than me to take a look at it.

Anyone willing to take a look? Alan?

Thanks,

bbee


Windows benchmark:

    Sequential Read :   10.806 MB/s
   Sequential Write :    8.047 MB/s
  Random Read 512KB :   10.728 MB/s
Random Write 512KB :    1.537 MB/s
    Random Read 4KB :    7.408 MB/s
   Random Write 4KB :    0.013 MB/s

          Test Size : 100 MB

