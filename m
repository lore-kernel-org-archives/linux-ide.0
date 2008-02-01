From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pm
Date: Fri, 01 Feb 2008 22:53:27 +0900
Message-ID: <47A32457.5080705@gmail.com>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>                <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>                <479BC34D.2000007@gmail.com>             <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>          <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>          <479D2D3C.4050102@gmail.com>       <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>       <479DC4A4.30809@gmail.com>    <50028.82.140.53.128.1201728857.squirrel@ssl.cavemail.org>    <47A120D4.7030504@gmail.com> <59194.82.140.47.129.1201873378.squirrel@ssl.cavemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:56941 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYBANxe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 08:53:34 -0500
Received: by an-out-0708.google.com with SMTP id d31so269225and.103
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 05:53:33 -0800 (PST)
In-Reply-To: <59194.82.140.47.129.1201873378.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: linux-ide@vger.kernel.org

dusty@gmx.li wrote:
>>> Sorry for my late answer, but i had to sort this out first.
>>> After replacing the first PSU with a new Corsair 650W the power no
>>> longer fluctuated more than 0,01 V (and this only when booting up the
>>> drives...) I did a full resync on both raid arrays and got no more
>>> errors or resets, but there were some inconsitencies during sync and the
>>> xfs filesystem on both arrays had to be repaired. Are these problems
>>> caused by the pm resets ?
>>>
>> libata EH won't lose any data as long as the hardware doesn't.  If power
>> fluctuates causing your drive to briefly power down - this does happen and
>> you can hear the drive doing emergency unload when it happens, the data in
>> write buffer can be lost.  On coming back, all that libata can know is
>> that the PHY suffered brief connection loss, so it resets the device and
>> goes on, so the data in the cache is lost now.  It's basically pulling the
>> power plug from the harddrive while write is going on and connecting it
>> back quickly.  You're bound to lose data.
>>
> After I got the new PSU and the raid was in full sync without any error
> for 48h, I thought all problems were gone. Today the sata errors
> reappeared and whenever the load is high enough I get the following:
> 
> ata10.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

> ata10.02: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 2 cdb 0x0 data 0
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Those are time outs for FLUSH.  libata told the drive to flush its cache
onto the media and the drive failed to finish that in 30secs.  As FLUSH
itself is a non-data command, this problem usually isn't caused by
transport layer problems.  This is a pretty good clue that the drive is
knee-deep in s**t.  What does 'smartctl -a' tell you about the drive?

-- 
tejun
