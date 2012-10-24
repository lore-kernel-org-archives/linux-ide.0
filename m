From: "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 10:43:05 +0400
Message-ID: <20121024104305.14d9573d@ion.home>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
	<20121020120047.GC17563@liondog.tnic>
	<50841CFC.2030802@talktalk.net>
	<20121021165756.GA20642@liondog.tnic>
	<50856AA8.1000607@talktalk.net>
	<20121022202734.GA16169@liondog.tnic>
	<20121023110549.06f9c2e8@pyramind.ukuu.org.uk>
	<20121023101751.GA24656@liondog.tnic>
	<20121023161216.GC26756@x1.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vint.altlinux.org ([194.107.17.35]:42082 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757868Ab2JXGnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 02:43:09 -0400
In-Reply-To: <20121023161216.GC26756@x1.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, phillip.wood@dunelm.org.uk, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello

=F7 Tue, 23 Oct 2012 18:12:16 +0200
Borislav Petkov wrote:

> @Tejun: so basically there are two people with oopses when using
> pata_acpi
Not two. We have two boxes in our office (about 20 boxes) and more then
ten reports from our users (only from early adopters yet). It seems
that this problem doesn't exists when someone build kernel for his own
box, but will be triggered very often when 3.6 will be wide used distro
kernel.

--=20
Regards
Anton
