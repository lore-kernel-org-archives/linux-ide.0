From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
Date: Mon, 20 Oct 2008 18:40:56 +0400
Message-ID: <48FC9878.4030306@ru.mvista.com>
References: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>	<48FB7D9E.4030803@ru.mvista.com> <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:35142 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750769AbYJTOlP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Oct 2008 10:41:15 -0400
In-Reply-To: <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

>>>+	struct tx4938ide_platform_info pdata = {
>>>+		.ioport_shift = shift,
>>>+		.gbus_clock = tune ? txx9_gbus_clock : 0,

>>    Any reason not to supply the GBUS clock?

> The EBUS channel might be used for both ATA and ISA or other local bus
> devices.  In that case, the board setup code should initialize best
> timings for all devices and the IDE driver should not overrite it.

    Ah, I forgot about the ATA address space being appeandage to ISA address 
space on TX4939...

>>    I'm afraid you can't just early return from the set_pio_mode() method...

> Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
> returning from set_pio_mode?

    No, that's for the smart RAID controllers that program the transfer modes 
themselves. In your case, hwif->port_ops->set_pio_mode() must be NULL -- if 
you're not going to allow the mode programming, that is.

MBR, Sergei
