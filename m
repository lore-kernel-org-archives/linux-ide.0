From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Fri, 7 Jan 2011 00:18:08 +0800
Message-ID: <AANLkTimWYUnO_MkawaOpJX3Sm9YZHsECgmotiNwkb8mN@mail.gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<4D24B53C.4020009@pobox.com>
	<AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
	<20110106105157.GA9560@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50124 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1AFQSK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 11:18:10 -0500
Received: by fxm20 with SMTP id 20so16142308fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 08:18:08 -0800 (PST)
In-Reply-To: <20110106105157.GA9560@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

2011/1/6 Anton Vorontsov <cbouatmailru@gmail.com>:
> On Thu, Jan 06, 2011 at 02:43:08PM +0800, Lin Mac wrote:
> [...]
>> > It is overkill to rename the entirety of ahci_platform just for one override
>> > function.
>> > This sort of thing I would have expected to be added directly to
>> > ahci_platform.c.
>> It might be overkill for only one controller. but it is more clean and
>> readable to have different SoC specific changes in separate files,
>> especially when more SoCs need to make similar changes.
> I think that renaming the file is not necessary. You can just
> rename the module in the makefile.
That is for consist end user experience. I wouldn't like to find my
script not working anymore when changing to some linux version, simply
because someone fix some issue on some platform I'm not using.

> Personally I like the current approach more than putting
> controller-specific fixups directly into ahci_platform.

Best Regards,
Mac Lin.
