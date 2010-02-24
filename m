From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SB600 64-bit DMA BIOS misconfiguration (formerly RE: [PATCH
	2.6.34] ehci-hcd: add option to enable 64-bit DMA support)
Date: Tue, 23 Feb 2010 22:30:15 -0600
Message-ID: <51f3faa71002232030u4679b6d0yc8df0679d8e19106@mail.gmail.com>
References: <4B7CAF95.6020306@gmail.com> <20100218042626.GB11649@kroah.com>
	 <51f3faa71002172113o65a85ed6y5fa39d0b3a96f7ce@mail.gmail.com>
	 <SNT125-W3300E8CCB5A9BD2D7B9942C3410@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f177.google.com ([209.85.223.177]:34879 "EHLO
	mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab0BXEaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 23:30:16 -0500
In-Reply-To: <SNT125-W3300E8CCB5A9BD2D7B9942C3410@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuhong Bao <yuhongbao_386@hotmail.com>
Cc: greg@kroah.com, shane.huang@amd.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org

On Tue, Feb 23, 2010 at 9:53 PM, Yuhong Bao <yuhongbao_386@hotmail.com> wrote:
>
>> it doesn't work. Based on the libata experience with AHCI which has a
>> similar 64-bit feature flag, there are some controllers that didn't do
>> it properly, but not many (only ATI SB600 it appears, and only on
>> certain boards, as it seems it was a BIOS configuration issue).
> It seems it was solved by a DMI whitelist, but if it is a BIOS configuration issue, I think it would be better if it could be detected directly instead by reading the configuration directly from the device and correcting it if possible. Is that possible?

That would likely be the ideal solution, but only AMD would likely
have the info needed to do that, if it's possible..
