From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] amd74xx: don't configure udma mode higher than BIOS did
Date: Mon, 05 Feb 2007 21:33:03 +0900
Message-ID: <45C723FF.2060405@gmail.com>
References: <20070205075836.GG1625@htj.dyndns.org> <20070205112410.5a3c3182@localhost.localdomain> <45C72012.7050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:10694 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbXBEMdJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 07:33:09 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1590328nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 04:33:08 -0800 (PST)
In-Reply-To: <45C72012.7050605@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Forgot to reply about some stuff.  Adding.

Tejun Heo wrote:
> Alan wrote:
>>> This patch makes amd74xx not configure udma mode higher than BIOS did.
>>> If BIOS configured the device <= udma44, udma33 is the maximum speed.
>> NAK
>>
>> The boot firmware for AMD/Nvidia chips is only run on PC, and the data is
>> only valid on some of them, in some cases, and not after a suspend/resume
>> cycle.

To prevent that, the value is cached on driver probe and written back on
driver detach on pata_amd, which is necessary even when there is no
suspend/resume as mode programming alters the content of the register.
amd74xx cannot be unloaded, so caching is enough.  Also, doesn't
suspend/resume cycle store and restore PCI space anyway?

Thanks.

-- 
tejun
