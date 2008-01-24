From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Thu, 24 Jan 2008 10:42:11 +0900
Message-ID: <4797ECF3.5000306@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com>	 <4794CB8B.1070600@gmail.com> <4795545E.5010908@gmail.com>	 <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>	 <4796DC44.6010100@gmail.com> <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:20657 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbYAXBma (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 20:42:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so59891wah.23
        for <linux-ide@vger.kernel.org>; Wed, 23 Jan 2008 17:42:30 -0800 (PST)
In-Reply-To: <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> Hi All -
>>> If I forget and get the "Plug and Play" error, disconnecting the
>>> drives and resetting isn't enough, nor is power cycling *or*
>>> unplugging the machine.  I have to physically remove the card and
>>> restart without it, power down and then re-insert it.  I could only
>>> plug the card into a 32bit slot, btw.
>> So, except for BIOS weirdness, it works.
> 
> I downgraded the BIOS in the card and it even works better on the x86 -
> not more pnp errors.
> 
>> On x86, BIOS runs, on alpha, it doesn't.  It could be that BIOS
>> configures something.  Can you please post the result of 'lspci
>> -nnvvvxxx' of the sil24 controller on alpha and x86?
> 
> I was attempting to look at that - SRM on Alpha won't run arbitrary
> option BIOSs (at least that I can figure - it will run those of
> devices it recognizes in some way via emulation).
> 
> With that said, I've attached the output ...
> 
> They are different, just don't understand the differences.

The only differences are in the standard section - PCI bus
configuration, BAR allocation, etc.  If you connect a regular harddrive
instead of a PMP, it works well on alpha, right?

-- 
tejun
