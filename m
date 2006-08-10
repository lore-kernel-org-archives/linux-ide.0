From: Jens Axboe <axboe@suse.de>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 15:59:46 +0200
Message-ID: <20060810135945.GV11829@suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain> <p733bc5nm5g.fsf@verdi.suse.de> <1155213464.22922.6.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <1155219292.22922.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:11785 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161273AbWHJN62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 09:58:28 -0400
Content-Disposition: inline
In-Reply-To: <1155219292.22922.13.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Aug 10 2006, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 14:20 +0200, ysgrifennodd Jens Axboe:
> > You make it sound much worse than it is. Apart for HPA, I'm not aware of
> > any setups that require extra treatment. And the amount of reported bugs
> > against it are pretty close to zero :-)
> 
> There are several variants where you get

Not very vocal users then, or I missed them.

> 	- hangs on resume
> 	- HPA mishandling
> 	- CRC errors and usually eventually a hang

HPA mishandling is a given, I agree that is a nasty problem and really
should be fixed. hangs on resume - the hardware, or the kernel talking
to it? crc errors sounds like bad transfer tuning after resume, but that
should be pretty identical to the on-boot one.

The low level drivers/ide drivers aren't well geared for suspend/resume,
perhaps that is what is causing most of these issues (apart from hpa).

-- 
Jens Axboe

