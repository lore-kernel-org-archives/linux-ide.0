From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/4] libata: clean up the SFF code for coding style
Date: Wed, 22 Oct 2008 17:02:18 +0100
Message-ID: <20081022170218.32122780@lxorguk.ukuu.org.uk>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180903.7781.51521.stgit@localhost.localdomain>
	<874p34ska1.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56759 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753005AbYJVQCW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 12:02:22 -0400
In-Reply-To: <874p34ska1.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> >  		if (ata_is_atapi(qc->tf.protocol) &&
> > -		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
> > +		   !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
> 
> Ditto.

Its lining up the bracketing but hey I'm not fussed, just twiddling where
checkpatch warned and the like.

> > - err_out:
> > +err_out:
> 
> Yes, I've wondered about these myself occasionally. Personally, I don't
> insert a blank before those labels either and would be in favour of such
> a change. But do we actually have a convention regarding this matter?

CodingStyle chapter 7 which is of course overridable by Jeff ;)

Alan
