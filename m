Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0267F47F
	for <linux-ide@vger.kernel.org>; Tue, 21 May 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299267; cv=none; b=CtJ1ZjoOpX8dcW+jPTKgONJBvO/7Z25d5ylGUvPV/CwcoAWxTrx3t1+2cQ2UOxXpD4PNbevvQ3vngMMbjcadQzqcdwvNVpqhnN0SmHctOFYSZLvj/0s3yyIU+Fv9Tufj32Uk60m68BziedzSpbFSSWDJKfEVPH5Kz7ftYAEXJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299267; c=relaxed/simple;
	bh=6P70Kj9AvQxRxeCC4ljiZtRMMaiib3YC8RIstb1upyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZGuaga8yMATeV/Y4ITOQXhgEvK2pn8NT0+fRQZOITb+RikULIwOcXzrHGj7qVlrg9MDeGcqu0Koc4u8vhyesRkgi43jXIdRz1206vxaO0ogZh1Uc9ahM2lSagWRoEDWXs7F6l7CpS3xuNg5SbHrjZH8Uq5VIf66SwQCzrNwQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRAupyfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRAupyfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5493CC32786;
	Tue, 21 May 2024 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716299266;
	bh=6P70Kj9AvQxRxeCC4ljiZtRMMaiib3YC8RIstb1upyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRAupyfDPyUmzfMF+buIj7ZgJ0B6n1c4AxWurM1LWNrl8gNtyhTVK0OsiwQKzMJNx
	 EIaFu1cM3yBlGXCK6OuN6iYhsO2q9JStlBrD3XeEovm52xEZ9Tb0Ia2knvLQ/pFkka
	 yqqrL6GCirSVx7Fa42y2MhpYAed/9SK8zVhUZJlr7IWnMd+Vebbk8ZYkDL04NJmr7+
	 0QQGp0xGyLUeHivI2qqTrJZqo15VnAH1ZY9QidpDq+vel/Yjrca6+tff+jsY5T7Jl1
	 Jhk+aEDiJ18mRziEnJWMwQZoaXv1WR/21zw1Qrk6HkKjXcAGYf+6QV6MiX+oaC8o3r
	 F6OKBSpQjFMgg==
Date: Tue, 21 May 2024 15:47:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tasos Sahanidis <tasos@tasossah.com>
Cc: dlemoal@kernel.org, jhp@endlessos.org, hch@lst.de,
	mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
	linux-ide@vger.kernel.org
Subject: Re: AHCI hotplug no longer functions on ICH7
Message-ID: <Zkyl/RuvygEpVW26@x1-carbon.wireless.wdc>
References: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>

Hello Tasos,

On Sun, May 19, 2024 at 02:40:12PM +0300, Tasos Sahanidis wrote:
> Hi,
> 
> I have a hot swap bay connected to an Intel Corporation NM10/ICH7 Family
> SATA Controller [AHCI mode] [8086:27c1] (rev 01) (prog-if 01 [AHCI 1.0])
> and since commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type") SATA AHCI hotplug no longer functions. Plugging a device in after
> the system has booted results in it not being detected.
> 
> Looking at ahci_update_initial_lpm_policy(), it is evident that
> ATA_PFLAG_EXTERNAL is not set (ad->pflags == 0x84 when the function is
> called) and there is no option in firmware to mark these ports as external.

If your port is external or hot plug capable, then your platform firmware/BIOS
should set either the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the
"PORT_CMD_HPCP" bit.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=45b96d65ec68f625ad26ee16d2f556e29f715005

Is there any option in your BIOS to mark the port as external or hot plug
capable?


If not, then your platform firmware is broken and needs to be quirked.

Please provde the output from
# dmidecode
so that we can apply a quirk for your broken platform.


> My kernel was always built with CONFIG_SATA_MOBILE_LPM_POLICY=3. Booting
> with ahci.mobile_lpm_policy=2 or ahci.mobile_lpm_policy=1 results in the
> device being detected on hotplug, but the unplug event is never detected
> and the system thinks the device remains connected, resulting in hangs.

In older kernels, regardless if your AHCI controller reported support for
low-power modes or not, you also needed an explicit entry in ahci_pci_tbl for
it to be enabled.

Thus, even if you built with CONFIG_SATA_MOBILE_LPM_POLICY=3, and LPM was
being reported as supported by your AHCI controller, LPM was most likely not
enabled for your AHCI controller with older kernels.

In newer kernels, if CONFIG_SATA_MOBILE_LPM_POLICY=3, and the AHCI controller
reports that it supports LPM, we will enable it.
(We will not enable LPM if the port is external or hot plug capable, as that
breaks hot plug, as you found out.)


> The only way to restore functionality is with ahci.mobile_lpm_policy=0,
> which if I am not mistaken has the same effect as an early return. Is
> this the intended way of getting hotplug to work again from now on, on
> systems that don't mark ports as external, or is this a regression?

According to the AHCI specification, a port that is external or hot plug
capable should set the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the
"PORT_CMD_HPCP" bit.

If your platform fails to follow the AHCI specification, then it will need to
be quirked.


Kind regards,
Niklas
