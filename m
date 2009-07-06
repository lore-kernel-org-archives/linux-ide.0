From: David Miller <davem@davemloft.net>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date: Mon, 06 Jul 2009 12:22:38 -0700 (PDT)
Message-ID: <20090706.122238.212724277.davem@davemloft.net>
References: <200907031508.47891.bzolnier@gmail.com>
	<1246635096.16890.6.camel@falcon>
	<200907061658.00936.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33579
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752964AbZGFTWb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jul 2009 15:22:31 -0400
In-Reply-To: <200907061658.00936.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: wuzhangjin@gmail.com, jeff.chua.linux@gmail.com, etienne.basset@numericable.fr, rjw@sisk.pl, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 6 Jul 2009 16:57:59 +0200

>> I think it's better to revert this commit:
>>  a1317f714af7aed60ddc182d0122477cbe36ee9b ("ide: improve handling of
>> Power Management requests")
>  
> I completely agree and I've already requested this a week ago
> (this commit was not meant for going straight to -rc tree anyway).

I'll revert this today and push that to Linus.
