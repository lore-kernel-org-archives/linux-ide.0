From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED (resolved)
Date: Mon, 2 Aug 2010 09:21:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1008020720250.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se> <4C531A40.6080804@gmail.com>
 <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
 <AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:36621 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab0HBHVv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Aug 2010 03:21:51 -0400
In-Reply-To: <AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 1 Aug 2010, Robert Hancock wrote:

> The output above shows that the drive has security enabled and locked, 
> so it seems that must be the case, and it won't be accessible unless 
> it's unlocked. hdparm should be able to disable it, though it seems you 
> may need a valid password to do it..

There is something I did not mention in any of my earlier posts, and that 
is the fact that the server also has had a 3ware controller installed 
(removed as part of fault isolation) and some of the disks has been 
attached to that controller. In the case of the samsung 1tb disk, it was 
attached to the 3ware conroller after it was successfully tested on the 
motherboard sata-controller.

Some googling and testing found that yes, the 3ware controller does indeed 
lock the drives, even if they are just automatically exported as "JBOD".

The following command successfully unlocked my devices:

hdparm --user-master u --security-disable "3wareUserPassword               " /dev/sdb

I have unlocked and tested a total of 4 disks now, both the samsung 1TB 
and 3 of the WDC 2TB disks. Thank you very much! Left to do: test that 
everything is working with the PMP aswell.

Question: Would it be unreasonable to request that the kernel would issue 
the apropriate ATA-commands to a disk as soon as it is detected, and not 
try to read from it if it is locked? It would have been really, really 
nice to just get the error message "drive is locked".

//tlund
