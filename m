From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 15:32:49 +0000
Message-ID: <20080213153249.GA21749@deepthought>
References: <20080213001506.GA13933@kroah.com> <20080213024329.GA6912@deepthought> <20080213044304.GA10101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:16781 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765620AbYBMPcx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Feb 2008 10:32:53 -0500
Content-Disposition: inline
In-Reply-To: <20080213044304.GA10101@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Tue, Feb 12, 2008 at 08:43:04PM -0800, Greg KH wrote:
>=20
> Can't you just boot with /dev/disk/by-id/ and an initramfs to not hav=
e
> to worry about such a thing in the future?
>=20
 Can comebody remind me what the initramfs is for in that situation,
please ?  From the little I've noticed, I thought the /dev/disk/by-id
part went into fstab ?  At the moment, I just build the things I
think I need in to the kernel on that box, without modules.

 Anyway, I'll try to find time to read my notes to see if I can
identify what happened/when, and to take the box down again so I
can try to confirm exactly what the problem is, if it still exists.
I certainly won't be taking it down until I've written my weekly
backups to tape at the weekend, so maybe not before next week.

> Have you tried the PATA drivers instead of IDE to see if this solves =
the
> "moves around" issue?  If they work, then you would not need the comm=
and
> line option at all.

 My previous kernel was 2.18-series, I think at that time they were
still under development.  This box handles the backups for my
various desktop boxes, which is why I'm very conservative about
changing it.  I guess the drivers are stable now, I'll maybe give
that a go (depending on time).

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
