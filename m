Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C1144D35
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300987; cv=none; b=AbhCp7dZxMHp9nRK7Pq0Fd9NRZSCfRxvIYFERPhVSGSLZ2JGp8anZ9wfj7vFvj6dfD4rkuNaa8LqrwqpeG8g6uW8oRObWxkwMW8Ob86+9qIiYYlkDzV6fPgrzzfMiG46lKWd3yvcMsluUg4ZGgVBbUO+lO+7a4Riw2FpT7OYMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300987; c=relaxed/simple;
	bh=5VFTBB5Y024Z/dfXPaWR2vC0De9nALfe7DgBcGM6dsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtv74ax+nLT1Tpmon8wvrWcnTqrnQEaUpV3nyLXEFfYGLLSvQSPTzfIMChqZzt6mcBR2CxSOWzhbVdaw5hFDKYls4ICDqMOeNX3dwIGuwfVcSRQgiIbJlba1XM6Ucg320BjBCLUzbqRxIuiENwZ10DoUldDaex72jfC3kkylqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j9EcOFP/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j9EcOFP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718300983;
	bh=5VFTBB5Y024Z/dfXPaWR2vC0De9nALfe7DgBcGM6dsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9EcOFP/oSnBhUNX7q8GkDqcHb0ZFFBbOK+5jCOPt1eUu+v056wYyWtBh8XDp2VLT
	 Hq3TYSjeUOsUFU7tiuw95MBMavlTxD4qz4ZB3jcmWVMJv/Gpnkd6oGQ09E0cbE1qkm
	 +7JgaugYamIkphg6cfVKciR5seVjYjlsweB0E770=
Date: Thu, 13 Jun 2024 19:49:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Manuel Lauss <manuel.lauss@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
Message-ID: <dc23e111-90f4-41df-9f07-00518dd3b439@t-8ch.de>
References: <20240613173352.1557847-2-cassel@kernel.org>
 <Zmsv9qPQ3DbuNmVC@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmsv9qPQ3DbuNmVC@x1-carbon.lan>

On 2024-06-13 19:44:22+0000, Niklas Cassel wrote:
> On Thu, Jun 13, 2024 at 07:33:53PM +0200, Niklas Cassel wrote:
> > 
> > This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> > Expectations" which has since been integrated to SPC, which states that:
> > 
> > """
> > Reports have been received that some USB Memory Stick device servers set
> > the removable medium (RMB) bit to one. The rub comes when the medium is
> > actually removed, because... The device server is removed concurrently
> > with the medium removal. If there is no device server, then there is no
> > device server that is waiting to have removable medium inserted.
> > 
> > Sufficient numbers of SCSI analysts see such a device:
> > - not as a device that supports removable medium;
> > but
> > - as a removable, hot pluggable device.
> > """
> > 
> > The definition of the RMB bit in the SPC specification has since been
> > clarified to match this.
> > 
> > Thus, a USB stick should not have the RMB bit set (and neither shall an
> > eSATA nor a hot-plug capable port).
> 
> Since SPC-6 does make it quite clear that USB Memory Stick device servers
> should not have the RMB bit set, Thomas, may I ask what udisks is using to
> automount USB sticks?

As also mentioned at [0]:

/* Provide easy access to _only_ the following devices
 *
 *  - anything connected via known local buses (e.g. USB or Firewire, MMC or MemoryStick)
 *  - any device with removable media
 *
 * Be careful when extending this list as we don't want to automount
 * the world when (inadvertently) connecting to a SAN.
 */

From [1]

> Since USB sticks that follow SPC-6 clearly cannot have RMB bit set,
> which means that SCSI core will set removable:
> (the equivalent of:)
> /sys/devices/pci0000:00/0000:00:04.0/ata3/host2/target2:0:0/2:0:0:0/block/sda/removable
> to 0.

(I am not a udisks person, but we have the same problem in lsblk
regarding "RM" and "HOTPLUG" attributes)

[0] https://lore.kernel.org/all/6d5e7f17-6760-4128-a5d5-22ae2a87dadf@t-8ch.de/
[1] https://github.com/storaged-project/udisks/blob/8821a7808880ea37cdb299647c38f3a5ceb3d72a/src/udiskslinuxblock.c#L860
