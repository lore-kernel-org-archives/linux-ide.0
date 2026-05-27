Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B203E1CE7
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871524; cv=none; b=Rq8cqqU+B/QZFR+K40aBFrp0jA9qPwy3ICH/M2F4vFrGT1MNjwEAZ1Axzq41QKY3zcDolOsUpzB9t86zs+MX7Oqn1twsOUfG+SfvTm284CNAcWoU4h+LSN5s9VcgM8ad//ea1KzDFEu7H6JrO52Egs8dnvuAN2uD0mq2oSAQ9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871524; c=relaxed/simple;
	bh=z6K1YZ6T/6Xq8hv5WBt5bTXb1ggkPKaBpKjf14K3cUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVCjSOvjl+t4I/vVjO9EBtQdV3hMxvHZmvy8N8lL0Oy/8qBgv+SSLf1Q1Q+dBev0scXWIt3HdSaFYdR5GwtiOXIqhR28JSvmffnKW6wJhT3OROgOcBR9x5Tbfb5ZUu6IQtDelVR199LZF9B3A3u9TirkuWqrQEbzb5MnyV7Iblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tK4ZqWXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tK4ZqWXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C264F1F00A3C;
	Wed, 27 May 2026 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779871522;
	bh=RepYRyeWuI4IsHsiIEWEXi8qrp0EHXsnbiZfnWMxmmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tK4ZqWXc3+cCcmf1T1Zvy/VOU5iTbRB+fVsNV9qgekjfbt7NcSGPu/HLGUJyiVwGU
	 BvpzSypasoDBiJTTAppRSs+ciAOUQ1bjKiqqtlW4gzeQSa+1sy/o+B8TT2i7ZqAtZb
	 GaQ7bweOrxLG+lflq2IBGBzGWvfH+M0Ae7DF7nE4=
Date: Wed, 27 May 2026 10:32:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, linux-ide@vger.kernel.org,
	David Dreschner <kernel-2026@dreschner.net>
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <2026052710-vivacious-strep-d3e5@gregkh>
References: <20260514073858.1175072-6-cassel@kernel.org>
 <0685a2fa-1c79-4c38-a6c1-39427d65c267@dreschner.net>
 <ahaqmgFGMwO0hPNo@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahaqmgFGMwO0hPNo@ryzen>

On Wed, May 27, 2026 at 10:26:02AM +0200, Niklas Cassel wrote:
> On Tue, May 26, 2026 at 08:47:53PM +0200, David Dreschner wrote:
> > Hello Niklas,
> > 
> > thank you very much for fixing the issue!
> > 
> > I tested the first three patches manually on my Debian 13 machine with
> > kernel 6.12.90 and can indeed confirm that your patches fixes the issue. The
> > fourth patch had some merge-conflicts and were therefore skipped - I'm
> > unable to test the changes anyway (my HBA only supports CBS).
> > 
> > Machine: HP MicroServer Gen8
> > HBA: HP Dynamic Smart Array B120i
> > Port multiplier: StarTech S322M225R (SATA to 2x M.2 SATA using ASM1092R
> > chipset in JBOD mode)
> > 
> > Could you please make sure that the fixes are being backported to all
> > versions that contain the faulty commit 0ea84089dbf6? Looks like that is
> > necessary for v7.0, v6.18, v6.12 and v6.6.
> > 
> > If not, it would be great to get the fixes at least merged into v6.12, as
> > I'm otherwise forced to manually build any new stable kernel that's being
> > pushed by the Debian team.
> > 
> > Thanks again and greetings from Germany!
> > David
> 
> Dear stable maintainers,
> 
> Sorry for the extra work put on you.
> 
> Could your please help us backport:
> 
> $ git log --reverse --oneline v7.1-rc4..v7.1-rc5 drivers/ata/
> 360190bd965f ata: libata-scsi: improve readability of ata_scsi_qc_issue()
> ce4548807d2e ata: libata-scsi: do not use the deferred QC feature for ATA_DEFER_PORT
> f233124fb36c ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
> 759e8756da00 ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
> 
> 
> The first three patches apply cleanly to at least v6.12.
> 
> The final commit does not apply cleanly, attaching a backported version.
> 
> Again, sorry for the trouble.
> Hopefully our AI overlords / Sashiko will manage to find some of these
> problems that was missed during the review of the faulty commit.

Now queued up, thanks.

greg k-h
