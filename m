Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA6A94D;
	Thu, 13 Jun 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285937; cv=none; b=Csr8mUaDluGVCsEZFgyuIzU+bcZM9U6mdizufoJmyBfijl/LkEl/L3Kn/r50SVNa7ZwyZC7Dx5vlDgiAREZX3aPM7kNh1e4KNM5fF58clTtFbi+gDRj+IB+ZGhSlnr4HWBxkctw9cL/hgh8U1TBx6rhd1BEQGTbCHQMuq6AH6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285937; c=relaxed/simple;
	bh=TjT4QmoA+HDTCEVjWBmpuRPVNcZHx0a5efu4SQcVzR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2J4D92bapu9zXbhHGkEhjBjdkWudJCjhLTRUUwFCqNYXppfwoY2nOxFGQZeMX4KCR0YRalQUKc1PzwIyyA0ekuvKPKhWF6Bkwt2R3XSIbP/8ZqlyIbpt7pkzutH11uh2lqbJOtjimpBoq23Tolj0P4HSRYNwfSva/ZkndXm+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ64UE31; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ64UE31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1213C2BBFC;
	Thu, 13 Jun 2024 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718285937;
	bh=TjT4QmoA+HDTCEVjWBmpuRPVNcZHx0a5efu4SQcVzR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ64UE31AErtT4t+h9YhkQe0By0kar4MZ8VY7Bsr3xvxlV8btyeyjYVz17KBO8qIX
	 ix710aK3bZGYsrUEWVUOeWiE/apxuOxxBsWsUDuyD/3PiH9MsWosQKNifBIR8aG//C
	 LO0DE87sh9KjnBdx1E2/QYMI5PWJ8a7JAQjhflT/YhumJbdhmhWwyj8Dad4kQkIu9k
	 Lzyexk0iBkkGx4ZAaeM5tEsWoqBEdd6D3G7qHAI8+LvgYMpwb1qIICkMsfff0PpGGF
	 nQ3x6wdSUkmBxVTSVZOjIcQs0Dl0/ib66IgHABtNTGiN9d/53YnSzbjP0qCSLeAQOY
	 VGQURfyKXL4+Q==
Date: Thu, 13 Jun 2024 15:38:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <Zmr2a53RwyevjQYA@ryzen.lan>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
 <ZmrwksRyOkQq1OPV@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmrwksRyOkQq1OPV@x1-carbon.lan>

On Thu, Jun 13, 2024 at 03:13:54PM +0200, Niklas Cassel wrote:
> On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
> > On 6/13/24 15:34, Thomas Weißschuh wrote:

> I suggest that we:
> 1) Merge Damien's fix.

This might of course result in us getting other bug reports about their
distro no longer automounting their eSATA devices... and they might
consider that a user space regression as well.
(Since that behavior has now been there since 8a3e33cf92c7 ("ata: ahci:
find eSATA ports and flag them as removable"), which was merged in 2015.)

However, considering that the definition of the RMB bit has recently
(2020) been clarified, it is quite clear that we are currently violating
the spec, so I do still think that setting the RMB bit according to spec
is the right thing to do.


> 2) Modify SCSI to call dev_set_removable() and modify ata_scsiop_inq_std()
>    to set the "HOT PLUGGABLE" field.


Kind regards,
Niklas
