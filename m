From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 16:54:03 +0100
Message-ID: <1155225243.24077.1.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
	 <1155213464.22922.6.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de>
	 <1155219292.22922.13.camel@localhost.localdomain>
	 <20060810135945.GV11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56759 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161356AbWHJPeR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 11:34:17 -0400
In-Reply-To: <20060810135945.GV11829@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-10 am 15:59 +0200, ysgrifennodd Jens Axboe:
> On Thu, Aug 10 2006, Alan Cox wrote:
> HPA mishandling is a given, I agree that is a nasty problem and really
> should be fixed. hangs on resume - the hardware, or the kernel talking

Hang on resume because we don't do the mode setup right from s2ram.
Being worked on by someone at last which is great

> to it? crc errors sounds like bad transfer tuning after resume, but that
> should be pretty identical to the on-boot one.

I *think* this is that the PLLs need resynchronizing after resume from
ram and we don't do that for some chips


