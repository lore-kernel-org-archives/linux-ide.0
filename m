From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] iomap: iomap should be in obj-y not in lib-y
Date: Thu, 01 Feb 2007 02:23:57 +0900
Message-ID: <45C0D0AD.1090703@gmail.com>
References: <20070131134806.GJ8606@htj.dyndns.org> <45C0B170.8050901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:29531 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030443AbXAaRYD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 12:24:03 -0500
Received: by an-out-0708.google.com with SMTP id b33so149844ana
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 09:24:02 -0800 (PST)
In-Reply-To: <45C0B170.8050901@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> devres change moved iomap.o from obj-$(CONFIG_GENERIC_IOMAP) to lib-y
>> making it not linked if no in-kernel driver uses it.  Fix it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied
> 
> BTW can you update your scripts to email jeff@garzik.org ?  That's the
> primary email address I signoff with, etc.

Okay, done.

> jgarzik@pobox.com will continue to work for all eternity, but it makes
> Mozilla Thunderbird stupidly add an unneeded CC.

Also, you can avoid that by configuring aliases to the thunderbird
account.  It's in account setting -> Manage Identities.  Thungerbird is
pretty neat.  :-)

-- 
tejun
