From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: SII 3512 SATA Progress but help still needed
Date: Mon, 8 Dec 2003 21:26:32 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312082126.32948.bzolnier@elka.pw.edu.pl>
References: <3FCF9B07.5020509@atl.lmco.com> <3FD4D88A.3050708@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11715 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261776AbTLHUYi
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2003 15:24:38 -0500
In-Reply-To: <3FD4D88A.3050708@atl.lmco.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Aron Rubin <arubin@atl.lmco.com>
Cc: linux-ide@vger.kernel.org


I don't know. ;-)

I have only one idea right now - look what drivers/scsi/libata.c
does for SATA controllers during init and what drivers/ide/ doesn't.

I am talking about sata_phy_reset() in libata.c.

--bart

On Monday 08 of December 2003 21:01, Aron Rubin wrote:
> And by "help" I meant in the form of meaningful conversation on the
> subject. Could someone reply with a "I don't know" or "I will not talk
> with the likes of you" so I know my messages are not bing accidentally
> routed into the vacuum of space.
>
> Thank you,
> Aron
>
> Aron Rubin wrote:
> > I have made much progress with the latest patches, I am able to boot
> > now. Please help me with the rest. The system is still constantly timing
> > out. See attachments below.
> >
> > Aron Rubin wrote:
> >  > SATA controller SII 3512 not recognized by driver. It looks like SII
> >  > 3512 is almost identical to 3112 interface. I copy/paste/alterred all
> >  > code in ide/pci/siimage.[ch] with "3112" in it to "3512". It seems
> >  > about 95% functional. Need help with remaining 5%, related to very,
> >  > very, slow controller comms during init with occational "Interrupt
> >  > Lost" messages. Seems like comms are out of sync and then resync over
> >  > and over. Other than that all drive info comes over.

