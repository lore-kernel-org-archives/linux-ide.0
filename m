From: Felix Miata <mrmazda@earthlink.net>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 06:02:06 -0500
Message-ID: <4B977C2E.10003@earthlink.net>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de> <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-cowbird.atl.sa.earthlink.net ([207.69.195.68]:34339 "EHLO
	pop-cowbird.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755698Ab0CJLBy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Mar 2010 06:01:54 -0500
Received: from user-142grkd.cable.mindspring.com ([72.40.110.141] helo=[192.168.0.51])
	by pop-cowbird.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1NpJfm-0005MJ-00
	for linux-ide@vger.kernel.org; Wed, 10 Mar 2010 06:01:54 -0500
In-Reply-To: <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2010/03/10 10:14 (GMT+0100) Denys Vlasenko composed:

>> Do we know of anything that requires 63s/255h?

> 63s/255h is more or less "standard" now.

When did this change? AFAICT, this "standard" only applies to desktops, while
63s/240h applies to laptops, older Compaqs, and some brain dead external/USB
drive case controllers.

> Alignment issues can be solved by picking a good multiple of
> _heads_ or _cylinders_:

> For first partition, pick the start at 8th head:

> cyl 0 head 1 sector 1: LBA sector 63) - bad
> cyl 0 head 8 sector 1: LBA sector 8*63) - good (4k aligned)

> For any other partition, pick start cylinder which is a multiple of 8:

> cyl 8*x head 0 sector 1: LBA sector 8*x*255*63 - good (4k aligned)

> This will actually work well for *any* geometry, not only for 63s/255h.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
