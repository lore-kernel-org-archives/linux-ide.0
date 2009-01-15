From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through	sysfs
Date: Thu, 15 Jan 2009 14:37:36 +0900
Message-ID: <496ECBA0.60209@gmail.com>
References: <200901051952.58029.bzolnier@gmail.com>	 <20090105185428.GS32491@kernel.dk>	 <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>	 <20090106073515.GY32491@kernel.dk>  <4964866D.8010503@msgid.tls.msk.ru> <1231342473.3282.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:9012 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZAOFhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jan 2009 00:37:45 -0500
In-Reply-To: <1231342473.3282.19.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Jens Axboe <jens.axboe@oracle.com>, Kay Sievers <kay.sievers@vrfy.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello,

James Bottomley wrote:
> I'm afraid that's pretty much marketing coolaid.  Rotational storage
> will dominate for the forseeable future: just do a simple back of the
> envelope calculation:

Or just compare prices per byte of memory, flash and rotation disk.
They haven't had changed too much during last several years.
Secondary storage which is only slightly cheaper than the primary
storage doesn't have much chance of flying high and far.

Thanks.

-- 
tejun
