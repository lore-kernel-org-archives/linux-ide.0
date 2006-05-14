From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 06/11] prep for hotplug support, take 2
Date: Sun, 14 May 2006 09:07:33 +0900
Message-ID: <446674C5.7010800@gmail.com>
References: <11473597542442-git-send-email-htejun@gmail.com> <4466655A.6030200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.194]:42157 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964820AbWENAHj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 20:07:39 -0400
Received: by wx-out-0102.google.com with SMTP id i29so346448wxd
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 17:07:38 -0700 (PDT)
In-Reply-To: <4466655A.6030200@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> At this point, I run out of steam.
> 
> After the minor changes are committed, I could pull <= patchset #5 into 
> #upstream immediately.

Great.  Once I get your responses and sorts out AHCI EH, I'll make new 
git branch you can pull from.  I can't wait to push those to #upstream. 
  Managing 120 stacked patches was a nightmare.  If I change something 
early in the series, even a simple/silly stuff, it causes a lot of 
rejects in later patches.

> The upcoming ata_link patchset looks quite nice; that is definitely the 
> direction I want to go.

Great.

> I've already given hotplug plenty of thought (i.e. general design 
> principles I like), so reviewing HP-related patchset should not take 
> very long.  I'll need to refresh my PM-related design thoughts a bit 
> before diving into that patchset, so that might take several days to get 
> to.

I'm still working on power applied together case because ahci is failing 
the first reset in a lot of cases.  Waiting for several secs before 
hotplug reset solved the problem for sata_sil and sata_sil24 but ahci's 
problem seems to be a different one - it doesn't seem to update TF for 
the first FIS after hotplug reset.  However, those changes are minor and 
wouldn't affect reviewing process, I think.

Thanks for reviewing and good night. :)

-- 
tejun
