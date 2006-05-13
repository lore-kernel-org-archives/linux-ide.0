From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Sat, 13 May 2006 10:36:07 +0900
Message-ID: <44653807.3030101@gmail.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:26228 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751312AbWEMBgX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 21:36:23 -0400
Received: by wx-out-0102.google.com with SMTP id i29so255896wxd
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 18:36:22 -0700 (PDT)
In-Reply-To: <446536C5.80503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> tested.  I implemented AHCI PM support half-way but then realized I 
>> don't have any AHCI controller which supports PM (I have ICH7R).  Is 
>> there any AHCI controller which reports PM support?
> 
> You can always use SCR-based PM support...
> 

Can you elaborate a bit?

@ welcome back.

-- 
tejun
