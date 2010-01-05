From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 05 Jan 2010 05:04:42 -0500
Message-ID: <4B430EBA.1030908@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B428FF5.7040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:34906 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0AEKEr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 05:04:47 -0500
Received: by yxe26 with SMTP id 26so15454738yxe.4
        for <linux-ide@vger.kernel.org>; Tue, 05 Jan 2010 02:04:44 -0800 (PST)
In-Reply-To: <4B428FF5.7040702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 08:03 PM, Robert Hancock wrote:
> rom ATA-8 APT:
>
> "HDMA0: Check_Status State: This state is entered when the host has
> written a DMA command to the device; when all data for the command has
> been transferred and nIEN is set to one; or when all data for the
> command has been transferred, nIEN is cleared zero, and INTRQ has been
> asserted.
>
> When in this state, the host shall read the device Status register. When
> entering this state from the HI4 state, the host shall wait 400 ns
> before reading the Status register. When entering this state from the
> HDMA1 state,
> the host shall wait one PIO transfer cycle time before reading the
> Status register. The wait may be accomplished by reading the Alternate
> Status register and ignoring the result."


Indeed...  I had forgotten about that bit.

	Jeff



