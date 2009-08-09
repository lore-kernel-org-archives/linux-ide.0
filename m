From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 9 Aug 2009 17:58:40 +0100
Message-ID: <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
References: <h5kn9c$51r$1@ger.gmane.org>
	<4A7DE735.6090409@gmail.com>
	<h5krje$ec7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53646 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751857AbZHIQ5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 12:57:32 -0400
In-Reply-To: <h5krje$ec7$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

On Sat, 08 Aug 2009 17:44:13 -0400
Jim Duda <jim@duda.tzo.com> wrote:

> thi
> > My first suggestion would be to try using the libata drivers instead of
> > the old IDE ones. The st driver should be able to access the tape then.
> > I'm not sure if many people are running ATAPI tape drives on libata
> > these days, but the old IDE drivers certainly don't get a lot of use.
> > --
> 
> Where/how can I learn how to access my tape drive using libata?

You need st_mod.ko loaded (scsi tape), and the newer modules for the hard
disk controller (pata_xxxx) and it should appear as /dev/st0 just as it
did before the old IDE people broke ide-scsi support.

Alan
