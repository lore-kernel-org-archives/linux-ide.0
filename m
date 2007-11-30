From: Tejun Heo <htejun@gmail.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Sat, 01 Dec 2007 08:56:44 +0900
Message-ID: <4750A33C.4080509@gmail.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com> <20071120220512.46b9e975@the-village.bc.nu> <20071126120649.GC4701@ucw.cz> <474CCA82.7030000@gmail.com> <474F3A4B.3080304@cfl.rr.com> <474F530D.8090302@gmail.com> <47505A63.8070507@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:51335 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434AbXK3X5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 18:57:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3040660wah
        for <linux-ide@vger.kernel.org>; Fri, 30 Nov 2007 15:57:04 -0800 (PST)
In-Reply-To: <47505A63.8070507@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Phillip Susi wrote:
> Tejun Heo wrote:
>> Because SFF ATA controller don't have IRQ pending bit.  You don't know
>> whether IRQ is raised or not.  Plus, accessing the status register which
>> clears pending IRQ can be very slow on PATA machines.  It has to go
>> through the PCI and ATA bus and come back.  So, unconditionally trying
>> to clear IRQ by accessing Status can incur noticeable overhead if the
>> IRQ is shared with devices which raise a lot of IRQs.
> 
> There HAS to be a way to determine if that device generated the
> interrupt, or the interrupt can not be shared.  Since the kernel said
> nobody cared about the interrupt, that indicates that the sata driver
> checked the status register and realized the sata chip didn't generate
> the interrupt, and returned to the kernel letting it know that the
> interrupt was not for it.

Surprise, surprise.  There's no way to tell whether the controller
raised interrupt or not if command is not in progress.  As I said
before, there's no IRQ pending bit.  While processing commands, you can
tell by looking at other status registers but when there's nothing in
flight and the controller determines it's a good time to raise a
spurious interrupt, there's no way you can tell.  That dang SFF
interface is like 15+ years old.

But we can still make things pretty robust.  We're working on it.

Thanks.

-- 
tejun
