From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Tue, 23 Jun 2009 17:30:43 -0400
Message-ID: <4A414983.3020604@garzik.org>
References: <20090623060600.GA9603@havoc.gtf.org>	<20090622233157.fe0e0e2c.akpm@linux-foundation.org>	<20090623213743.2f1dfe5d@realm>	<4A411810.6070308@garzik.org> <20090623234214.1b3018fd@realm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50913 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986AbZFWVaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 17:30:11 -0400
In-Reply-To: <20090623234214.1b3018fd@realm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-ide@vger.kernel.org, Sergey Lapin <slapin@ossfans.org>, Andrew Victor <avictor.za@gmail.com>

Sergey Matyukevich wrote:
> On Tue, 23 Jun 2009 13:59:44 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Sergey Matyukevich wrote:
>>> Could you tell me where to send update for pata_at91 driver modified
>>> according to Andrew's remarks ? To Jeff ? 
>> Me and linux-ide...
>>
>> 	Jeff
>>
>>
> 
> 
> Jeff,
> Here is updated pata_at91 driver according to comments by Andrew Morton.
> 
> 
> 
> This patch provides PATA driver for CompactFlash interface in True IDE
> mode on AT91SAM9260 SoC.
> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  drivers/ata/Kconfig     |    8 +
>  drivers/ata/Makefile    |    1 +
>  drivers/ata/pata_at91.c |  367 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 376 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_at91.c

Once I (or someone else, in the case of another driver) merges a driver, 
you will want to send a diff against that merged version.  In this case, 
the driver is upstream as of an hour or two ago, so you'll want to diff 
against that.

Note that little details like email subject line matter, because they 
are copied into the kernel changelog by default, when merging patches. 
See Documentation/SubmittingPatches for a list of details.

	Jeff




