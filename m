From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: "ide=reverse" do we still need this?
Date: Wed, 13 Feb 2008 02:43:29 +0000
Message-ID: <20080213024329.GA6912@deepthought>
References: <20080213001506.GA13933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:2069 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243AbYBMCrp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Feb 2008 21:47:45 -0500
Content-Disposition: inline
In-Reply-To: <20080213001506.GA13933@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Tue, Feb 12, 2008 at 04:15:07PM -0800, Greg KH wrote:
>=20
> I'm curious if we really still support the ide=3Dreverse option?  It'=
s a
> config option that I don't think the distros still enable (SuSE does
> not).  Is this still needed these days?
>=20
 My "server" has a consumer-grade desktop amd64 mobo, with all that
implies about cheap hardware and strange/misleading bios options.
It also has an add-in dual IDE card with the main data on raid1.
It's set to ide=3Dreverse, without that it doesn't boot (the add-ins
are IDE, system drive is SATA, so I guess it probably tries to boot
from the DVD - it's been a long time since it bit me and I don't
remember the full details.

 That was how it was set for 2.6.18.6, and how it now boots from
2.6.22.18.  I think at one time the order of the interfaces might
have been different.  Certainly, I carry forward a fallback without
ide=3Dreverse in lilo.conf, just in case the disks move on my next
kernel upgrade.

 What a distro selects should cover most of that distro's users, but
that is not anywhere near providing 100% coverage for *all* the
hardware out there.  Also, you can force your users to e.g. mount by
label.  So far, that hasn't been forced on me, and I really hate
having to reboot that box :)

Ken
--=20
das eine Mal als Trag=F6die, das andere Mal als Farce
