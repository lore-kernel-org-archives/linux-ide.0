From: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: IDE cdrom problem with PLEXTOR DVDR PX-608AL
Date: Thu, 14 Feb 2008 00:37:50 +0100
Message-ID: <200802140037.51450.hpj@urpla.net>
References: <200802121026.17420.hpj@urpla.net> <20080212172057.GA12480@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55226 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136AbYBMXh6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 18:37:58 -0500
In-Reply-To: <20080212172057.GA12480@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Am Dienstag, 12. Februar 2008 schrieb Borislav Petkov:
> On Tue, Feb 12, 2008 at 10:26:17AM +0100, Hans-Peter Jansen wrote:
> > Hi,
> >
> > I suffer from unreliable cdrom operations (failing DAE and burn
> > sessions) with the openSUSE 2.6.18.8-0.7-bigsmp kernel.
>
> 			^^^^
> Hi,
>
> can please you test this with a more recent kernel. Yours is almost
> ancient - from Sep. 2006.

Sure, sorry. Here we go:

Feb 14 00:18:18 kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01).
 Trying to recover by ending request.
Feb 14 00:27:27 kernel: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01). 
 Trying to recover by ending request.

~> uname -a
Linux xrated 2.6.24.1-35-pae #1 SMP 2008/02/12 01:00:18 UTC i686 athlon i386 GNU/Linux

Thanks for caring,
Pete
