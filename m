From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Mon, 24 Nov 2008 14:57:47 +0900
Message-ID: <1227506267.25499.22.camel@localhost.localdomain>
References: <4928E010.4090801@kernel.org> <4929023C.2060302@suse.de>
	 <49290CEB.7070509@suse.de>
	 <7fe698080811232140ie896cc8m735a25261f447c47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:53934 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbYKXF54 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 00:57:56 -0500
In-Reply-To: <7fe698080811232140ie896cc8m735a25261f447c47@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dongjun Shin <djshin90@gmail.com>
Cc: Tejun Heo <teheo@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, chris.mason@oracle.com, Matthew Wilcox <matthew@wil.cx>

On Mon, 2008-11-24 at 14:40 +0900, Dongjun Shin wrote:
> On Sun, Nov 23, 2008 at 4:57 PM, Tejun Heo <teheo@suse.de> wrote:
> > Tejun Heo wrote:
> >> Dongjun, the only doc I can find about ATA TRIM is the following one.
> >>
> >>  http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf
> >>
> >> And AFAICS this hasn't made into ACS yet.  Is this what you guys are
> >> gonna implement and Windows7 is gonna use?
> >
> 
> Sorry, I thought the trim spec has got into the final ACS, but it's not yet.
> Microsoft can collaborate with SSD vendors for their internal evaluation &
> feedback for Win7(with NDA between them, of course).

Actually so can we assuming the developers are willing.  If we have to
sign an NDA to work with them, the Linux Foundation can stand as
corporate guarantor for it:

http://www.linuxfoundation.org/en/NDA_program

It's crafted to allow development of open source drivers.  It still
requires individual developers to sign an NDA agreement with the LF (and
the LF then does a corporate one with the companies involved).

James


