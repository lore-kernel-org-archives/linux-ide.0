From: Patrick Dreker <patrick@dreker.de>
Subject: Re: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
Date: Tue, 29 Jun 2004 03:21:59 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406290321.59158.patrick@dreker.de>
References: <20040628202759.6202.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.176]:16344 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265214AbUF2BWG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jun 2004 21:22:06 -0400
In-Reply-To: <20040628202759.6202.qmail@web52909.mail.yahoo.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-ide@vger.kernel.org, meelis.roos@cyber.ee

Am Montag, 28. Juni 2004 22:27 schrieb Chris Rankin:
> > Any kernel above and including 2.4.21 (including
> > 2.6.5 and 2.6.7, others not tested) produces the
> > following errors quite often (once or twice per
> > minute, with the corresponding delay) and the
> > harddisk drops out of DMA.
>
> Linux 2.4.26-UP is fine for me here, for both hda and
> hdb. This box has 64 MB RAM, amd the kernel is
> compiled with gcc-3.2.3.
Actually I tested 2.4.19, 20, 21, 22, 24, 26 and 2.6.5 and 7 and all from 
2.4.21 on fail. All kernels compiled for SMP, but the system only has one CPU 
(second CPU is waiting for the IDE problem to tracked down...)

I have triggered a compile of all pre and rc version between 2.4.20 and 2.4.21 
and will do narrow it down tomorrow. (I know I'll probably need only 3 or 4 
of those kernels, but having them all available will make testing easier...

Patrick
-- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
