From: James Stevens <james@jrcs.net>
Subject: Intel RAID in the X79 chipset
Date: Mon, 16 Jun 2014 09:26:30 +0100
Message-ID: <539EAA36.9050701@jrcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:44828 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410AbaFPIcs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2014 04:32:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

Hi

I have an ASUS P9X79 mainboard which has the Intel x79 chipset with a 
built-in RAID controller.

It is detected as 8086:2826 - "lspci" names it correctly.

Getting a Windows drier out of Intel seems a little tricky - the default 
one Intel gives you does not work, ditto the default one from Asus - 
they both have 2822 & 282A, but not 2826.

https://communities.intel.com/thread/37403?start=15&tstart=0

As of "linux-3.15", I also see it is not mentioned in the 
"drivers/ata/ahci.c" file.


When I boot Linux it never seems the RAID volume, but still tells me I 
have three separate hard drives.

I tried a few versions of Ubuntu, including the latest and a few 
versions of the Clonezilla disk duplicator.

According to that Intel thread just adding "2826" into the supported 
list works for Windows - so sounds like it would also for Linux.

I will try it when I have some spare time.


James

