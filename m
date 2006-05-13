From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET 03/11] new EH implementation, take 3
Date: Sun, 14 May 2006 08:58:04 +0900
Message-ID: <4466728C.7040405@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com> <44665EFD.5080306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:45900 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964814AbWEMX6U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:58:20 -0400
Received: by wr-out-0506.google.com with SMTP id i22so783634wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:58:19 -0700 (PDT)
In-Reply-To: <44665EFD.5080306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This is part of patchset series described in [T].
>>
>> This is the third take of new-EH-implementation patchset.  Changes
>> from the last take[L] are
> [...]
>> [T] http://article.gmane.org/gmane.linux.ide/9957
>> [L] http://article.gmane.org/gmane.linux.ide/9540
>> [1] http://article.gmane.org/gmane.linux.ide/9959
>> [2] http://article.gmane.org/gmane.linux.ide/9984
> 
> Aside from one minor requested change, this patchset is ACK'd, but with 
> a few comments and worries noted.
> 
> Once this goes in we need to move all the drivers over as soon as 
> possible, and get them all re-tested.
> 

I will be a lot of work.  As new EH uses features unused before, it 
sometimes exposes new hardware problems (things like sata_sil24 port 
wide IRQ plugging doesn't really work).  Those problems take time to 
diagnose and work around.  Also, different strains of a controller might 
show different symptoms.  So, we need a lot of testing.

I agree that drivers should be converted ASAP but honestly don't know 
how fast those can be done; however, libata will continue to work with 
all the old-EH drivers as well as before, so we have some headroom.

-- 
tejun
