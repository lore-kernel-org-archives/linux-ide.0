From: Tejun Heo <htejun@gmail.com>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Fri, 25 Jan 2008 13:08:59 +0900
Message-ID: <479960DB.8050109@gmail.com>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com> <4799270D.3010009@rtr.ca> <4799285F.3060308@gmail.com> <47995EFD.8030102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:33751 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYAYEJF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 23:09:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so809897wah.23
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 20:09:04 -0800 (PST)
In-Reply-To: <47995EFD.8030102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> Super.  And when I add FIS-based-switching PMP support on top of NCQ,
>>> *then* what should it point at?
>>
>> If the controller can do FIS-based switching w/o any other restrictions,
>> ata_std_qc_defer() can just stay.  If there are restrictions, you need
>> to roll your own qc_defer.  sata_sil24 had to.
>>
>> For command-based switching, sata_pmp_qc_defer_cmd_switch() can be used.
> ...
> 
> Super!  You've done a great job with this stuff, Tejun!

Thanks but I can't really say nice things about how sata_sil24's
qc_defer() is implemented or how we generally handle command deferring.
 We really need the control at the higher level - request_queue group.
Oh well... I guess you guys will be talking about it over beer again
soon.  :-)

-- 
tejun
