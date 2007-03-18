From: Tejun Heo <htejun@gmail.com>
Subject: Re: Add suport for Marvell 88SE6121 in ahci
Date: Sun, 18 Mar 2007 22:48:32 +0900
Message-ID: <45FD4330.1020108@gmail.com>
References: <200701311504.40277.jareguero@telefonica.net> <200703161521.29461.jareguero@telefonica.net> <45FCCDFA.8050800@gmail.com> <200703181335.41988.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:60307 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXCRNsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 09:48:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1084406uga
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 06:48:37 -0700 (PDT)
In-Reply-To: <200703181335.41988.jareguero@telefonica.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Jose Alberto Reguero wrote:
>> The flag is there primarily for ICH ahci's.  Marvell might be different.
>>  Care to remove SKIP_D2H_BSY and test a LOT of hotplugging with several
>> different devices?  :-)
> 
> With  SKIP_D2H_BSY I have a old dmesg -> dmesg1 (2.6.20 I think)
> I test with and a external sata disk without SKIP_D2H_BSY -> dmes2 
> (2.6.21-rc4)
> Both takes ~8 seconds.

I see.  Was the disk spun up when you hotplugged it?  The condition
doesn't trigger always and more importantly, there is no way to reliably
wait for the condition in ahci.  ahci's TF status register is read from
the received D2H Reg FIS area and there is no mechanism to set the BSY
bit on a PHY event, so no matter what we do in the driver, there is an
inherent race.

ie. we can try to set the BSY bit in the interrupt handler right after a
PHY event but the hardware can always beat us and when that happens we
set BSY after the first D2H Reg FIS is received which will in turn cause
wait timeout, so I'm voting for keeping the flag.

Thanks.

-- 
tejun
