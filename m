From: Andy Warner <andyw@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 08:59:34 -0600
Message-ID: <20050217085934.M10699@florence.linkmargin.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:31407 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262255AbVBQO7t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 09:59:49 -0500
Content-Disposition: inline
In-Reply-To: <421426DB.2000308@pobox.com>; from jgarzik@pobox.com on Thu, Feb 17, 2005 at 12:08:43AM -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> I'm starting to wonder if polling isn't just a dismal failure on SATA, 
> since the status register/etc. is all emulated.  Thinking further along 
> those lines (how an ATA shadow register set is faked by the host 
> controller using FIS data), I wonder if polling -- per ATA spec -- 
> exposes a race between FIS reception and processing, and the update of 
> the ATA shadow register block.

Quite possibly - though the register set has been fake one way or
another most of the time. This time it's a different fake, with two
vendors getting to put the bits back together in a different order
instead of one vendor's firmware team. The second generation
controllers mostly seem to support/require using DMA to accomplish
the operations named "PIO *" in the ATA/ATAPI spec. This will be
a good thing(tm). I'm still trying to wrap my brain around what
(if any) changes this will impose on libata - my hunch is that
we will require a set of pio_xxx methods in ata_port_operations
with suitable defaults that fall back to the tf_load/tf_read
methods currently specified.

Obviously, there will still be millions of first generation
SATA controllers roaming the earth, and for stuff like SMART
we need to make it play nicely with the other children. Damn.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
