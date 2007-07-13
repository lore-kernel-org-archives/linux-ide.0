From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 40-wire/80-wire detection
Date: Fri, 13 Jul 2007 23:39:42 +0200
Message-ID: <200707132339.42299.bzolnier@gmail.com>
References: <166657.81677.qm@web58101.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458AbXGMVbN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647448ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:12 -0700 (PDT)
In-Reply-To: <166657.81677.qm@web58101.mail.re3.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: Stephen.Clark@seclark.us, Jeff Garzik <jeff@garzik.org>, Matt Sealey <matt@genesi-usa.com>, linux-ide@vger.kernel.org


Hi,

On Friday 13 July 2007, Craig Block wrote:
> > >>Craig Block wrote:
> > >>
> > >>I'm having a problem with the 80-wire/40-wire cable detection
> 
> > Jeff Garzik wrote:
> > >
> > >If you signal a 40-wire cable too fast, you get trouble with a
> > >capital T.
> 
> Thanks everyone for graciously replying to my negative email.  I was
> pretty irritated when I found I could not disable the downgrade.  
> 
> That's fine if the driver nags about the cable, but it should up to the
> user to deal with it.  And, like any nag, it should be possible to shut
> if off.

"idex=ata66" parameter used to only override host side cable detection
but to be able to deal with short 40-wire cables it now also overrides
device side cable detection (patches were merged in Linus' tree,
2.6.23-rc1 will have them).

> As it stands, I will have to run these drives at ATA33.  My only
> recourse is to hack the driver and disable the check.  With *me*
> hacking on the code, I really run the risk of damaging my data.
> 
> Patches anyone?

Please send the output of hdparm --Istdout for this drive.

"idex=ata66" or CONFIG_IDEDMA_IVB=y should also help but we really would
like to detect and workaround such issues automatically, without the need
for user headaches. ;)

Thanks,
Bart
