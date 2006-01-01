From: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Subject: Re: Kernel panic with 2.6.15-rc7 + libata1 patch
Date: Sun, 01 Jan 2006 17:43:51 +0100
Message-ID: <43B806C7.5000607@bj-ig.de>
References: <43B724BA.90405@bj-ig.de> <43B7EA0A.7040805@bj-ig.de>
	<20060101145702.GV3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tower.bj-ig.de ([194.127.182.2]:64657 "EHLO fs.bj-ig.de")
	by vger.kernel.org with ESMTP id S1750724AbWAAQnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jan 2006 11:43:49 -0500
In-Reply-To: <20060101145702.GV3811@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Adrian Bunk schrieb:

> Is this problem present with older kernel (e.g. 2.6.14.x) or is it a 
> newly introduced bug?

It is a newly installed system - 2.6.15-rc6 has been the first kernel at 
all on this machine - this kernel crashed too. After that I upgraded to 
2.6.15-rc7 - it crashed as written in the initial mail. Next was to 
apply the libata1 patch. It did not give a kernel panic but shut down 
the SATA subsystem (the hardware is a Promise SATA II 300 TX4 PDC 20718 
and an onboard Promise SATA II 150 PDC20579) - non of the six attached 
disks has been accessible anymore after calling hddtemp on one of the 
disks which have been in standby. Calling hddtemp on a spinning disk 
works without a problem.

A further problem is that calling "hdparm -C" _always_ give "drive state 
is:  standby" - even when the disks are clearly active. Maybe this 
indicates something to you.

I can try to downgrade to 2.6.14 if you like. I started with 2.6.15 
because I have been told it is the first kernel which is able to deal 
with "hdparm -S x" / "hdparm -y" for SATA devices.

> I've put Jeff into the Cc of this email since he is the SATA maintainer.

Thanks.

Regards
Ralf

