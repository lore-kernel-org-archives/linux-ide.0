Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5D1428F
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854534; cv=none; b=aiNgSpk7pNZw5DSBiIaIC7ma35cZUvMSOZFM5zNOD82iCQ6rJNa5QlBNKSW4fcbQTF+YUWeGkNE/AGwsqXxTehDccrzkC27QwZLnc3vw6XZbhUzZIbSaVSGOswCpmO0wLIMu9ZuMS0ZI9xzhIQ0zk/qhxiza2mbrdAYLXL/spfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854534; c=relaxed/simple;
	bh=WgFw3Rnn2224L7tXcrzMESz1QBBvPJYtU+lCuCw9AAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssc0LI37zSuoKaftZZiJ2Jcqrrjvi59tqCwdkUhp8R1BKNwSP8o3CUKJy5ECmorfEBScHIYrs9Ntg7NyQIMhbV/DHU9DxaNKt38kg3Q+14G8H2Y3jFgKvKluobmcwa/jeknplr7qW74kNX5UFuonuKZajze5j5WLgqAJ3TZucTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK8TPKoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK8TPKoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F15C433C7;
	Tue, 13 Feb 2024 20:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707854533;
	bh=WgFw3Rnn2224L7tXcrzMESz1QBBvPJYtU+lCuCw9AAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KK8TPKoT2NktxDMCnzY/Y2wl3wQsdNbTXH7MWFS+EuBYIQhkDs/jKKW+x/FRkzjCf
	 kw5/+Z6oD8ytwFRrqc0ZdMqSERpkSwGKT2VS2gmhPlBvgLhUi+69CnzVScp40YhbRJ
	 O1UGYnrMTK1GtpF406HrIODyi9ztdgaIO16WgI1uz2E3RNbHsSmdhfkPutRPq2A5eL
	 J0oNk9bX/M+uri9Eztlx6ecsa7g+tXjAaG4GXoaBb4woNIv424nvEjL3Niy9d7+cuN
	 SYhqIqn2fIuNa+X7yTn4uiDr+FSHUkioBF1RG+jgHz2f8dPlp8AMVWmM2RZwdNAUu8
	 8/SNccq2aM2CA==
Date: Tue, 13 Feb 2024 21:02:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: Re: Re: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Message-ID: <ZcvKwDQ+Gq/xhgk5@x1-carbon>
References: <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
 <Zbt3qD8dMSqGYl8Q@x1-carbon>
 <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>
 <ZcEwa4fOzMif8lCd@x1-carbon>
 <trinity-0bc8e6ea-7808-4508-af3a-be22281abf24-1707231996854@3c-app-webde-bs42>
 <ZcKopITjwjKYNM9C@x1-carbon>
 <trinity-65caccf7-138b-4625-8e2e-afac802dd2da-1707403068697@3c-app-webde-bap33>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-65caccf7-138b-4625-8e2e-afac802dd2da-1707403068697@3c-app-webde-bap33>

Hello Dieter,

On Thu, Feb 08, 2024 at 03:37:48PM +0100, Dieter Mummenschanz wrote:

> > I assume that you didn't need this on v6.6 and older?
> 
> > (Instead libata should put the device to standby or sleep itself,
> > it shouldn't need to be done explicitly by the user.)
> 
> I'm at a loss either. No idea why this is actually working. When I encountered the low-power issue I searched the web and stumbled upon hdparm -Y and gave it a shot.

Are you saying that you always do this before suspending?
Both on v6.6 and v6.7?


> > But if you can enter pc8 on every boot on v6.6, but not on v6.7,
> > then it is probably easier to figure out which commit that broke
> > things, as there were not that many suspend/resume related changes
> > added in v6.7.
> 
> Maybe you could point them out so I can try to bisect?

Sure.

These are the libata (and related SCSI) patches added in v6.7
(that are not in v6.6):

b09d7f8fd50f scsi: sd: Fix system start for ATA devices
6371be7aeb98 scsi: Change SCSI device boolean fields to single bit flags
fd3a6837d8e1 ata: libata-core: Fix ata_pci_shutdown_one()
2da4c5e24e86 ata: libata-core: Improve ata_dev_power_set_active()
54d7211da7cd ata: libata-eh: Spinup disk on resume after revalidation
1b947279798f ata: libata: Cleanup inline DMA helper functions
0fecb50891aa ata: libata-eh: Reduce "disable device" message verbosity
7f95731c74d7 ata: libata-eh: Improve reset error messages
88b9f8928678 ata: libata-sata: Improve ata_sas_slave_configure()
3341b82368fb ata: libata-core: Do not resume runtime suspended ports
3a94af2488bf ata: libata-core: Do not poweroff runtime suspended ports
09b055cfb0e9 ata: libata-core: Remove ata_port_resume_async()
6702255d700a ata: libata-core: Remove ata_port_suspend_async()
5b6fba546da2 ata: libata-core: Detach a port devices on shutdown
cfead0dd81de ata: libata-core: Synchronize ata_port_detach() with hotplug
8c1f08170694 ata: libata-scsi: Cleanup ata_scsi_start_stop_xlat()
c4367ac83805 scsi: Remove scsi device no_start_on_resume flag

I would start with v6.6 and apply them one by one.
(Starting with c4367ac83805)

However, it is also possible that the regression is completely unrelated
to libata changes (e.g. caused by a ACPI suspend/resume patch), and in
that case, you will need a complete bisection.


Kind regards,
Niklas
