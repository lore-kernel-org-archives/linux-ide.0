From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Thu, 15 May 2008 15:51:59 +0900
Message-ID: <482BDD8F.7060506@gmail.com>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com> <482AFB12.3040005@rtr.ca> <482AFCFA.40708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:34106 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYEOGwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 02:52:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so261164wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 14 May 2008 23:52:07 -0700 (PDT)
In-Reply-To: <482AFCFA.40708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mark Lord wrote:
>> ..
>> At the moment, I have the Sil PM plugged in, and it all behaves nicely.
>> The previous failure was with the Marvell PM, so I'll hook that up next
>> and retest with it.
> ..
> 
> It went bonkers again.  This is with 2.6.25.
> I'll build 2.6.26-git and try again with that shortly.
> 
> One thing about sata_sil24 --> it *really* doesn't like to handle
> hotplug events while in the midst of EH.
> 
> I unplugged the host cable from the PM, and the EH just kept on
> going and going.
> 
> I then unplugged the sata_sil24 PCIe host adapter card,
> and it still took quite some time to give up on the Energizer Bunny 
> routine.  :)

Heh... The retry count on the host side when PMP is attached is set 
higher because losing the PMP means losing all devices beyond it.  I 
agree it would be better to add a total time limit there tho.

Thanks.

-- 
tejun
