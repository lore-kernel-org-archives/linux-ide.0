From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with nVidia nForce 520 Chipset
Date: Thu, 26 Jul 2007 17:26:56 +0900
Message-ID: <46A85AD0.2070905@gmail.com>
References: <815613.39679.qm@web58103.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:46627 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbXGZI2L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 04:28:11 -0400
Received: by nz-out-0506.google.com with SMTP id s18so408530nze
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 01:28:10 -0700 (PDT)
In-Reply-To: <815613.39679.qm@web58103.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: linux-ide@vger.kernel.org

Craig Block wrote:
> Hello,
> 
> I'm having a problem getting Linux to handle the SATA drives and controllers on
> a new computer with an ASUS M2N-X motherboard.  This is a socket AM2 board and
> has an nVidia nForce 520 chipset.  It has three controller mode settings in the
> BIOS, SATA, AHCI, and RAID.
> 
> I built and tried a couple kernels, one with SATA_NV plus BLK_DEV_IDECD and the
> other with SATA_AHCI plus PATA_AMD.
> 
> With the controllers in SATA mode, the kernel built with SATA_NV doesn't see
> the SATA controllers at all.  The PATA CD drive links to hda and works
> properly.  I tried the same kernel on an nForce 4 system and everything works
> right.
>  
> With the controllers in AHCI mode, the kernel built with SATA_AHCI, hangs when
> probing the SATA controllers.  It literally takes about a minute to get through
> each one.  It never does link any drives to them.  The PATA CD drive links to
> sr0 and seems to work okay.
> 
> I've had MS Windows working without issue in either mode, using the canned IDE
> driver in SATA mode and the nVidia AHCI driver in AHCI mode.
> 
> Output from "dmesg" and "lspci -n -vvv" commands is attached.

Does 'noapic' kernel parameter help?

-- 
tejun
