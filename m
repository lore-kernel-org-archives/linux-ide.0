From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: kill spurious NCQ completion
 detection
Date: Fri, 07 Dec 2007 15:29:33 -0500
Message-ID: <4759AD2D.60903@garzik.org>
References: <4758C20F.8020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57767 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682AbXLGU3m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Dec 2007 15:29:42 -0500
In-Reply-To: <4758C20F.8020005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, albertl@mail.com, diego torres <dtorres@coral.dnsalias.org>, Michael Tokarev <mjt@tls.msk.ru>

Tejun Heo wrote:
> Spurious NCQ completion detection implemented in ahci was incorrect.
> On AHCI receving and processing FISes and raising interrupts are not
> interlocked and spurious interrupts are expected.
> 
> For example, if an interrupt occurs while interrupt handler is running
> and the running interrupt handler handles the event the new IRQ
> indicated, after IRQ handler finishes, it will be executed again
> because IRQ pending bit is set by the new interrupt but there won't be
> anything to process.
> 
> Please read the following message for more information.
> 
>   http://article.gmane.org/gmane.linux.ide/26012
> 
> This patch...
> 
> * Removes all spurious IRQ whining from ahci.  Spurious NCQ completion
>   detection was completely wrong.  Spurious D2H Register FIS taught us
>   that some early drives send spurious D2H Register FIS with I bit set
>   while NCQ commands are in progress but none of recent drives does
>   that and even the ones which show such behavior can do NCQ fine.
> 
> * Kills all NCQ blacklist entries which were added because of spurious
>   NCQ completions.  I tracked down each commit and verified all
>   removed ones are actually added because of spurious completions.
> 
>   WD740ADFD-00NLR1 wasn't deleted but moved upward because the drive
>   not only had spurious NCQ completions but also is slow on sequential
>   data transfers if NCQ is enabled.
> 
>   Maxtor 7V300F0 was added by 0e3dbc01d53940fe10e5a5cfec15ede3e929c918
>   from Alan Cox.  I can only find evidences that the drive only had
>   troubles with spuruious completions by searching the mailing list.
>   This entry needs to be verified and removed if it doesn't have other
>   NCQ related problems.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> Alan, can you please check why 7V300F0 was added?  Thanks a lot.
> 
>  drivers/ata/ahci.c        |   74 +---------------------------------------------
>  drivers/ata/libata-core.c |   18 -----------
>  2 files changed, 4 insertions(+), 88 deletions(-)

applied


