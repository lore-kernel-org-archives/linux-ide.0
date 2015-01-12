From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Subject: Re: Marvell 88SE9320 SATA controller failure during heavy load
Date: Mon, 12 Jan 2015 09:33:24 +0100
Message-ID: <CAPRPZsBO1HzKecdtYH+LDUsobf50mC+UJy7d+x4m8F4U0UnQig@mail.gmail.com>
References: <CAPRPZsAZ1n0pd6kviJ5E8C6gV3RGECEZYGQx=485wysS_OYcxA@mail.gmail.com>
	<54B2B550.9050807@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:52017 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbALIdY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2015 03:33:24 -0500
Received: by mail-qg0-f46.google.com with SMTP id q107so16526180qgd.5
        for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2015 00:33:24 -0800 (PST)
In-Reply-To: <54B2B550.9050807@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: linux-ide@vger.kernel.org

> I've seen several models of WD drive  which fail when you issue SMART
> commands during heavy I/O load, (all older vintages of drive than yours,
> but I've largely avoided WD since then so couldn't say with much
> certainty if they've fixed these issues in their drive firmware).

I will check this by attaching the disks to the MB SATA ports.

> I've also seen multiple failures under load with multiple Marvell
> controllers (all Marvell AHCI controllers) unless NCQ is disabled.  Best
> guess is that this is due to a long standing controller design fault.

I would still consider the possibility that there's a compatibility
issue with the AHCI driver. Given the popularity of the Marvell chips,
I think it's worth investigating where the problem really is and
ensuring Linux works reliably with these controllers as well.

> If I were seeing this problem, and I had a spare PCIe slot, then I'd
> swap out the Marvell based controller for either 2x Silicon Image 3132
> based cards, or alternatively 2x Asmedia 1061 (e.g. SY-PEX40039), to see
> if the problems go away.

Cannot do that. I have no PCIe slots left.

Thanks,


Jeroen.
