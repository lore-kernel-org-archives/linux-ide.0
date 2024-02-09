Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4B8288F
	for <linux-ide@vger.kernel.org>; Fri,  9 Feb 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507016; cv=none; b=eLzEdoq3ukfbVs/QdJRXHtaZj+o3fCudgd2CwjTjTixrlCKezol9j9QoJH3EDeYnajugO9tsGF8XlJyYxK6pLIFyJH3CXpovre2UGxWe+MoBTheDSxvqZSVM8NhK/RJgPcU5TzUBgq1lscSVJT+ngB1oOfKF/YnJQDcYqURksXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507016; c=relaxed/simple;
	bh=ONSF6DoEyut+SuL/irAu2uAQXmUhu+r5At0/3o0PX70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP3x7V7+mR/pOEBt5YedMcFGQuyVpZvG8NCyu2qgaeWSDxNePEJK329TaDJCjyvaUmWrLo/XpYL7pi+Lo+8LfX9PjNaQvLLrEsRgjV7yiLioT5EtKpLJBnkesX3R332KsxRymAwaTBL33lY9vSiBG61ctleqvXFU7wwIMVkrJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cA+kTdUE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA+kTdUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F03C433F1;
	Fri,  9 Feb 2024 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507015;
	bh=ONSF6DoEyut+SuL/irAu2uAQXmUhu+r5At0/3o0PX70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cA+kTdUEcZLEyNUPEnVSajMLwfidj2Kv/2a1Z0o4V85mOH0H8zK6eg//MJ1Fmvw9K
	 sKNj5zkZTcR1HjvJkP4+WpgJHkV7Oot0up80wDaJ0KUck3iekWNejDAfHdaChqPsSl
	 dE/BVcLizk9WUkBUTrtYrlgRdCYEbHvFqFdls09KMMMJz8w+pYkXxFb5DJ5Jz0Q1zk
	 c0L1Gg3dtiorkiB5AjaLgdMJWx+pEJLyNz0AGc22ZsRdWxb8k4kcONG+Hp0CI0PGQK
	 XJ6LkjUoGvRzEu7lge59WfbMWszcMe30tc6OynG5HYjz9DEoe+coRcSRzN4O7HPuuA
	 JSe2RC7C63hog==
Date: Fri, 9 Feb 2024 20:30:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: clean up intel_pcs_quirk
Message-ID: <ZcZ9Qg2NNVZXt3if@x1-carbon>
References: <20240209130307.39113-1-cassel@kernel.org>
 <65c66d85d0a67_afa42948b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c66d85d0a67_afa42948b@dwillia2-xfh.jf.intel.com.notmuch>

Hello Dan,

On Fri, Feb 09, 2024 at 10:23:01AM -0800, Dan Williams wrote:
> Niklas Cassel wrote:
> > The comment in front of board_ahci_pcs7 is completely wrong.
> > It claims that board_ahci_pcs7 is needing the quirk, but in fact,
> > the logic implemented in ahci_intel_pcs_quirk() is the exact opposite,
> > only board_ahci_pcs7 is _excluded_ from the quirk.
> > 
> > This way of implementing a quirk is unconventional in several ways:
> > First of all because it has a board ID for which the quirk should _not_ be
> > applied (board_ahci_pcs7), instead of the usual way where we have a board
> > ID for which the quirk should be applied.
> > 
> > The second reason is that other than only excluding board_ahci_pcs7 from
> > the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
> > (which matches on AHCI class code) are also excluded.
> > 
> > This can of course lead to very subtle breakage, and did indeed do so in:
> > commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
> > which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.
> > 
> > This caused many users to complain that their SATA drives disappeared.
> > The logical assumption was of course that the issue was related to LPM,
> > and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
> > "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").
> > 
> > It took a lot of time to figure out that this was all completely unrelated
> > to LPM, and was instead caused by an unconventional Intel quirk.
> > 
> > Clean up the quirk so that it behaves like other quirks, i.e. define a
> > board where the quirk is applied. Platforms that were using
> > board_ahci_pcs7 are converted to use board_ahci, this is safe since the
> > boards were identical, and board_ahci_pcs7 did not define any custom
> > port_ops.
> > 
> > This way, new Intel platforms can be added using the correct "board_ahci"
> > board, without getting any unexpected quirks applied.
> > 
> > This means that we currently have some modern platforms defined that are
> > using the Intel PCS quirk, but that is identical to the behavior that
> > was there before this commit.
> > 
> > No functional changes intended.
> 
> *crosses fingers*
> 
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v1: Just do the actual cleanup instead of documenting how
> > weird the existing quirk is. (Simply documenting the quirk would not have
> > stopped people from encountering the same problem as we encountered when
> > trying to add support for Tiger Lake.)
> > 
> >  drivers/ata/ahci.c | 361 ++++++++++++++++++++++-----------------------
> >  drivers/ata/ahci.h |   1 +
> >  2 files changed, 180 insertions(+), 182 deletions(-)
> 
> It's large, it's noisy, but I see no lies here. I think this is the way.
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...I wanted to give a reviewed-by, but this patch does not apply to
> current mainline so I can double check the result, can you share the
> baseline for this diff?

The for-next branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git

https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next


Kind regards,
Niklas
