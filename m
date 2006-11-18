From: Jeff Garzik <jeff@garzik.org>
Subject: Re: possibility to merge via_pata fixes to .19 stable series?
Date: Sat, 18 Nov 2006 16:20:12 -0500
Message-ID: <455F790C.2030509@garzik.org>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49598 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752385AbWKRVUW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Nov 2006 16:20:22 -0500
In-Reply-To: <20061118002357.564dbb9d.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Tobias Powalowski <t.powa@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Andrew Morton wrote:
> On Sat, 18 Nov 2006 07:59:27 +0100
> Tobias Powalowski <t.powa@gmx.de> wrote:
> 
>> the latest .19rc6 still didn't inlcude your 2 patches for via_pata patches 
>> from -mm kernel.
>> They are at least needed for my pc to boot fine, so i guess others would be 
>> also happy if those were upstream applied, else i have to patch our final 
>> kernel then.
> 
> If you check the full changelog
> (ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/via-pata-controller-xfer-fixes.patch)
> you'll see that Jeff had issues with the patch.
> 
> I don't know if they're still concerns, nor if they're fatal concerns
> either.  But I've been sitting on that patch for nearly five months.

This isn't driver-specific, so a similar change should be applied to the 
core.

	Jeff


