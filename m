From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Fwd: Various problems with MCP55 since 2.6.37
Date: Mon, 05 Dec 2011 19:26:34 -0600
Message-ID: <4EDD6F4A.8070105@gmail.com>
References: <4EDA163E.2030501@davidkrider.com> <4EDB5FDE.8030709@davidkrider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61377 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780Ab1LFB0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2011 20:26:36 -0500
Received: by ywa9 with SMTP id 9so4888680ywa.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Dec 2011 17:26:36 -0800 (PST)
In-Reply-To: <4EDB5FDE.8030709@davidkrider.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Krider <david@davidkrider.com>
Cc: linux-ide@vger.kernel.org

On 12/04/2011 05:56 AM, David Krider wrote:
> I apologize. I see that I'm conflating issues. I reinstalled Ubuntu
> 10.10, again, which has a 2.6.35 kernel. This fixes the rebooting
> problem, but I still have the ata errors.
>
> I've noticed a couple things.
>
> First, I've never gotten scrambled filesystems since getting rid of
> fakeraid. I'm going to blame that scrambling on that, and forget about it.
>
> Second, I finally notice, in the ata error below, that ata3 can't be my
> SSD. From a message to this list that I just found, I see that it would
> be strongly suspected that I have power problems. I have an 800W power
> supply, so I don't think it's not giving ENOUGH power, but the quality
> might be bad? (I did a lot of damage to an old dual Athlon computer by
> having an underspec'ed PS; I didn't make that mistake on this one.) I've
> installed lm-sensors and will try to track this.
>
> So I just want to dial into the reboot problem, as I reboot into Windows
> (to play games) a lot. That one's pretty clear. If I upgrade to a
> post-2.6.35 kernel, I get the problem, whether I'm using an SSD or a
> regular HDD. Is there anything that can be done?

You can try the kernel parameter "reboot=(reboot mode)" to try and make 
the system reboot in different ways:

    warm   Don't set the cold reboot flag
    cold   Set the cold reboot flag
    bios   Reboot by jumping through the BIOS (only for X86_32)
    smp    Reboot by executing reset on BSP or other CPU (only for X86_32)
    triple Force a triple fault (init)
    kbd    Use the keyboard controller. cold reset (default)
    acpi   Use the RESET_REG in the FADT
    efi    Use efi reset_system runtime service
    pci    Use the so-called "PCI reset register", CF9
    force  Avoid anything that could hang.

If a non-default mode works better, then you should send a report to 
linux-kernel about it. Contrary to the list above, I think acpi is the 
default at this point.
