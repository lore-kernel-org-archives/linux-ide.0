Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537C145B26
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290186; cv=none; b=CdDpoVXMzz0/udkX6OJ2ThIVOdvAALvv35VXonj66E9RrORZCiYoaGjYoyQi+qB4P2SqCetH1xh1rByBTJxvaD6Hyu3RedvffE3vgohreJ2eki/TmqiSYTWdz+iXhqD0j/y9DwY0zVMnJBIVYmFQ78TaGqPKrGHKiJc9PTEtWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290186; c=relaxed/simple;
	bh=3agOKwAl5yF8NRQemc3BoaSiUROdNcnR6b8pjbA+FLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQwNXoive6vdU1zmBrosSGCRSuSMzIRo5M1M/3A1ujkhHe/Ll/wd5rdgEJfaXMLYU1zpVWSB1vBa7y4ZDg72XuKroaSSeKPCC6gZlKAuZFId2t8bz3+Sq8KORS4BtKmm/c6foi0zmefRilZuKAUjr7nm6/fdCT67xUqb+TPtx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LhqmP53n; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LhqmP53n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718290183;
	bh=3agOKwAl5yF8NRQemc3BoaSiUROdNcnR6b8pjbA+FLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhqmP53nx5pRPy5f3TyD+8tW19+AR7RTa6HwSCSHuhjWaVoVm91bUOAdWMW0WC+FF
	 Duw6LEbqxvpsA/8FjTuHoMzIUma+wNXkAHdTXOFID/kQx4r0oIS9aZrYBGSOPV1NKv
	 rdNYg3HauWdfoZQMrU7d8GdBXCwfMVXwnID9qrhI=
Date: Thu, 13 Jun 2024 16:49:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jian-Hong Pan <jhp@endlessos.org>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <10f95864-3674-4c69-8abf-d4b9f56f9ec4@t-8ch.de>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
 <ZmrwksRyOkQq1OPV@x1-carbon.lan>
 <Zmr2a53RwyevjQYA@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmr2a53RwyevjQYA@ryzen.lan>

On 2024-06-13 15:38:51+0000, Niklas Cassel wrote:
> On Thu, Jun 13, 2024 at 03:13:54PM +0200, Niklas Cassel wrote:
> > On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
> > > On 6/13/24 15:34, Thomas Weißschuh wrote:
> 
> > I suggest that we:
> > 1) Merge Damien's fix.
> 
> This might of course result in us getting other bug reports about their
> distro no longer automounting their eSATA devices... and they might
> consider that a user space regression as well.
> (Since that behavior has now been there since 8a3e33cf92c7 ("ata: ahci:
> find eSATA ports and flag them as removable"), which was merged in 2015.)

This is quite likely.

How about reverting the "ata: ahci: a hotplug capable port is an external"
for now and work on a proper fix, including dev_set_removable() for an
upcoming release?

> However, considering that the definition of the RMB bit has recently
> (2020) been clarified, it is quite clear that we are currently violating
> the spec, so I do still think that setting the RMB bit according to spec
> is the right thing to do.
> 
> 
> > 2) Modify SCSI to call dev_set_removable() and modify ata_scsiop_inq_std()
> >    to set the "HOT PLUGGABLE" field.
> 
> 
> Kind regards,
> Niklas
