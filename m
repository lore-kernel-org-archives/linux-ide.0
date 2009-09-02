From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching support
Date: Wed, 2 Sep 2009 09:55:09 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]:56708
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755518AbZIBBzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Sep 2009 21:55:21 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A9D1E2A.9000209@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Tejun,


> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> > 
> > I find that ahci_pmp_detach() will be called for each SATA port
> > during the initialization, right after print:
> >> ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp fbs...
> > 
> > so will ahci_disable_fbs() be called, which leads to the trigger
> > of WARN_ON().
> 
> Ah.. right.  ahci_port_resume() does that to make sure that all PMP
> bits are cleared on init.  Hmmm... probably it would be better to make
> ahci_disable_fbs() to just do it regardless of libata thinks whether
> PMP is attached or not.  After resume from STR, we shouldn't be
> assuming anything about the controller state.


I have added sata_pmp_attached() check for both ahci_enable_fbs()
and ahci_disable_fbs(), because I believe it's necessary.

	if (!pp->fbs_supported || !sata_pmp_attached(ap))
		return;

What do you mean to make it better? How to? I do not catch your
above words very much...


Thanks,
Shane

