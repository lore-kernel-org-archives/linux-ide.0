From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: PMPs
Date: Wed, 8 Apr 2009 20:10:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.0904081958100.29570@uplift.swm.pp.se>
References: <alpine.DEB.1.10.0904012109180.28814@uplift.swm.pp.se> <49D4073C.4010101@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:32991 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015AbZDHSKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 14:10:47 -0400
In-Reply-To: <49D4073C.4010101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Thu, 2 Apr 2009, Tejun Heo wrote:

> You need to keep the first port occupied for 3726/4726; otherwise, the 
> fake config disk jumps around and it just goes belly up.  Do you 
> experience problems even with the first port occupied?

Yes, I just did some tests again (this time with 2.6.28-11-generic 
#41-Ubuntu SMP Wed Apr 8 04:38:53 UTC 2009 i686 GNU/Linux)

If I cold-boot the machine with drives in bay 0 (samsung) and 1 (WD), 
everything is fine. I then unplug the drive in 1, and put it in 2. This 
drive isn't recognised at all (I can't see anything happening in dmesg). 
Re-seating the drive in 0 makes both drives pop back in again.

[   16.558305] ata12.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
[   16.569850] ata12.01: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max UDMA/133
[   16.571285] scsi 11:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
[   16.576818] scsi 11:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5

If I now unplug both, and first put in 0 (WD) and then 2(samsung), samsung 
isn't recognised, doesn't matter if I move samsung from 2 to 1. In this 
configuration, 0(WD), 1(samsung), re-seating 0 doesn't make the samsung 
become visible again:

[ 1083.656011] ata12.01: failed to IDENTIFY (I/O error, err_mask=0x11)
[ 1083.656014] ata12.01: failed to recover link after 3 tries, disabling

Removing both and going back to 0 (samsung) and 1 (WD) make both drives 
visible again.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
