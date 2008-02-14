From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Thu, 14 Feb 2008 09:17:53 +0900
Message-ID: <47B388B1.6050203@gmail.com>
References: <47A3375F.80101@gmail.com> <47B2368D.9080408@gmail.com> <47B319C2.5030002@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.181]:41513 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765392AbYBNASA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:18:00 -0500
Received: by el-out-1112.google.com with SMTP id v27so204032ele.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 16:17:59 -0800 (PST)
In-Reply-To: <47B319C2.5030002@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Tejun Heo wrote:
>> This patch implements libata.force module parameter which can
>> selectively override ATA port, link and device configurations
>> including cable type, SATA PHY SPD limit, transfer mode and NCQ.
> ...
>> +    libata.force=    [LIBATA] Force configurations.  The format is comma
>> +            separated list of "[ID:]VAL" where ID is
>> +            PORT[:DEVICE].  PORT and DEVICE are decimal numbers
>> +            matching port, link or device.  Basically, it matches
> ..
> 
> Mmm.. not a NAK, but is there also a way to set/change these on the fly?

What do you mean by 'on the fly'?  While the system is running?  If so,
I think that should be done through other interfaces - pass through,
sysfs, etc...

> I ask because, on my 4-core test system here, libata enumerates
> the ports differently depending upon whether I boot with a 32-bit
> kernel or a 64-bit kernel.
> 
> Major PITA, that, and it's just the kind of thing that spoils
> fixed "PORT:DEVICE" module parameters, too.
> 
> Now mind you, it's more likely the PCI layer that does the reverse
> order thing, but the end result is that my drives/ports are numbered
> differently depending upon which kernel I happen to boot with.

Heck... That's ugly.  libata.force is mainly conceived as debugging /
installation helper, so using fixed PORT is good enough but maybe
allowing bus_id as PORT is useful?  Something like [00:1f.2]:00?

-- 
tejun
