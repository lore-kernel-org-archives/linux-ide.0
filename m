From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET #upstream-fixes] libata: update HPA handling
Date: Mon, 27 Aug 2007 13:48:08 +0900
Message-ID: <46D25788.4090907@gmail.com>
References: <20070815180508.GD21623@htj.dyndns.org> <46C406AD.5000904@garzik.org> <46C4305B.5090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:4316 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXH0Ese (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2007 00:48:34 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1925483wah
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 21:48:33 -0700 (PDT)
In-Reply-To: <46C4305B.5090106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Hello,
>>>
>>> The current HPA handling implementation isn't robust enough and causes
>>> regressions on several cases.  This patchset contains HPA handling
>>> update.
>>>
>>> * blacklist devices which puke on READ_NATIVE_MAX
>>> * proper/better error handling - in most cases, HPA failure won't
>>>   result in detection failure
>>> * re-read IDENTIFY data after resizing
>>> * more concise messages
>>>
>>> Tested by setting up HPA area manually.
>> This is a bit big for 2.6.23-rc though :/
> 
> Agreed.  We can probably just get away with ATA_HORKAGE_BROKEN_HPA patch
> for 2.6.23-rc but if we hit a device which is broken but isn't listed,
> libata will fail to detect the device, which is a pretty serious regression.
> 

PING.  Do you want me to separate out the blacklist patch for
#upstream-fixes and commit HPA error handling reimplementation only into
#upstream?

-- 
tejun
