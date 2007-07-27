From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with nVidia nForce 520 Chipset
Date: Fri, 27 Jul 2007 13:14:54 +0900
Message-ID: <46A9713E.10304@gmail.com>
References: <5970.47045.qm@web58101.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:20775 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXG0EO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 00:14:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so75005rvb
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 21:14:59 -0700 (PDT)
In-Reply-To: <5970.47045.qm@web58101.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: linux-ide@vger.kernel.org

Craig Block wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
>> Craig Block wrote:
>>> I'm having a problem getting Linux to handle the SATA drives and
>>> controllers on a new computer with an ASUS M2N-X motherboard.  This is a 
>>> socket AM2 board and has an nVidia nForce 520 chipset.
>> Does 'noapic' kernel parameter help?
> 
> Unfortunately, no.  I also tried noapic with nolapic, nomsi, and pci=nobios.  
> 
> I believe it boils down to the following line I'm seeing in the dmesg output;  
> 
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)

Which is most likely caused by IRQ misrouting as indicated by the APIC
error.  I suggest you to post a new message to LKML with title "IRQ
delivery problem on nForce520" and cc linux-ide.  That should attract
the attention of the right people.

Thanks.

-- 
tejun
