From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Wed, 02 Sep 2009 10:58:43 +0900
Message-ID: <4A9DD153.5050106@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42520 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbZIBB6t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 21:58:49 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Huang, Shane wrote:
> Hi Tejun,
> 
> 
>> -----Original Message-----
>> From: Tejun Heo [mailto:tj@kernel.org] 
>>> I find that ahci_pmp_detach() will be called for each SATA port
>>> during the initialization, right after print:
>>>> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs...
>>> so will ahci_disable_fbs() be called, which leads to the trigger
>>> of WARN_ON().
>> Ah.. right.  ahci_port_resume() does that to make sure that all PMP
>> bits are cleared on init.  Hmmm... probably it would be better to make
>> ahci_disable_fbs() to just do it regardless of libata thinks whether
>> PMP is attached or not.  After resume from STR, we shouldn't be
>> assuming anything about the controller state.
> 
> 
> I have added sata_pmp_attached() check for both ahci_enable_fbs()
> and ahci_disable_fbs(), because I believe it's necessary.
> 
> 	if (!pp->fbs_supported || !sata_pmp_attached(ap))
> 		return;
> 
> What do you mean to make it better? How to? I do not catch your
> above words very much...

I meant that sata_pmp_attached() is a driver state and might not match
the controller state after resume which is why the ahci driver calls
detach in the first place regardless of sata_pmp_attached(), so it
might be better to check the register directly and set or clear it
regardless of sata_pmp_attached().

Thanks.

-- 
tejun
