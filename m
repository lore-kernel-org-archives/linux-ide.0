From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci_gtf_filter_workaround function breaks current git build
Date: Fri, 09 Oct 2009 13:00:24 +0900
Message-ID: <4ACEB558.8010406@kernel.org>
References: <20091009034147.GA1985@phenom2.trippelsdorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36316 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbZJIEBZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Oct 2009 00:01:25 -0400
In-Reply-To: <20091009034147.GA1985@phenom2.trippelsdorf.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Markus Trippelsdorf wrote:
> ahci: Add ifdef wrapper to ahci_gtf_filter_workaround
> 
> Commit f80ae7e45a0e03da188494c6e947a5c8b0cdfb4a 
> ahci: filter FPDMA non-zero offset enable for Aspire 3810T 
> breaks the current git build for configurations that don't define
> CONFIG_ATA_ACPI.  
> This adds an ifdef wrapper to ahci_gtf_filter_workaround.
> 
> Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thank you.

-- 
tejun
