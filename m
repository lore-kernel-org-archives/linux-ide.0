From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Tue, 01 Sep 2009 22:14:18 +0900
Message-ID: <4A9D1E2A.9000209@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40289 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbZIANO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 09:14:26 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Huang, Shane wrote:
> Quoting myself:
>> static void ahci_disable_fbs(struct ata_port *ap)
>> {
>> 	struct ahci_port_priv *pp = ap->private_data;
>> 	void __iomem *port_mmio = ahci_port_base(ap);
>> 	u32 fbs;
>> 	int rc;
>>
>> 	if (!pp->fbs_supported)
>> 		return;
>>
>> 	WARN_ON(!pp->fbs_enabled);
>>
>> 	rc = ahci_stop_engine(ap);
> 
> I find that ahci_pmp_detach() will be called for each SATA port
> during the initialization, right after print:
>> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs...
> 
> so will ahci_disable_fbs() be called, which leads to the trigger
> of WARN_ON().

Ah.. right.  ahci_port_resume() does that to make sure that all PMP
bits are cleared on init.  Hmmm... probably it would be better to make
ahci_disable_fbs() to just do it regardless of libata thinks whether
PMP is attached or not.  After resume from STR, we shouldn't be
assuming anything about the controller state.

Thanks.

-- 
tejun
