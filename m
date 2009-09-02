From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Wed, 02 Sep 2009 15:49:06 +0900
Message-ID: <4A9E1562.1050208@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop> <4A9B8368.1080807@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9776@sshaexmb1.amd.com> <4A9D1387.6040709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC9789@sshaexmb1.amd.com> <4A9D1E2A.9000209@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC984D@sshaexmb1.amd.com> <4A9DD153.5050106@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC988D@sshaexmb1.amd.com> <4A9DDB28.7070709@kernel.org> <C8E4BD7D001E44499280E0884BD9DB30FC99B7@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43336 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbZIBGtM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Sep 2009 02:49:12 -0400
In-Reply-To: <C8E4BD7D001E44499280E0884BD9DB30FC99B7@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Huang, Shane wrote:
> Yes, it can leave pp->fbs_enabled out of sync, but just removing the
> check and setting the bit anyway will still lead to the print of this
> message for each SATA port:
> ahci 0000:00:11.0: FBS is disabled.
> 
> So I would suggest to keep the check and also add the sync of
> pp->fbs_enabled, which can also save the restart of DMA engine:

Yeap, sure.  But in general, it doesn't really matter whether the DMA
engine is started or restarted a few times during intialization.  Just
do whatever is safe and looks clean.

Thanks.

-- 
tejun
