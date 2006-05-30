From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 10/12] libata-hp-prep: implement sata_phy_debounce()
Date: Tue, 30 May 2006 01:23:13 -0400
Message-ID: <447BD6C1.6090201@pobox.com>
References: <11488839583691-git-send-email-htejun@gmail.com> <447BC5B9.2070509@pobox.com> <447BD35A.4080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:63974 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932122AbWE3FXg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 01:23:36 -0400
In-Reply-To: <447BD35A.4080605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> With hotplug, PHY always needs to be debounced before a reset as any
>>> reset might find new devices.  Extract PHY waiting code from
>>> sata_phy_resume() and extend it to include SStatus debouncing.  Note
>>> that sata_phy_debounce() is superset of what used to be done inside
>>> sata_phy_resume().
>>>
>>> Three default debounce timing parameters are defined to be used by
>>> hot/boot plug.  As resume failure during probing will be properly
>>> handled as errors, timeout doesn't have to be long as before.
>>> probeinit() uses the same timeout to retain the original behavior.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> NAK, changes behavior.  We want to preserve the old order of 
>> operations because some PHYs (sata_via and sata_mv come to mind) are a 
>> bit sensitive to being pounded immediately after wakeup.
> 
> The following is what the original sata_phy_resume() did
> 
> 1. read SControl
> 2. write SControl (wake)
> 3. msleep(200)
> 4. read SStatus
> 5. if condition not met, goto #3
> 
> The new code does...
> 
> 1. read SControl
> 2. write SControl (wake)
> 3. read SStatus
> 4. msleep(interval_msec)
> 5. read SStatus
> 6. if condition not met, goto #4
> 
> How about putting msleep(200) before calling sata_phy_debounce() from 
> sata_phy_resume().  This will add msleep(200) between #2 and #3 and the 
> only difference left would be the duration of interval_msec in #4 which 
> is 5ms during boot, 25ms during EH.  The wait is in the millisecs range 
> and it's difficult to imagine the change would cause any problem.

As long as the delay following #2 remains, I'm happy...

	Jeff



