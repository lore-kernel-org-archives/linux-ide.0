From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Sat, 03 Nov 2007 09:42:50 +0900
Message-ID: <472BC40A.3010205@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<472B40B0.6010702@gmail.com>	<20071102154406.7596b384@the-village.bc.nu>	<472BA318.7010406@gmail.com> <20071103001018.5a71bfd3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:59217 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093AbXKCAnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 20:43:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so931379rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 17:42:59 -0700 (PDT)
In-Reply-To: <20071103001018.5a71bfd3@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, again.  Forgot one thing.

Alan Cox wrote:
>> all we can use is how the BIOS configured it.  I suppose BIOS does it by
>> issuing trial commands which I don't think adding to libata is a good idea.
> 
> The BIOS does it by asking the hardware somehow. I traced one or two
> BIOSes that far. The info is there but its not documented in the
> slightest so only ACPI makes it visible via the BIOS.
> 
>> Can you please lemme know what you don't like about the current
>> implementation or what other approach you have in mind?  I don't like
>> Nvidia PATA either but there are a lot of people using it out there.
> 
> We seem to be able to trust the drives and BIOS ACPI data for Nvidia (at
> least what I have seen), so I guess we should simply declare the cable
> type unknown, 80 wire if ACPI says it is and then do the drive detect
> side ?

The drive side can't be trusted.  For the drive side detection work
properly, there should be a capacitor attached to PDIAG-:CBLID- line so
that the drive can tell 40C cable which connects CBLID- to the host
connector by sampling while the capacitor is still discharging.  If
there's no capacitor on the line, 40C and 80C cables behave identically.
 Voltage rises as soon as CBLID- is disasserted and drive always reports
80C and that's what happens on my A8N-E.  Hell of a way to save cost for
one capacitor, I guess.  :-(

-- 
tejun
