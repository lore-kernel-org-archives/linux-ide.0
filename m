From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 02/15] libata: Add host lock to struct ata_port
Date: Thu, 09 Feb 2006 02:17:31 -0500
Message-ID: <43EAEC8B.2060003@pobox.com>
References: <200602061542.k16FgROF014749@d01av03.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:55961 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422856AbWBIHRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 02:17:34 -0500
In-Reply-To: <200602061542.k16FgROF014749@d01av03.pok.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

brking@us.ibm.com wrote:
> Prepare for changes required to support SATA devices
> attached to SAS HBAs. For these devices we don't want to
> use host_set at all, since libata will not be the owner
> of struct scsi_host.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>

Please move this as far back in the patch series as possible.  The 
simple stuff -- moving code into static functions for later use, for 
example -- should come first.

While you're ginning up the resend, I'll be pondering this and the 
latter portion of your patch series.  This seems like a sane way to go, 
but I want to think a bit more on the overall direction.

	Jeff



