From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Wed, 23 Jan 2008 15:18:44 +0900
Message-ID: <4796DC44.6010100@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com>	 <4794CB8B.1070600@gmail.com> <4795545E.5010908@gmail.com> <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:22662 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYAWGSv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 01:18:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2397556rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 22:18:50 -0800 (PST)
In-Reply-To: <864c1e490801222034w32cd8799h3600fb902a3d97e6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Thomas Evans wrote:
> On 1/21/08, Tejun Heo <htejun@gmail.com> wrote:
>> Can you install linux on a x86 machine and see whether anything is
>> different?
> 
> Did that today - it mostly works.  There is some sort of conflict with
> the card on the PC I am using.  During POST I sometimes get a "Plug
> and Play configuration error" when the PMP array is plugged into a
> port.
> 
> If I leave it unplugged until I get to GRUB, I can boot and see the
> drives and mount the array.  This is the same card as I have been
> using throughout.
> 
> If I forget and get the "Plug and Play" error, disconnecting the
> drives and resetting isn't enough, nor is power cycling *or*
> unplugging the machine.  I have to physically remove the card and
> restart without it, power down and then re-insert it.  I could only
> plug the card into a 32bit slot, btw.

So, except for BIOS weirdness, it works.

> I have trouble believing that both alpha systems are somehow faulty
> does it happen that BIOSs store away any information about PCI
> devices?

On x86, BIOS runs, on alpha, it doesn't.  It could be that BIOS
configures something.  Can you please post the result of 'lspci
-nnvvvxxx' of the sil24 controller on alpha and x86?

-- 
tejun
