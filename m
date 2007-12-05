From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Wed, 05 Dec 2007 23:33:55 +0900
Message-ID: <4756B6D3.9020307@gmail.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com> <475032AF.6090001@verizonbusiness.com> <4754C15C.1020107@gmail.com> <4756B5B2.1010302@verizonbusiness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:23692 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXLEOeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 09:34:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3643354rvb
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 06:34:01 -0800 (PST)
In-Reply-To: <4756B5B2.1010302@verizonbusiness.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mark.paulus@verizonbusiness.com
Cc: linux-ide@vger.kernel.org

Mark Paulus wrote:
> Well, I feel foolish. 
> One problem is that the prebuilt kernel is using an initrd
> image, so I made your patch changes, and put them into
> /lib/modules/`uname -r`/kernel/drivers/ata/sata_sil.ko,
> and guess what, they never got loaded.  Foolishness on my
> part.
> 
> Anyway, this time I got to the single boot prompt, where I did
> a 'rmmod sata_sil', and a 'modprobe sata_sil', and I know
> it loaded the new version, because you can see the 'sata_sil
> 0000:02:0b.0: version 2.2b', which I put in
> to verify what the heck is going on.
> This machine is pretty slow to compile the kernel, which is
> why I was trying to short cut the build/install some, but I might try to
> build the kernel on a faster machine and see if
> I can get the initrd image rebuilt also.

This one is good enough, thanks.  It seems the controller is raising
spurious SATA_IRQ.  I wonder why.  You're using a SATA-PATA bridge,
right?  What chip are you using?

-- 
tejun
