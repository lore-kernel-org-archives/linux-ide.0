From: Adrian Bunk <bunk@stusta.de>
Subject: /dev/sd*
Date: Wed, 9 Aug 2006 23:21:24 +0200
Message-ID: <20060809212124.GC3691@stusta.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60689 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751383AbWHIVV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 17:21:28 -0400
Content-Disposition: inline
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Aug 09, 2006 at 06:29:59PM +0100, Alan Cox wrote:
>...
> - Drives appear as /dev/sda /dev/sr0 etc along with the libata SATA
> devices (and since you can't tell SATA from PATA at times its hard to
> avoid). That means people with some older distros wanting to try it
> might need to change their fstab or rootdev. People not trying it won't
> be affected.
>...

It might be a bit out of the scope of this thread, but why do some many 
subsystems use the /dev/sd* namespace?

Real SCSI devices use it.
The USB mass storage driver uses it.
libata uses it.

I'd expext SATA or PATA devices at /dev/hd* or perhaps at /dev/ata* - 
but why are they at /dev/sd*?

> Alan

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

