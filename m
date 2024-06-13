Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AE14A4D0;
	Thu, 13 Jun 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301249; cv=none; b=RwQvFhixdZYjcAT15LfCNXULo9piD7v3iExvQTwkI0zeWSNQEfO/m+M4r7fuMl5Rm/z0eLPx6tZc6WnHNRFTDBI3Q0EIVceo9+OO8P4n8wtWLjcZjmmn26C9hHEB8L2lIzC5Gob4RzPJLsSlWxOnZojTiF53+ukufZlGvFD/zQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301249; c=relaxed/simple;
	bh=RBZcgEl7qpetDPHuJQ6Fm2I9ulDqJTKERRhzxqPui4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9L0aOTEVxR9nb/SPSnxeNAZIiPFZPw3TuVw3CNUBk42Xer2/AW1pd+bud+IKFBSyINuaMEP3stJb8okIXnDdFudMddrML1+ZcHKXbXmQdbVZnREWBn4h+hylgoFPqLgIkIgvB/nq/NmfRL/kNvP3RqR9kA7DgIyVRTvV0pqVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap1V0cn2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap1V0cn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B18C2BBFC;
	Thu, 13 Jun 2024 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301248;
	bh=RBZcgEl7qpetDPHuJQ6Fm2I9ulDqJTKERRhzxqPui4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ap1V0cn2mITe/r6d8gPV/ZQlSqB6ZJTFIGtjvDIZGzZrElc0rqdWDfF2xjA/ekaj7
	 WKBf61aI/KJy3KyEJmgjua6x55EoeuZzfNQlFmvniIXTkdV4W8wZgbuGm5DIhRSRKz
	 PeqmzsOvr+2wMvf13UI8akdJABeNaNU7qHsIcT84yRu6Q4xFmB3LTCga4/qQWRPy+K
	 46/FJQ2KUkzxPUhe1N+lGlUqhMRZnyOT+ScQLVrmqj8pyGuE511Fe7bH3LXmDKUMjN
	 yLJnreQkyRA3MrUbDMsfFrT0RmhNsPK0/xu/6BQCCwacKhcNd/22u6klXJwg/Q4kOv
	 7zN4gZZdez0wQ==
Date: Thu, 13 Jun 2024 19:54:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <ZmsyOjE5DkeM9Ut/@x1-carbon.lan>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
 <ZmrwksRyOkQq1OPV@x1-carbon.lan>
 <Zmr2a53RwyevjQYA@ryzen.lan>
 <10f95864-3674-4c69-8abf-d4b9f56f9ec4@t-8ch.de>
 <ZmsST1kF34A9f4-y@ryzen.lan>
 <6d5e7f17-6760-4128-a5d5-22ae2a87dadf@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5e7f17-6760-4128-a5d5-22ae2a87dadf@t-8ch.de>

On Thu, Jun 13, 2024 at 07:33:09PM +0200, Thomas Weißschuh wrote:
> On 2024-06-13 17:37:51+0000, Niklas Cassel wrote:
> > On Thu, Jun 13, 2024 at 04:49:43PM +0200, Thomas Weißschuh wrote:
> > > On 2024-06-13 15:38:51+0000, Niklas Cassel wrote:
> > > > On Thu, Jun 13, 2024 at 03:13:54PM +0200, Niklas Cassel wrote:
> > > > > On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
> > > > > > On 6/13/24 15:34, Thomas Weißschuh wrote:
> > > > 
> > > > > I suggest that we:
> > > > > 1) Merge Damien's fix.
> > > > 
> > > > This might of course result in us getting other bug reports about their
> > > > distro no longer automounting their eSATA devices... and they might
> > > > consider that a user space regression as well.
> > > > (Since that behavior has now been there since 8a3e33cf92c7 ("ata: ahci:
> > > > find eSATA ports and flag them as removable"), which was merged in 2015.)
> > > 
> > > This is quite likely.
> > > 
> > > How about reverting the "ata: ahci: a hotplug capable port is an external"
> > > for now and work on a proper fix, including dev_set_removable() for an
> > > upcoming release?
> > 
> > Perhaps I'm missing something here, but how will dev_set_removable(),
> > which sets a different sysfs attibute solve that "problem"?
> 
> Indeed, it finally won't help.
> But only reverting that single commit should minimize the impact on
> users and give time to work on and discuss something better.

Reverting is not a good solution, because that means that we will not
disable LPM on hot-plug capable devices, which means that we will break
hot-plug. So that would be an even more serious bug :)

In my opinion, it seems quite clear that the current code is wrong
(at least according to the SPC-6 specification), so I see no reason
why we shouldn't just make the code spec compliant.

(and if a device is not spec complinant, it should be quirked.)

Damien, if you feel otherwise, please say so.


Kind regards,
Niklas
