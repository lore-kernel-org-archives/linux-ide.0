From: Andy Warner <andyw@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 13:25:00 -0600
Message-ID: <20050217132500.N10699@florence.linkmargin.com>
References: <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <4213CD9E.9040703@pobox.com> <20050216174954.K10699@florence.linkmargin.com> <4213DE38.70309@pobox.com> <20050216182040.L10699@florence.linkmargin.com> <421426DB.2000308@pobox.com> <20050217085934.M10699@florence.linkmargin.com> <4214ECE9.7070502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:25742 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262370AbVBQTZI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Feb 2005 14:25:08 -0500
Content-Disposition: inline
In-Reply-To: <4214ECE9.7070502@pobox.com>; from jgarzik@pobox.com on Thu, Feb 17, 2005 at 02:13:45PM -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> AHCI is the first scenario where PIO-via-DMA could be utilized in an 
> efficient manner.  The upcoming SiI 3124 is another.  A few others 
> (ADMA, Marvell) are PIO-via-DMA controllers as well.  I agree this is a 
> good thing.

I _think_ the SATA-II stuff from Promise (20579) does this too.

> Anyway, getting back to the thread of "problems with PIO polling", I am 
> wondering if -- due to SATA's nature -- PIO polling should be avoided, 
> and interrupt-driven methodology used instead.
> 
> One reason why PIO polling was chosen (for controllers that support it; 
> AHCI does not) is that the entire command submission/processing code can 
> be written inline:  just submit-command, wait-for-busy-clear, etc. 
> Makes the code less complex.

I think going interrupt driven would be a good idea. Of course
when I tried it one chip didn't serve up the interrupt as expected
(can't remember is it was the 3114 or the 20319 - would have to
check my notes.) I don't think it is massively more complex than
what we currently have, and quite possibly might be simpler.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
