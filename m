From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Thu, 06 Jan 2011 18:17:56 -0500
Message-ID: <4D264DA4.6040308@pobox.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com> <4D24B53C.4020009@pobox.com> <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com> <20110106105157.GA9560@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39567 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1AFXSD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 18:18:03 -0500
Received: by qwa26 with SMTP id 26so17278871qwa.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 15:18:01 -0800 (PST)
In-Reply-To: <20110106105157.GA9560@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>, Lin Mac <mkl0301@gmail.com>
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On 01/06/2011 05:51 AM, Anton Vorontsov wrote:
> On Thu, Jan 06, 2011 at 02:43:08PM +0800, Lin Mac wrote:
> [...]
>>> It is overkill to rename the entirety of ahci_platform just for one override
>>> function.
>>> This sort of thing I would have expected to be added directly to
>>> ahci_platform.c.
>> It might be overkill for only one controller. but it is more clean and
>> readable to have different SoC specific changes in separate files,
>> especially when more SoCs need to make similar changes.
>
> I think that renaming the file is not necessary. You can just
> rename the module in the makefile.
>
> Personally I like the current approach more than putting
> controller-specific fixups directly into ahci_platform.

My main objection is the renaming.  If ahci_platform wants to export 
some symbols for SoC modules like ahci_platform_cns, that's ok.

In general, follow the library approach rather than linking modules 
together in strange ways.

	Jeff


