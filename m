From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Mon, 11 May 2009 15:30:12 -0400
Message-ID: <20090511193012.GD21463@csclub.uwaterloo.ca>
References: <200905062009.28087.markos@codex.gr> <4A086A76.3090008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:53182 "EHLO
	caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758088AbZEKTaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 15:30:11 -0400
Content-Disposition: inline
In-Reply-To: <4A086A76.3090008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>

On Mon, May 11, 2009 at 02:12:06PM -0400, Jeff Garzik wrote:
> Konstantinos Margaritis wrote:
>> (not subscribed please CC me)
>>
>> I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found 
>> that it failed to compile -lots of dmi related errors. I found that I 
>> had to include the broken_systems handling code in #ifdef CONFIG_DMI 
>> (DMI is not supported on platforms other than i386/x86_64). 
>>
>> Lennert on #mklinux told me that this commit broke the non-dmi support, 
>> and that a similar patch to mine is used on ARM systems :
>>
>> commit e57db7bde7bff95ae812736ca00c73bd5271455b
>> SATA Sil: Blacklist system that spins off disks during ACPI power off
>>
>> With this patch, sata_sil compiles on ppc (and I guess on other 
>> platforms). I'm using it for a while with no problems with a Delock 
>> 4-port SATA PCI card.
>
> (CC'ing various Lennerts)

I am not a Lennert, I am a Lennart. :)  I didn't do it.

> What is the breakage?
>
> Ideally the DMI subsystem should be provided wrappers for platforms  
> without DMI, rendering patches like this unnecessary.

-- 
Len Sorensen
