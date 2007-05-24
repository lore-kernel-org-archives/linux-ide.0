From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 16:21:15 +0200
Message-ID: <46559F5B.4090700@gmail.com>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com> <46559C62.2040509@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:39569 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXEXOVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:21:31 -0400
Received: by nz-out-0506.google.com with SMTP id n1so51215nzf
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 07:21:30 -0700 (PDT)
In-Reply-To: <46559C62.2040509@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Florian Effenberger wrote:
>> Looks like a genuine transmission/interface error to me.  How often does
>> this occur?  Please try to connect the drive to another port using and
>> possibly different power lane.  Also, testing with another drive is a
>> good way to track down where the problem is.
> 
> it occurs as soon as the drive is being used heavily (load of about 2,x
> on the machine when running our test scripts). About 15 times in 2 or 3
> hours. Will try to change port, power supply and drive.
> 
>> Yeah, libata EH is working properly so there shouldn't be any problem
>> other than the error messages and a bit slower transfer speed.
> 
> So, even if the errors are still there, there is nothing real to worry
> about for me?

Data integrity wise there should be no problem but your error rate is
pretty high and eventually will make libata turn off NCQ and/or speed
down PHY speed.

> There are now new errors with hard errors, is this still ok?
> 
> ===
> ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> ata4.00: cmd 60/80:00:00:09:97/00:00:0a:00:00/40 tag 0 cdb 0x0 data
> 65536 in
>          res 40/00:04:00:67:14/00:00:1c:00:00/40 Emask 0x4 (timeout)

Yeap, your data is safe.  With timeouts, data transfer speed can be much
lower tho.  It definitely seems something is wrong with your hardware setup.

-- 
tejun
