From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: understanding the cause of ATA failures
Date: Fri, 19 Mar 2010 05:26:40 -0500
Message-ID: <4BA35160.4010809@hardwarefreak.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com> <4BA2AA34.70105@hardwarefreak.com> <4BA2B15E.6000301@gmail.com> <4BA2B9BE.5030607@hardwarefreak.com> <4BA2F19D.1090501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:57170 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab0CSK0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Mar 2010 06:26:44 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 0D2106C3D5
	for <linux-ide@vger.kernel.org>; Fri, 19 Mar 2010 05:26:41 -0500 (CDT)
In-Reply-To: <4BA2F19D.1090501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ludovico Cavedon put forth on 3/18/2010 10:38 PM:

> Unfortunately the I2C connectors on the backplane are not connected to
> anything. The motherboard has a "IPMB I2C" connector", but I guess I
> cannot connect a generic I2C device... I should probably get a USB-I2C
> module...

Normally this backplane I2C connector would be cabled to a (real) RAID card
which would speak the right language.  Your motherboard has no such
dedicated I2C port for the SAS/SATA backplane.  I2C is a bus protocol, so
any I2C compliant device "should" be able to talk on that bus.  The problem
you'll probably run into is that there isn't any generic Linux software
designed to talk to an I2C chip such as the MG9072 on your backplane which
speaks SES-2 over I2C.  And according to various SM docs I found you have to
be running SAS drives/controller in order to use SES-2 over I2C since SES-2
uses the SCSI command set (which SATA obviously lacks).

In short, I don't know how it all needs to be hooked up, what the specific
device combination needs to be, or what Linux modules you need to
communicate with the MG9072 chip on that backplane.  Again, call your
vendor.  It's their product.  They should have the answers.

> Btw, once I am able to access the I2C device on the backplane, what tool
> is able to query the state? I am having troubles finding documentation
> about that. lm-sensors does not seem to mention that... Is the ses
> kernel module able to work over i2c?

lm-sensors isn't the right tool.  You need to tak SES-2 to that chip.  As I
said, short of having a real SAS RAID card, I'm not sure at this point if
you will be able to poll it at all.  Ask SuperMicro.

>> the backplane controller is erroneously kicking the drives off-line.  This
>> could explain the SATA bus errors.  It's also possible there is a problem
>> with the backplane controller chip itself or other circuitry on the PCB
>> causing problems.
> 
> I see.

The manufacturing cost of SCSI/SAS/SATA backplane PCBs is usually less than
$10 USD.  Retail price for a new replacement unit is only $69 at

http://www.atacom.com/program/atacom.cgi?KEYWORDS=RAAC_SUPE_AD_01&USER_ID=www&SEARCH=SEARCH_ALL&CODE=7581A0317

SuperMicro probably pays around $15 for this PCB and sells it to
distributors for $40 who then price it at approximately double their cost.

Ever heard the old saying "you get what you pay for"?  Ultra low cost items
don't get the quality control care that they should.  These backplane PCBs
are all made in China today by the lowest bid PCB manufacturer.  The QC on
disk drives is usually 2-3 orders of magnitude greater than these
backplanes, same goes for mainboards.  This is why backplanes are always the
first suspect when weird intermittent drive behavior is observed.

I'm not guaranteeing your problem is due to the backplane.  What I am saying
is that it's the most likely cause, historically, and thus the first place
to start troubleshooting.  I dealt with more than my share of backplane
problems back when SCSI RAID was king a little over a decade ago.  Mylex
DAC960s and AMI MegaRAID controllers tended to be very finicky about SCSI
bus signal quality.  We had quite a few problems with mid grade single drive
cages and 3-6 drive backplanes from various manufacturers.  IIRC about 1 in
10 backplanes showed problems on the bench while exercising the arrays
during system burn in and required replacement.  1 in 100+ was the norm for
most other products, from mainboards to disk drives.  We never had a bad
RAID controller.  Then again, at those prices back then, they better not
have been bad out of the box, at $350-$1000 each.

> Thank you for the information!

Your welcome.  Glad to pass on some of my experience if it can help someone
else.  I wish there was more I could do at this point, but it's pretty much
up to you now.  Hope I've helped steer you in the right direction.  As
always, don't put all your eggs in this one troubleshooting basket.  The
cause of the problem could also lie elsewhere so keep and open mind and
don't throw up your hand in frustration if this track doesn't pan out.

-- 
Stan
