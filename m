From: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: Time spent waiting for uncorrectable errors
Date: Thu, 19 Feb 2004 16:13:18 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402191613.18342.hpj@urpla.net>
References: <20040216082157.GK57556@vivien.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.176]:20954 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267318AbUBSPN3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 10:13:29 -0500
In-Reply-To: <20040216082157.GK57556@vivien.franken.de>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alex Goller <alex@vivien.franken.de>, linux-ide@vger.kernel.org

On Monday 16 February 2004 09:21, Alex Goller wrote:
> Hi,
>
> is there any data regarding how long current disks try to read a
> sector before quitting with an uncorrectable error? The problem is,
> that i have no reliable way to reproduce the error, i will try to
> read from a hopefully (!) broken disk this afternoon and try to
> measure the time spent for that.

IIRC, the kernel tries to read a defect block exactly 8 times.

The problem is (according to some Maxtor guy), a drive, that returns
a hard sector error has tried to read it internally a few tausand
times (~2650), which results in about 21200 physical retries.

Unfortunately this renders an unpatched linux kernel useless for data 
recovery tasks. Well, not useless in general, but you simply need a 
_lot_ of patience.

Last time I've done it myself, it took about 40 hours to copy a 
defective 80 GB HD with dd_rescue. Fortunately, the damage was in
some mpeg2 streams, which is quite robust in handling long runs of
zeros ;-)..

Pete

