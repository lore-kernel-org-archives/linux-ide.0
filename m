From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 18:39:42 -0500
Message-ID: <4BA2B9BE.5030607@hardwarefreak.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com> <4BA2AA34.70105@hardwarefreak.com> <4BA2B15E.6000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:54492 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab0CRXjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 19:39:44 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 3564C6C002
	for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 18:39:43 -0500 (CDT)
In-Reply-To: <4BA2B15E.6000301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ludovico Cavedon put forth on 3/18/2010 6:03 PM:
> Stan Hoeppner wrote:
>> Is there a SATA backplane involved or is each drive cabled directly to the
>> controller?  If backplane, is it active or passive?  Whose product is it?
> 
> no backplance.
> This is the machine
> http://www.supermicro.com/products/system/2U/6026/SYS-6026T-URF.cfm

It most certainly does have a backplane, and an active backplane at that.
Defective or marginal backplanes are known to cause intermittent problems of
the nature you're describing, especially active backplanes.  This is why I
asked.  "Enclosure Management" below is a feature of only active backplanes.
 The difference between active and passive is that active units have one or
more ASICs (chips) on the circuit board to control various functions of the
backplane such as fan control, alarms, drive monitoring circuits to sense
drive failures, etc.  Have you configured an I2C module to monitor the
backplane?  If so, check those logs.  If not, do so now.  It's possible that
the backplane controller is erroneously kicking the drives off-line.  This
could explain the SATA bus errors.  It's also possible there is a problem
with the backplane controller chip itself or other circuitry on the PCB
causing problems.

SAS Backplane
1x 2U SAS backplane w/ Enclosure Management

http://www.supermicro.com/products/chassis/2U/825/SC825TQ-R720U.cfm

>> Is this a relatively new machine or has it been running for some months
>> without problems until recently?
> 
> It is new machine, running only for two months.

You need to call SuperMicro support and tell them about your issue.
Backplane boards are relatively cheap.  Get them to send you a warranty
advance replacement backplane and see if that fixes the problem.  If you're
not a hardware person, replacing it may not be a job for you.  In that case,
I'm not sure what to tell you, as last I knew SuperMicro doesn't offer
onsite service.  If indeed the backplane is the problem, you may have to
ship the unit back for repair.  This is the main reason (lack of onsite
service) than most companies stick with IBM, Dell, HP, etc servers.

-- 
Stan
