From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 00:16:31 -0300
Message-ID: <4bbe9c12.1502be0a.0f89.1047@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
	<4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	<n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	<4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
	<o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:52448 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0DIDl1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 23:41:27 -0400
Received: by ywh32 with SMTP id 32so251863ywh.33
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 20:41:26 -0700 (PDT)
In-Reply-To: <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 8 Apr 2010 20:52:34 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> We can detect an AHCI-capable Intel chipsets (in most cases anyway),
> but problem is that a lot of systems with such chipsets, especially
> laptops, unfortunately have no way to actually put the controller into
> AHCI mode (no BIOS option for it). We could whine about it, but in a
> lot of cases there's not much that can be done about it..
> 
> Intel chipsets are pretty much the only ones that have the separate
> modes in the BIOS for AHCI - others like NVIDIA AHCI-compliant
> controllers support both legacy mode and AHCI in the same device,
> which is a lot more convenient in some ways..

	Yes, I agree completely!

	It's absurd that in plain XXI century, hardware makers still
default to legacy mode without a chance for the user to change that in
BIOS.

	I understand that Linus Torvalds complained about EFI some time
ago (http://kerneltrap.org/node/6884), citing it as "other Intel
brain-damage" but at least EFI would give a chance for the user to
interact better with the system than the limited, ugly and old "BIOS".

	When every motherboard maker adopt EFI, I hope this limitation
will go away. I can't understand why new Core i7 systems still use BIOS
instead of EFI.

-- 
