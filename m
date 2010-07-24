From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 18:08:05 -0500
Message-ID: <4C4B7255.2070505@hardwarefreak.com>
References: <4C4AB952.9030705@kernel.org>            <1279974966.11927.26.camel@lithium.local.net> <92061.1279979348@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:53705 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0GXXII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jul 2010 19:08:08 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 791426C072
	for <linux-ide@vger.kernel.org>; Sat, 24 Jul 2010 18:08:06 -0500 (CDT)
In-Reply-To: <92061.1279979348@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Valdis.Kletnieks@vt.edu put forth on 7/24/2010 8:49 AM:

> As a side consideration - moving from 512 to 4K moves the associated limit from
> 2 TiB to 16 TiB.  Given the current rate of device density increase, how much
> time will that buy us, and what do we do then?

The crystal ball tells me that SSD adoption will kick this date a little
farther into the future given that SSD capacity lags mechanical by a large
margin.  In the not too distance future, PCs/laptops/netbooks will all
transition to shipping with SSD as their sole/main internal storage device,
with USB3/eSATA thumb drives of 1TB and above permanently replacing external
USB/eSATA mechanical drives.

Servers will probably transition at about the same time to shipping with
solely SSD storage internally for boot/OS and maybe some other primary and a
little secondary storage, with mechanical storage being optional, whether
internal or external.  Mechanical in the form of FC/iSCSI SAN and NAS arrays
will still rule large data needs well after the aforementioned transitions above.

-- 
Stan
