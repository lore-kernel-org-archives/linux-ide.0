From: Tejun Heo <htejun@gmail.com>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Wed, 25 Apr 2007 13:01:02 +0900
Message-ID: <462ED27E.6070600@gmail.com>
References: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:24964 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161579AbXDYECB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 00:02:01 -0400
Received: by nz-out-0506.google.com with SMTP id o1so109272nzf
        for <linux-ide@vger.kernel.org>; Tue, 24 Apr 2007 21:02:01 -0700 (PDT)
In-Reply-To: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sjackerman@comcast.net
Cc: linux-ide@vger.kernel.org

sjackerman@comcast.net wrote:
> Hello-
> 
> We manufacture a SATA to CF adaptor that uses an Acard Technology
> ARC-770 SATA to IDE bridge chip:
> 
> http://www.acscontrol.com/Index_ACS.asp?Page=/Pages/Products/CompactFlash/SATA_To_CF_Adapter.htm
> 
> 
> The adaptor works correctly and can be 'seen' in the BIOS, in DOS, in
> Windows XP, XP MCE and Vista. However the adaptor doesn't work
> correctly or can't be 'seen' in Linux. A similiar adaptor based upon
> a Marvell bridge chip works correctly in Linux.
> 
> We have now verified that this doesn't work on an in-house Intel 865
> chipset motherboard running RIP Linux v2.6.20. A customer has
> verified that this also doesn't work on Intel 875 or Via chipset
> motherboards under Linux.
> 
> Here are the Linux Kernel error messages that are produced by this
> kernel running on a Intel D865GLC motherboard trying to talk to our
> ARC-770 based adaptor on SATA-0 :
> 
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10 
> scsi2 : ata_piix ata1.00: CFA, max PIO4, 8005536 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 0 ata1.00: qc timeout (cmd 0xef) 
> ata1.00: failed to set xfermode (err_mask=0x4)

Can you give a shot at 2.6.21-rc7.  The problem should have been fixed
there.

-- 
tejun
