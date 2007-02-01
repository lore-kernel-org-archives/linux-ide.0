From: Florian Effenberger <florian@effenberger.org>
Subject: Serious bug in sata_sil module in 2.6.19.2?
Date: Thu, 01 Feb 2007 11:24:32 +0100
Message-ID: <45C1BFE0.4080004@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:34107 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422777AbXBAKmU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 05:42:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi there,

I am not sure if the sata_sil-Module is the culprit, but I think so. We 
ran a 2.6.15.1 kernel for months without any problems. Now I tried to 
switch to 2.6.19.2, and every night when our backup routine runs, the 
machine locks up. No log entry, no automatic reboot 
(/proc/sys/kernel/panic is set to 30 [sec]).

The display looks like if there was a video error, lots of bad and 
flickering characters, but it is pretty hard to read the error message. 
I have an image and a video of that, if you need it. The only thing I 
could read is something with "ata". After the reboot, the RAID devices 
are out of sync and need to resync again.

Booting up 2.6.15.1 on the same machine cures the problem, everything 
works just fine, no lockups.

Is there any chance of debugging that problem, of finding the culprit?

Any help would be greatly appreciated!

Thanks
Florian
