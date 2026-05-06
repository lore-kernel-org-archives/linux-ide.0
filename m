Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5830F7F3
	for <linux-ide@vger.kernel.org>; Wed,  6 May 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079145; cv=none; b=Ib/lcRvOJmvXFaPIrMAuTXl194reSTVWrPkjoS7h0n5oimxtrsLnEuQ7qEKtWxlqLssi81et/4TU7zlyxqAPW0nNvvz/3Ppj3V9X1pE6mTIUIsPBoQxHJHrUyzZQibcarOrNIsoynE2ziBr1RvlL6gXAH0EyBm/zOdn+jOLyZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079145; c=relaxed/simple;
	bh=ybo0x2DELfoMClYUY2vQRsuY6NFMvUA+XvYna5IjC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sakTmTeOzWoGpBRmlmfgd92y//cn2ilQT+bdv5Tzt56iKpcvQXUaZ6/eQttcD/Cgy7qlx7ImfSj1hKQKD1F3lto4/76q2V+GUnjTzxO13rYsJQMmF35jAtNzG/yV2jXXzZubeg1VHl8VjPj+DVsvMtNR9HmRWATSS0BMu79XBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXYOcYfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXYOcYfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9AC2BCB0;
	Wed,  6 May 2026 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079144;
	bh=ybo0x2DELfoMClYUY2vQRsuY6NFMvUA+XvYna5IjC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mXYOcYfY3+tHdqILq7/+sKYrqhLBFCVK98HhZ8D5yRsevGJa5kOaiK+PfIIJSVj1M
	 Bi8EFpXJ9POD7GgJJ4gTOWh5W6XIlBtg7oud/lwhAvbwWYIe7u2RQlbEWFohop9ozK
	 WPJTUpGfOl23DmhnhDeptgXG8hYLriPzV/UxjdxrH6M4QUpHUUWnl11vnyJAByosx5
	 PPCTNF4EYzBI2TdxA3CdbaZH2fBIfysJJrFabHc+31+Tb058c3F9h0NkCczgEXUsRl
	 zKvYCkQ/8z+Bz2sKVsRroxW3UBycOLJiaVXlsfgHhLQ23tBoulutDkrvekqI/DgNPg
	 D679mBiz7Sv1A==
Date: Wed, 6 May 2026 16:52:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <htejun@gmail.com>, John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Message-ID: <aftVpJMMtzZhKusF@fedora>
References: <20260501125410.1204490-5-cassel@kernel.org>
 <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>

Hello Tommy,

On Sat, May 02, 2026 at 05:59:12PM -0700, Tommy Kelly wrote:
> 
> Yes, this patch series fixed the regression for me with a CBS Port Multiplier.
> 
> Here are the commits I tested with:
> 
> > (HEAD -> fedora-7.0-libata) ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
> > ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
> > ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
> > ata: ahci: fail probe if BAR too small for claimed ports
> > ata: libahci: use ahci_nr_ports() helper
> > ata: pata_parport: switch to dynamic root device
> > Merge remote-tracking branch 'libata/for-7.1' into fedora-7.0-libata
> > (tag: kernel-7.0.3-0, kernel-ark/fedora-7.0, fedora-7.0) [redhat] kernel-7.0.3-0
> > Merge Linux v7.0.3
> > (tag: v7.0.3, kernel-ark/linux-7.0.y, linux-7.0.y) Linux 7.0.3
> 
> And here's some logs showing ata_id (non-NCQ) resolving immediately.
> After, I'm able to boot and mount and use the filesystem no problem.
> No errors and no timeouts.
> 
> > Mar 12 17:00:10 localhost kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> > May 02 17:12:39 (udev-worker)[874]: sdd: Starting 'ata_id --export /dev/sdd'
> > May 02 17:12:39 (udev-worker)[874]: sdd: 'ata_id --export /dev/sdd'(out) 'ID_ATA=1'
> > May 02 17:12:39 (udev-worker)[874]: sdd: Process 'ata_id --export /dev/sdd' succeeded.

This all looks normal to me.

Thank you very much for testing!


Kind regards,
Niklas
