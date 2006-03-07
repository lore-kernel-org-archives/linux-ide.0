From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: libata: why do we need to define ATA_ENABLE_PATA instead of a CONFIG option?
Date: Mon, 6 Mar 2006 22:00:01 -0800
Message-ID: <20060307060001.GA4629@localhost.localdomain>
References: <20060307010444.GA6799@localhost.localdomain> <440D17C2.60200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.siteground.net ([207.218.208.2]:48874 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751278AbWCGF7X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Mar 2006 00:59:23 -0500
Content-Disposition: inline
In-Reply-To: <440D17C2.60200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 07, 2006 at 12:18:58AM -0500, Jeff Garzik wrote:
> Ravikiran G Thirumalai wrote:
> >Currently, we can use the piix ide driver for Intel ICH5 IDE controllers, 
> >or
> >use ata_piix (libata) by #defining ATA_ENABLE_PATA manually at
> >inclulde/linux/libata.h.  Why not have a CONFIG option to enable libata 
> >for such
> >drivers instead of a #define in the code? I was wondering if there is any
> >reason it is done this way.
> 
> ATA_ENABLE_PATA is there because PATA was highly experimental for a 
> while, and only developers and power users should be enabling it.

Is ata_piix still considered higly experimental? Its been around for
sometime I guess. Would this be time for a CONFIG option (atleast with
'experimental')?

Thanks,
Kiran
