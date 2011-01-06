From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Thu, 6 Jan 2011 13:51:57 +0300
Message-ID: <20110106105157.GA9560@oksana.dev.rtsoft.ru>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
 <4D24B53C.4020009@pobox.com>
 <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39425 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab1AFKwE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 05:52:04 -0500
Received: by ewy5 with SMTP id 5so7275401ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 02:52:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Thu, Jan 06, 2011 at 02:43:08PM +0800, Lin Mac wrote:
[...]
> > It is overkill to rename the entirety of ahci_platform just for one override
> > function.
> > This sort of thing I would have expected to be added directly to
> > ahci_platform.c.
> It might be overkill for only one controller. but it is more clean and
> readable to have different SoC specific changes in separate files,
> especially when more SoCs need to make similar changes.

I think that renaming the file is not necessary. You can just
rename the module in the makefile.

Personally I like the current approach more than putting
controller-specific fixups directly into ahci_platform.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
