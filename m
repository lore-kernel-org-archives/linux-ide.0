From: Tejun Heo <htejun@gmail.com>
Subject: Re: DMADIR+AHCI slows boot a lot
Date: Mon, 12 Jun 2006 13:07:43 +0900
Message-ID: <448CE88F.8040004@gmail.com>
References: <448CD8FC.5070508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:60437 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWFLEHu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 00:07:50 -0400
Received: by py-out-1112.google.com with SMTP id x31so1562583pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 21:07:49 -0700 (PDT)
In-Reply-To: <448CD8FC.5070508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> It looks like we will need to implement an "impatient probe".
> 
> I have an SiI PATA<->SATA bridge that requires DMADIR to enable ATAPI. 
> When ATAPI_ENABLE_DMADIR is -not- enabled, it makes a good test case for 
> the EH :)
> 
> See the attached dmesg output, which illustrates that the boot is slowed 
> by several minutes.  It would be ideal if we could execute EH in the 
> background during probe, and simply stop waiting if it takes too long. 
> bootplug should handle any devices that appear after the bus probe gets 
> "too impatient", and stops waiting.

I've encountered similar problems w/ my broken harddisks.  I am thinking 
of the followings.

* implement parallel probing as SCSI does.

* Make EH parametrized by timeouts.  We currently use single worst-case 
timeout for all tries.  I think we need to use shorter timeouts for 
early tries.  This is also true for normal (non-probing) EHs.  When 
device or controller goes dumb, the current EH is way too generous about 
timeouts.

* A related problem is spinup waiting after hotplug for controllers 
which misses the first D2H FIS.  libata currently waits 8 secs 
unconditionally.  If the drive is ready after that, everything is good. 
  If not, it ends up timing out after 30secs and then retries.  I think 
this can be done much better by trying at 5, 10, 15 and 30 secs from 
hotplug event.

Even if we decide to implement the aboves, I guess both are 2.6.19 
materials.

-- 
tejun
