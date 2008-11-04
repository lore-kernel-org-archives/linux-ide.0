From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes UPDATED] sata_nv: fix generic, nf2/3 detection
 regression
Date: Tue, 04 Nov 2008 01:10:43 -0500
Message-ID: <490FE763.1060704@garzik.org>
References: <490E6C83.3010309@kernel.org> <490E720D.7070101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45540 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbYKDGKw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:10:52 -0500
In-Reply-To: <490E720D.7070101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, stable@kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> All three flavors of sata_nv's are different in how their hardreset
> behaves.
> 
> * generic: Hardreset is not reliable.  Link often doesn't come online
>   after hardreset.
> 
> * nf2/3: A little bit better - link comes online with longer debounce
>   timing.  However, nf2/3 can't reliable wait for the first D2H
>   Register FIS, so it can't wait for device readiness or classify the
>   device after hardreset.  Follow-up SRST required.
> 
> * ck804: Hardreset finally works.
> 
> The core layer change to prefer hardreset and follow up changes
> exposed the above issues and caused various detection regressions for
> all three flavors.  This patch, hopefully, fixes all the known issues
> and should make sata_nv error handling more reliable.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Forgot to update comment for longer debounce timing required for
> nf2/3.  Commit message and comment updated.
> 
>  drivers/ata/sata_nv.c |   53 +++++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)

applied


