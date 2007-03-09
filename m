From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: [patch 29/30] sata_nv: don't read shadow registers when in ADMA mode
Date: Fri, 9 Mar 2007 15:39:43 +0000
Message-ID: <200703091539.43562.s0348365@sms.ed.ac.uk>
References: <200703061038.l26AcD3M019553@shell0.pdx.osdl.net> <45F154A8.1050606@garzik.org> <45F16EE3.40602@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:1793 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030493AbXCIPjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 10:39:52 -0500
In-Reply-To: <45F16EE3.40602@shaw.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, linux-ide@vger.kernel.org

On Friday 09 March 2007 14:27, you wrote:
> Jeff Garzik wrote:
> > akpm@linux-foundation.org wrote:
> >> From: Robert Hancock <hancockr@shaw.ca>
> >>
> >> Reading from the ATA shadow registers while we are in ADMA mode may
> >> cause undefined behavior.  Don't read the ATA status register when
> >> completing commands for this reason, it shouldn't be needed as the
> >> controller will notify us if the command failed.  Also, don't allow
> >> commands with result taskfile requested to execute in ADMA mode, since
> >> that requires accessing the shadow registers.  We also still need to
> >> override tf_read since libata
> >> will read the result taskfile on a command failure, and we need to go
> >> into
> >> port register mode before allowing this.
> >>
> >> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> >> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> ---
> >>
> >>  drivers/ata/sata_nv.c |   33 ++++++++++++++++++++-------------
> >>  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > Robert, do you think this should be pushed into #upstream-fixes
> > (2.6.21-rc)?
> >
> > I lean towards "yes", since it is a needed-by-hardware fix, but I also
> > am interested in testing feedback since it is so late in the 2.6.21-rc
> > game.
>
> I would lean toward that as well, but it would be good to get some
> testing from some sata_nv ADMA users to make sure it doesn't do anything
> funny for them..

Since I've been a bit of a problem case this time, I'd be happy to test it.

Can I assume that I can apply the patch you sent to Jeff "[PATCH] sata_nv: 
revert use of notifiers for now", and apply this one, to -rc3, and then be 
able to usefully test?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
