From: Tejun Heo <htejun@gmail.com>
Subject: Re: Questions about SATA hotplug in linux 2.6
Date: Thu, 20 Dec 2007 15:19:28 +0900
Message-ID: <476A0970.9090804@gmail.com>
References: <20071025.011445.80152909.davem@davemloft.net> <472052C1.2050302@garzik.org> <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com> <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com> <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com> <47679074.9000400@gmail.com> <B90463BC30D2E446BA423D888DC85E50087A77@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:49641 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbXLTGTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2007 01:19:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5031860wah.23
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 22:19:40 -0800 (PST)
In-Reply-To: <B90463BC30D2E446BA423D888DC85E50087A77@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <Shane.Huang@amd.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Shane Huang wrote:
>>> Do you guys think it's normal? It not, how to make SATA hotplug work
> on
>>> different SATA port? Should it be supported by BIOS or hardware?
>> If you connect it to a different port, the original device will die
> and
>> new device will appear.  That's the expected behavior.  In the log, I
>> only see ata3.00 is dying.  Isn't there any log from different port?
> 
> There is no other log from the different port such as the enablement of
> ata2,
> it's strange. I forgot to say that this case appear when the "OnChip
> SATA Type"
> is "Native IDE"(SATA device ID is 4390) in BIOS.
> 
> But when I set "OnChip SATA type" into "AHCI" mode(SATA device ID 4391),
> the hotplug can work, and the device name will be changed from "scd0" to
> "scd1"
> during the hotplug. The log messages are attached at the end of this
> mail.

That's strange.  I guess we're forgetting something when forcing the
controller into AHCI mode.  What happens if you manually issue re-scan
by doing "echo - - - > /sys/class/scsi_host/hostN/scan" where hostN is
the SCSI host for the ATA port you moved the drive?

Also, after driver is loaded, can you please post the results of "lspci
-nnvvvxxx" with BIOS mode set to IDE and AHCI?

Thanks.

-- 
tejun
