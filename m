From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pm
Date: Thu, 31 Jan 2008 10:13:56 +0900
Message-ID: <47A120D4.7030504@gmail.com>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>             <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>             <479BC34D.2000007@gmail.com>          <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org>       <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>       <479D2D3C.4050102@gmail.com>    <51861.82.140.47.248.1201516318.squirrel@ssl.cavemail.org>    <479DC4A4.30809@gmail.com> <50028.82.140.53.128.1201728857.squirrel@ssl.cavemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:5592 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYAaBOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 20:14:09 -0500
Received: by po-out-1718.google.com with SMTP id c31so776768poi.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 17:14:08 -0800 (PST)
In-Reply-To: <50028.82.140.53.128.1201728857.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: linux-ide@vger.kernel.org

dusty@gmx.li wrote:
> Sorry for my late answer, but i had to sort this out first.
> After replacing the first PSU with a new Corsair 650W the power no longer
> fluctuated more than 0,01 V (and this only when booting up the drives...)
> I did a full resync on both raid arrays and got no more errors or resets,
> but there were some inconsitencies during sync and the xfs filesystem on
> both arrays had to be repaired. Are these problems caused by the pm resets
> ?

libata EH won't lose any data as long as the hardware doesn't.  If power
fluctuates causing your drive to briefly power down - this does happen
and you can hear the drive doing emergency unload when it happens, the
data in write buffer can be lost.  On coming back, all that libata can
know is that the PHY suffered brief connection loss, so it resets the
device and goes on, so the data in the cache is lost now.  It's
basically pulling the power plug from the harddrive while write is going
on and connecting it back quickly.  You're bound to lose data.

-- 
tejun
