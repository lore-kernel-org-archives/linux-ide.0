From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/12] libata-pmp: implement ATA_LFLAG_DISABLED
Date: Mon, 24 Jul 2006 15:52:42 +0900
Message-ID: <44C46E3A.8070109@gmail.com>
References: <11523382872631-git-send-email-htejun@gmail.com> <44BE97B0.9030809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:43546 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751213AbWGXJ4k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:40 -0400
Received: by py-out-1112.google.com with SMTP id t32so2506056pyc
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2006 02:56:07 -0700 (PDT)
In-Reply-To: <44BE97B0.9030809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement ATA_LFLAG_DISABLED.  The flag indicates the link is 
>> disabled due to EH recovery failure.  While a link is disabled, no 
>> EH action is taken on the link and suspend/resume become noop too. 
>> For host port, this doesn't introduce any behavior change other 
>> than not invoking hotplug sequence on failed ports on resume and 
>> this behavior change is intended.
> 
> why?
> 
> libata should notice new devices, when resuming.

It will do so on links which are operating normally.  ATA_LFLAG_DISABLED 
is set only when libata EH fails to recover the link (link hardreset 
failure) which takes quite some retries and is more severe than device 
recovery failure.  This is the red marking screaming "stay away from 
this link!".  For example, let's say a notebook has a broken SATA link 
to drive bay and EH failed it.  Without the above behavior, libata EH 
will try to recover the link on every resume which is both inconvenient 
and incorrect.

The thing is that resume from sleep is a link-resuming operation but not
a hotplug event, just as PMP slave link resets following host link reset
are link-resuming but not hotplugging.  IOW, resume doesn't positively
indicate that the attached device could have been changed.

libata EH doesn't need hotplug events to do hotplugging.  If it detects 
such events during EH, it will perform the needed operations, but there 
are things which are appropriate only when hotplug event is positively 
indicated like detaching disabled (failed) devices or re-enabling failed 
links.

-- 
tejun


