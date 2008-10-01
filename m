From: Tejun Heo <htejun@gmail.com>
Subject: Re: What's the SB600 64-bit DMA problem?
Date: Wed, 01 Oct 2008 12:57:46 +0900
Message-ID: <48E2F53A.6000104@gmail.com>
References: <20080920151712.10515.qmail@science.horizon.com> <da824cf30809201528o27478ae2h5894e39932622d3b@mail.gmail.com> <20080921001529.23400.qmail@science.horizon.com> <65a6ef750809231730h52f6bf47g23b33db1d2f4ca08@mail.gmail.com> <48DA0C8B.3000406@gmail.com> <B90463BC30D2E446BA423D888DC85E50C8358F@sshaexmb1.amd.com> <20080925032437.6802.qmail@science.horizon.com> <48DCEC6D.1040305@gmail.com> <20080928210422.2578.qmail@science.horizon.com> <48E0112C.7010901@gmail.com> <20080929040812.8784.qmail@science.horizon.com> <48E058D2.7050704@gmail.com> <20080930020002.26564.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:40571 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYJAD7Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Sep 2008 23:59:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so113766tic.23
        for <linux-ide@vger.kernel.org>; Tue, 30 Sep 2008 20:59:23 -0700 (PDT)
In-Reply-To: <20080930020002.26564.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: Shane.Huang@amd.com, mdnelson8@gmail.com, linux-ide@vger.kernel.org, jgarzik@redhat.com, grundler@google.com

George Spelvin wrote:
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> George Spelvin wrote:
>>> ATM I'm just recompiling the kernel from -rc6 to -rc7.
>>>
>>> It's in single-user mode so I can't ssh over the boot messages, but
>>> they definitely included "64bit" from ahci_print_info().
>> Thanks for verifying.  I would love to lift the 32 restriction from
>> SB600 but it's been quite a rocky ride and I still can't tell what's
>> the determining factor.  :-(
> 
> H'm.... 64-bit support comes through in multiple places.
> I wonder if it's just one of them?
> - HBA memory-mapped registers (which are in fact limited to 32 bits)

This is determined by the BIOS and I don't think it ever puts it over
32bit boundary.

> - Port x command list base address
> - Port x FIS base address
> - Command table base address (command header, offset 8)
> - Data base address (physical region descriptor, offset 0)

The first three are controlled by consistent_dma_mask while the last
one is controlled by dma_mask, so maybe setting only
consistent_dma_mask to 32bit could help.  The problem is how to verify
them.  You'll need to dig the list and bugzilla to look for reporters
who reported failure on 64bit DMA and verify it actually fixes the
problem.  It can be tricky as the problem doesn't seem to appear for
all users.

> What we really care about is that the data physical regions can
> be anywhere in 64-bit space.  If any of the others were limited to
> 32 bits, that would only be slightly annoying.
> 
> But...
> The base addresses are already above 4G.  Aobve 8G, actually.
> 
> Port 0 base addresses: 02 1f1e 0000, 02 1f1e 0400
> Port 1 base addresses: 02 1f1a 0000, 02 1f1a 0400
> Port 2 base addresses: 02 1f98 0000, 02 1f98 0400
> Port 3 base addresses: 02 1f9e 0000, 02 1f9e 0400

Where are these numbers from?

-- 
tejun
