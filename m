Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939612D1F4
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301636; cv=none; b=CKMGUY7cSkEFXgZTiRH/Vfv//yYJLDnUcU5bzzB0Pujzem+Ewwu9MA4Zh7XGizzWwOQIhmfxyRrkJU2vq1USmk8DgrPr/As5fAlNX3X5/XdtxxlOW7im93iirJ965x1RoFStwKFIFsik2jW3CCkZBDWRf5NcbESVC+qBU/TmlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301636; c=relaxed/simple;
	bh=CR1Za2JfjNy/F318KAqjkyPZG7f9C4204OODntcPc+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUShGdCoA9H+Evm5eNlixMLp2QdxdAKNz2y/NmRWM8YArHI/1jYluAWYgJVdKZ2qLnrDoDJ2a4t80/B65t62Lua4hxahQFueaRT/THPKx6hqRtReQV5eJ0QGniqjLtjYIUCr3C0A+3xGok+9uvi5BrYm40am34bFWUl+duMlZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt4C7rP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt4C7rP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0930C32789;
	Thu, 13 Jun 2024 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718301635;
	bh=CR1Za2JfjNy/F318KAqjkyPZG7f9C4204OODntcPc+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt4C7rP5CY29g3aSiXsrNZABPlLMD2XI1AM5y9dAbLn5JdjeZ2C6RnctpXJWrQyFo
	 57nXmPxdIyYkizcKOoVjBNCBOR6d9LlNO3znnqt7kun9f3H9TxVYwBKn501aGu+yEV
	 /GkbsSt56g+fGKrR5UmkwxLFXf8fy7XaJhYcW0BYMi+lVIG43ZyWzLFz88Jb1UHxqZ
	 l/LuSaga4lB74RrkBxb9Wx1otCY+LYiJtWh5G8qu23sOoKSs+3OZHa86Y0vb2B2imc
	 DqAlNqZGOR50YKj+SmZV4n2gUYecQdHxRCGZDO4ptjypmG8PV2oE+6Re+03ZyOB+t9
	 56FG0kp1wKcDg==
Date: Thu, 13 Jun 2024 20:00:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <ZmszvPjstgGOCwzp@x1-carbon.lan>
References: <20240613173352.1557847-2-cassel@kernel.org>
 <Zmsv9qPQ3DbuNmVC@x1-carbon.lan>
 <dc23e111-90f4-41df-9f07-00518dd3b439@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc23e111-90f4-41df-9f07-00518dd3b439@t-8ch.de>

On Thu, Jun 13, 2024 at 07:49:42PM +0200, Thomas Weißschuh wrote:
> On 2024-06-13 19:44:22+0000, Niklas Cassel wrote:
> > On Thu, Jun 13, 2024 at 07:33:53PM +0200, Niklas Cassel wrote:
> > > 
> > > This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> > > Expectations" which has since been integrated to SPC, which states that:
> > > 
> > > """
> > > Reports have been received that some USB Memory Stick device servers set
> > > the removable medium (RMB) bit to one. The rub comes when the medium is
> > > actually removed, because... The device server is removed concurrently
> > > with the medium removal. If there is no device server, then there is no
> > > device server that is waiting to have removable medium inserted.
> > > 
> > > Sufficient numbers of SCSI analysts see such a device:
> > > - not as a device that supports removable medium;
> > > but
> > > - as a removable, hot pluggable device.
> > > """
> > > 
> > > The definition of the RMB bit in the SPC specification has since been
> > > clarified to match this.
> > > 
> > > Thus, a USB stick should not have the RMB bit set (and neither shall an
> > > eSATA nor a hot-plug capable port).
> > 
> > Since SPC-6 does make it quite clear that USB Memory Stick device servers
> > should not have the RMB bit set, Thomas, may I ask what udisks is using to
> > automount USB sticks?
> 
> As also mentioned at [0]:
> 
> /* Provide easy access to _only_ the following devices
>  *
>  *  - anything connected via known local buses (e.g. USB or Firewire, MMC or MemoryStick)
>  *  - any device with removable media
>  *
>  * Be careful when extending this list as we don't want to automount
>  * the world when (inadvertently) connecting to a SAN.
>  */
> 
> From [1]
> [1] https://github.com/storaged-project/udisks/blob/8821a7808880ea37cdb299647c38f3a5ceb3d72a/src/udiskslinuxblock.c#L860

Unfortunately I can't find the definition of
udisks_drive_get_media_removable().

But looking at the name, I'm assuming that it checks if the _media_ is
removable, i.e. CD-ROM and floppy, etc., and not if the device is
removable/hot-pluggable.

So I think that the patch in $subject is the way to go.


Kind regards,
Niklas
