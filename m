From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE CDROM - No DMA
Date: Sun, 12 Mar 2006 18:03:00 +0000
Message-ID: <1142186580.20056.5.camel@localhost.localdomain>
References: <200603101842.09251.kernel-stuff@comcast.net>
	 <200603120128.44469.kernel-stuff@comcast.net> <441443F5.1060603@bootc.net>
	 <200603121209.33218.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27367 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751430AbWCLR5I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Mar 2006 12:57:08 -0500
In-Reply-To: <200603121209.33218.kernel-stuff@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Chris Boot <bootc@bootc.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sul, 2006-03-12 at 12:09 -0500, Parag Warudkar wrote:
> Some one pointed out offline -
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163418 
> 
> Looks like it's a SATA combined mode problem as outlined in the above bug 
> report. NONE of the options provided in the bug report worked for me though -
> :(

If you feel adventurous then apply the libata PATA patch from my web
page and compile a kernel with CONFIG_IDE=n and most stuff should work.
Folks are still reporting some problems with libata and CD burning
however.

