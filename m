Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7733EDAD9;
	Wed, 10 Jun 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084840; cv=none; b=qgz5ahD0rIrzBKKTrte5qnhPdD4tDhN8o6sS/uByzd5cDzrxeW6oaTi2HLh2VwFtqTmK9wTGfpQT4929bxihk/Q+F9WF3ptJkkMawHdhN1DhbvBBA3e4NKwBJVdk99h6+0lQLc3aaPXzHnhvKWg/fqeFEh7dDgJmDbGexp+Apmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084840; c=relaxed/simple;
	bh=Z/yr/OL7lhy3qInP0uCQvu5mbD7gbXZT6o3R98zYuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm4akxCji4c9nzdrLdwlavSONMSe1wihL9oAOXWBSjwuJQkjYCErTbJnX+yucept1q8B+5BXITb38s/Gl9yZwmRh4ZTN41t/8cTwCzAR7MFxyi0f6qp3hxk1+hgdYG7vGyUI3UKZO7Cb50qH1beA7vnixbeoL5Uao+R0rJINBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H05an8lO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H05an8lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8181F00893;
	Wed, 10 Jun 2026 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781084837;
	bh=+cleo8mhLB2DXzGPg9B9Im9fzQ/vJoE754q8ZfA1Big=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H05an8lOVQ0gRTit8GCl++i6CIkamVFDJKXc4PZ2wua3YTG5+sk/9uznzUvRX99nC
	 lgDX5tfGkfF5cauTj6KWEzWAXAo3mKvSiwD64KvPLgugtLpbCu4MN61IbGk3jAb6pe
	 lmZZ9SuyF1UPheiV3+QwOpCGYGLtYdqRHAGieb4HAMHt5c0sWtmCgeZiTbXTdADLns
	 k3pa8D1MFZjYf3wcS2Al7AXu8gVq9lNk0ryM+CVsRLkwndC1m2e3xKIg8sCDpwA1AZ
	 DTInT1RPm5C31pVs2oOvhiwSRb2h7J251LNDTl37b8iiSfKtZmbgP4EsKKsW/ZrzI5
	 VpJDbocoMbwcg==
Date: Wed, 10 Jun 2026 11:47:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: raoxu <raoxu@uniontech.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-pmp: add JMicron JMS562 quirk
Message-ID: <aikyoSdB6Vwhkiy5@ryzen>
References: <71B4D0BBEC4F886F+20260610052835.1111181-1-raoxu@uniontech.com>
 <6a5f24b3-4777-4ed6-bcaa-a65740046ae6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5f24b3-4777-4ed6-bcaa-a65740046ae6@kernel.org>

On Wed, Jun 10, 2026 at 05:09:34PM +0800, Damien Le Moal wrote:
> On 2026/06/10 13:28, raoxu wrote:
> > From: Xu Rao <raoxu@uniontech.com>
> > 
> > JMicron JMS562, as used in QNAP QDA-A2AR RAID1 adapters, may
> > keep the exported ATA device not ready while the array is rebuilding.
> > 
> > In this state, libata may repeatedly try to softreset and classify
> > the fan-out link.  On the affected adapter, this can time out, make
> > PMP/SCR access fail, and eventually disable the fan-out link before
> > the RAID volume is exported.
> > 
> > A failing boot shows the fan-out link failing SRST, PMP access
> > timing out, SCR read failing, and the link being disabled:
> > 
> >   ata4.00: softreset failed (device not ready)
> >   ata4.15: qc timeout after 3000 msecs (cmd 0xe4)
> >   ata4.00: failed to read SCR 0 (Emask=0x4)
> >   ata4.00: failed to recover link after 3 tries, disabling
> > 
> > After that, the root filesystem on the exported RAID volume cannot
> > be found.
> > 
> > Add JMS562 to the existing JMicron PMP quirk that disables LPM,
> > avoids softreset on fan-out links, and assumes an ATA device.  This
> > prevents libata from dropping the exported RAID volume during rebuild
> > recovery.
> > 
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> 
> It is really unfortunate that JMicron keeps having these issues. But I do not
> see any way around this, so:

I don't really like that this patch disables LPM unconditionally for all
the fanout links.

However, this PMP chip seems to be of an older generation compared to the
most popular JMicron JMB575 and JMB585, and seems to be connected using
eSATA interface only (which means external port, which means LPM will be
disabled anyway):
https://www.jmicron.com/file/download/1024/JMS562_Product+Brief.pdf


Kind regards,
Niklas
