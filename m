From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 20:38:05 -0700
Message-ID: <4BA2F19D.1090501@gmail.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com> <4BA2AA34.70105@hardwarefreak.com> <4BA2B15E.6000301@gmail.com> <4BA2B9BE.5030607@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33318 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab0CSDiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 23:38:09 -0400
Received: by gyg8 with SMTP id 8so1390736gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 20:38:08 -0700 (PDT)
In-Reply-To: <4BA2B9BE.5030607@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: linux-ide@vger.kernel.org

Stan Hoeppner wrote:
> Ludovico Cavedon put forth on 3/18/2010 6:03 PM:
>> Stan Hoeppner wrote:
>>> Is there a SATA backplane involved or is each drive cabled directly to the
>>> controller?  If backplane, is it active or passive?  Whose product is it?
>> no backplance.
>> This is the machine
>> http://www.supermicro.com/products/system/2U/6026/SYS-6026T-URF.cfm
> 
> It most certainly does have a backplane, and an active backplane at that.

Uhm, yes, you are right, it has a backplane with SES-2 over I2C support.
At first I though that backplanes were used only on external enclosures.

> drive failures, etc.  Have you configured an I2C module to monitor the
> backplane?  If so, check those logs.  If not, do so now.  It's possible that

Unfortunately the I2C connectors on the backplane are not connected to
anything. The motherboard has a "IPMB I2C" connector", but I guess I
cannot connect a generic I2C device... I should probably get a USB-I2C
module...

Btw, once I am able to access the I2C device on the backplane, what tool
is able to query the state? I am having troubles finding documentation
about that. lm-sensors does not seem to mention that... Is the ses
kernel module able to work over i2c?

> the backplane controller is erroneously kicking the drives off-line.  This
> could explain the SATA bus errors.  It's also possible there is a problem
> with the backplane controller chip itself or other circuitry on the PCB
> causing problems.

I see.

>>> Is this a relatively new machine or has it been running for some months
>>> without problems until recently?
>> It is new machine, running only for two months.
> 
> You need to call SuperMicro support and tell them about your issue.

Makes sense.

> Backplane boards are relatively cheap.  Get them to send you a warranty
> advance replacement backplane and see if that fixes the problem.  If you're
> not a hardware person, replacing it may not be a job for you.  In that case,

That would not be a problem.


Thank you for the information!

Cheers,
Ludovico
