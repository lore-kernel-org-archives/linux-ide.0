From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] ahci: fix SB600 h/w errata issue
Date: Wed, 05 Mar 2008 07:49:03 -0500
Message-ID: <47CE96BF.50108@garzik.org>
References: <20080228204348.GA30539@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60133 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761049AbYCEMtF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Mar 2008 07:49:05 -0500
In-Reply-To: <20080228204348.GA30539@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, crane.cai@amd.com, Henry.Su@amd.com, shane.huang@amd.com
Cc: LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> I haven't seen anyone work on the recent SB600 errata, where the
> hardware does not like 256-length PRD entries.
> 
> Is this correct, AMD folks?
> 
> It hurts performance on SB600, but it is more important to get a
> correct patch eliminating the data corruption/lockups, and then later
> on tune for performance.
> 
> We simply limit each command to a maximum of 255 sectors, on SB600.
> 
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> ---
>  drivers/ata/ahci.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Based on Henry's response, I'm going to assume AMD approves of this patch...


