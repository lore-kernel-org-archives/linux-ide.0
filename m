From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] ahci: add warning messages for hp laptops
 with broken suspend
Date: Wed, 10 Jun 2009 17:38:28 +0900
Message-ID: <4A2F7104.2010602@gmail.com>
References: <4A211D74.5070208@kernel.org> <4A2F630E.3080904@gmail.com> <4A2F6BEE.5050208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f200.google.com ([209.85.216.200]:43438 "EHLO
	mail-px0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbZFJIia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 04:38:30 -0400
Received: by pxi38 with SMTP id 38so548518pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 01:38:32 -0700 (PDT)
In-Reply-To: <4A2F6BEE.5050208@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, kernel.org@epperson.homelinux.net, emisca@gmail.com, Gadi Cohen <dragon@wastelands.net>, Paul Swanson <paul@procursa.com>, s@ourada.org, Trevor Davenport <trevor.davenport@gmail.com>, corruptor1972 <steven_tierney@yahoo.co.uk>, Victoria Wilson <mail@vwilson.co.uk>, khiraly <khiraly.list@gmail.com>, Sean <wollombi@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Tejun Heo wrote:
>>> Harddisks on HP dv[4-6] and HDX18 fail to come online after resume on
>>> earlier BIOSen.  Fortunately, HP recently released BIOS updates for
>>> all machines to fix the issue.  Detect old BIOSen, warn the user to
>>> update BIOS on boot and suspend attempts and fail suspend.
>>
>> Ping.
> 
> 
> eh?  This is upstream as 9b10ae86d1616f46dabb67c663fe6a9c3a502663

Sorry about that.  Didn't check git history.  Was waiting for the good
old "applied" message.  :-)

Thanks.

-- 
tejun
