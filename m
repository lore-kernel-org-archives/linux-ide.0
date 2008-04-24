From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Thu, 24 Apr 2008 06:32:38 +0200
Message-ID: <200804240632.39182.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com> <200804240615.23463.volker.armin.hemmann@tu-clausthal.de> <48100A8B.4000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:57021 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYDXEcn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 00:32:43 -0400
In-Reply-To: <48100A8B.4000102@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

On Donnerstag, 24. April 2008, Tejun Heo wrote:
> Volker Armin Hemmann wrote:
> > emm, even without the double slashes I get the same message:
> > git fetch
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.gi=
t
> > upstream:upstream
> > fatal: Not a git repository
> >
> > git fetch
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.gi=
t
> > fatal: Not a git repository
>
> Hmm... strange.
>
>  > git --version
>
> git version 1.5.2.4
>
>  > git fetch -v
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> upstream:upstream
> * refs/heads/upstream: same as branch 'upstream' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev
>    commit: 48feb3c

Jim got me on the right track. I was just very stupid - not surprising,=
 I=20
should sleep for 6  hours now ;)

I will report back later today,

Gl=FCck Auf,
Volker
