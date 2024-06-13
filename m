Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE072441D
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300668; cv=none; b=lqAMpaqTm0qytC97bo5VrV/q8LdI2vDwovHDAukGH/wBqq0djKiIHaxvOqtPmKoYHW55EsDxdUKG6h/HaqLbuP9TQfI//IxIu1xlisZYdCKueIfmfsnq5fXRyL3HUi407RFWRX9SF/6ORC7RDTkOdd7Gqaj2keLt+6o3iz517Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300668; c=relaxed/simple;
	bh=+FE6R8XTbor5Z2wm4+XcHz4cHl/jpOVcrsTVc8sb2ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWYpVRyY8ppNPnO4+mNXv2wJ1epYM8B3cwM4yeyYVghtwHkk2RiWluPI1kF79AQJhwKCK6aYHbWFyCuMnzXdodhcwRYuo308Mv8AJp35MYQ0LRjE1Samcr4K0EaIUW31gKcPle09x8YnOI9m5x4SJ3RQRnZUpByBegtr7JLCWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnWcGCUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnWcGCUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3480CC2BBFC;
	Thu, 13 Jun 2024 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300668;
	bh=+FE6R8XTbor5Z2wm4+XcHz4cHl/jpOVcrsTVc8sb2ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnWcGCUnoG0MNfhpQO8Zc97gnK1xhMBznSKShPlVM1kNGu4eUbO8ABXOE7W8PUoQN
	 PxrA1eQuFtBcX8lTbIhqAq4EGtzQAmR/EKhZ9dlzE0BwWkjI2hUvypha7gjYLuAOBX
	 Ro1Vwns4h6nqS5qHF2HGl+UtBGSescRLzWRqikJCi7BwL96T0eTW2oBXywyIyBbFQY
	 69CqgZptSZj0pEvcipjoNPTly7czd/el1rUZQpMYSDpRK3D0D4Fj5KR46cftG5MyiX
	 usq+XjDtwTDcceMdoo6O70B2t02TTstl4GlP5NSNf7UOOWNpXzwRQNDuIaSZv9fceu
	 XiaIfqXbLayhw==
Date: Thu, 13 Jun 2024 19:44:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <Zmsv9qPQ3DbuNmVC@x1-carbon.lan>
References: <20240613173352.1557847-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613173352.1557847-2-cassel@kernel.org>

On Thu, Jun 13, 2024 at 07:33:53PM +0200, Niklas Cassel wrote:
> 
> This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> Expectations" which has since been integrated to SPC, which states that:
> 
> """
> Reports have been received that some USB Memory Stick device servers set
> the removable medium (RMB) bit to one. The rub comes when the medium is
> actually removed, because... The device server is removed concurrently
> with the medium removal. If there is no device server, then there is no
> device server that is waiting to have removable medium inserted.
> 
> Sufficient numbers of SCSI analysts see such a device:
> - not as a device that supports removable medium;
> but
> - as a removable, hot pluggable device.
> """
> 
> The definition of the RMB bit in the SPC specification has since been
> clarified to match this.
> 
> Thus, a USB stick should not have the RMB bit set (and neither shall an
> eSATA nor a hot-plug capable port).

Since SPC-6 does make it quite clear that USB Memory Stick device servers
should not have the RMB bit set, Thomas, may I ask what udisks is using to
automount USB sticks?

Since USB sticks that follow SPC-6 clearly cannot have RMB bit set,
which means that SCSI core will set removable:
(the equivalent of:)
/sys/devices/pci0000:00/0000:00:04.0/ata3/host2/target2:0:0/2:0:0:0/block/sda/removable
to 0.


Kind regards,
Niklas
