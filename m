From: Tejun Heo <htejun@gmail.com>
Subject: Re: JMicron - hard resetting link
Date: Tue, 12 Feb 2008 22:05:27 +0900
Message-ID: <47B19997.1010404@gmail.com>
References: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:36119 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbYBLNFh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 08:05:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so5136966wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 05:05:36 -0800 (PST)
In-Reply-To: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor FUNK <FUNK.Gabor@hunetkft.hu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Gabor FUNK wrote:
> Hi list,
> 
> I seem to have a bug with JMicron controller in a Gigabyte
> GA-N680SLI-DQ6 motherboard.
> http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=2460
> 
> Kernel is 2.6.24.
> 10 on-board SATA connectors, 2+4*JMicron 20360/20363 + 4*nVidia MCP55
> 2*200GB disks (System - SW RAID1) on the JMicron controller and
> 8*500 (Data - SW RAID6) - 4 on the JMicron, 4 on the nVidia controller.
> 
> Under heavy load the JMicron controller gets exceptions, then eventually
> "hard resetting link".
> All 4 disks/connector, one after another. This of course "kills" the RAID

It shouldn't kill the RAID.  Hmmm... The log is truncated.  Can you
please post full kernel log spanning from boot to array death?

> I'm lost.
> Anyone seen such thing? What could it be? Hardware (MB, chipset, BIOS),
> kernel (driver) or what?
> Any suggestion? Kernel version to try, dispose hardware or shoot myself
> in the head?

One of common causes for this kind of problem is bad power and PSUs
which are rated for high wattage aren't always good enough.  Prepare a
power supply (popular cheap $15 one should do) such that it can be
powered up by itself.

  http://modtown.co.uk/mt/article2.php?id=psumod

Move half of the drives to the new PSU and see whether the problem goes
away.

Thanks.

-- 
tejun
