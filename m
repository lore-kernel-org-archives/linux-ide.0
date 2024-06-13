Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537111304BF
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299994; cv=none; b=UeTXjYvoyEhAXohkPRNpOwymp/naumeM0Jc1lsNPhzc+8TbKpoL7xj/Rcx8HCsWorARnke8lMZZpsAdBGpdzVzH8xkT9e2H7Hlt+3yJ0nu5WAgVAV1uoqlp/tDyPncarUjm96Pb/G+5QC8kpdWMFmpIl14NYsbCIOgB682350pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299994; c=relaxed/simple;
	bh=se00bxHIpfHMjBSUhjhCAjkYsRgd2/87X9TvoM1lLho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7WJTN7n3eGLyqtZ0f1deMNAjkumPDRCzsbEBUDaG4LCvsLpBjaZP+92soqp2QAqpUm87QI3MQkxiSQKcfOHSXTtaOTVK22D1OmFSc+uA0+DESTGDvE5oeTflnMUnWSbXOrFUdOvMNKn+iX8KHM4G/gul1ka2jVmf2Kj7YouqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JLM9oRYe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JLM9oRYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718299990;
	bh=se00bxHIpfHMjBSUhjhCAjkYsRgd2/87X9TvoM1lLho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLM9oRYetfVhDBVZkL5Fceh0pzogmoIH8AmytzyaSN8SrsuHUAnDRvumwURYrFC8u
	 A67zl+8eQCcuiENOKHITn3zYO8lEWlEQkIvubKI3qLfgl37VFvyTUd+TQcwa+0Rz98
	 afAhiJVjvsO18WRgSDWRVBMxxsfjn2hFxbPX1yDM=
Date: Thu, 13 Jun 2024 19:33:09 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jian-Hong Pan <jhp@endlessos.org>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <6d5e7f17-6760-4128-a5d5-22ae2a87dadf@t-8ch.de>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
 <ZmrwksRyOkQq1OPV@x1-carbon.lan>
 <Zmr2a53RwyevjQYA@ryzen.lan>
 <10f95864-3674-4c69-8abf-d4b9f56f9ec4@t-8ch.de>
 <ZmsST1kF34A9f4-y@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmsST1kF34A9f4-y@ryzen.lan>

On 2024-06-13 17:37:51+0000, Niklas Cassel wrote:
> On Thu, Jun 13, 2024 at 04:49:43PM +0200, Thomas Weißschuh wrote:
> > On 2024-06-13 15:38:51+0000, Niklas Cassel wrote:
> > > On Thu, Jun 13, 2024 at 03:13:54PM +0200, Niklas Cassel wrote:
> > > > On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
> > > > > On 6/13/24 15:34, Thomas Weißschuh wrote:
> > > 
> > > > I suggest that we:
> > > > 1) Merge Damien's fix.
> > > 
> > > This might of course result in us getting other bug reports about their
> > > distro no longer automounting their eSATA devices... and they might
> > > consider that a user space regression as well.
> > > (Since that behavior has now been there since 8a3e33cf92c7 ("ata: ahci:
> > > find eSATA ports and flag them as removable"), which was merged in 2015.)
> > 
> > This is quite likely.
> > 
> > How about reverting the "ata: ahci: a hotplug capable port is an external"
> > for now and work on a proper fix, including dev_set_removable() for an
> > upcoming release?
> 
> Perhaps I'm missing something here, but how will dev_set_removable(),
> which sets a different sysfs attibute solve that "problem"?

Indeed, it finally won't help.
But only reverting that single commit should minimize the impact on
users and give time to work on and discuss something better.

The real solution then has time to go through a proper release cycle.

> I think that dev_set_removable() can be added as a follow up patch, since
> IIUC it has nothing to do with your bug report.
> 
> Calling dev_set_removable(.., DEVICE_REMOVABLE) should simply mean that
> the sysfs removable attribute ("fixed"/"removable"/"unknown") will be
> correct, so lsblk sees the device as hot-pluggable.
> But AFAICT, udisks will not automount the device just because the removable
> attribute is set to "removable". You seem to be familiar with udisks,
> is this understanding correct?

From src/udiskslinuxblock.c:

  /* Provide easy access to _only_ the following devices
   *
   *  - anything connected via known local buses (e.g. USB or Firewire, MMC or MemoryStick)
   *  - any device with removable media
   *
   * Be careful when extending this list as we don't want to automount
   * the world when (inadvertently) connecting to a SAN.
   */

(Local policy can override this either through "noauto" in fstab or the
UDISKS_AUTO udev property, but I'm not very familiar with udisks)

> To be honest, I think that it is wrong to automount devices just because they
> are hot-plug capable. eSATA and hot-plug cable ports are according to the
> specification both external ports, and eSATA ports are also hot-plug capable.

Agreed, as does udisk.

> I guess you could trigger on an uevent if a device is attached after boot,
> but automounting a device during boot seems wrong to me.
> 
> Regardless, it seems quite clear that the RMB bit should not be set for
> neither eSATA nor hot-plug cable ports.

Ack.

Thanks,
Thomas
