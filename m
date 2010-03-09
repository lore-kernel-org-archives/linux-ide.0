From: Tejun Heo <tj@kernel.org>
Subject: Re: storage-fixup, info for WDC WD5000AAVS on ASUS M3A78PRO
Date: Tue, 09 Mar 2010 17:11:09 +0900
Message-ID: <4B96029D.8020708@kernel.org>
References: <201002090924.58093.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52626 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab0CIILO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 03:11:14 -0500
In-Reply-To: <201002090924.58093.roman.fietze@telemotive.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roman Fietze <roman.fietze@telemotive.de>
Cc: linux-ide@vger.kernel.org

Hello,

On 02/09/2010 05:24 PM, Roman Fietze wrote:
> # smartctl -a -v 193,loadunload /dev/sda | egrep 'Device Model|
> Load_Cycle_Count'
> Device Model:     WDC WD5000AAVS-00ZTB0
> 193 Load_Cycle_Count 0x0032 001 001 000 Old_age Always - 1637105/0
> 
> and rising every minute.

1637105 - that's impressive.  The model is rated for only 300k cycles.

> hdparm -B does not work at all, tried it with 254, 255 or no number
> at all.

I suppose there isn't much to do other than wishing for longevity.
Long live the drive!

Thanks.

-- 
tejun
