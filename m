Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B212D757;
	Thu, 13 Jun 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293077; cv=none; b=O3nalRKb6nI3XObCbWNnoKlv/vFqnDnSjJDdEu15SWB0D1hAlkIDMThDdRTjzrz8DsCBClAHyUvpSapG/tMo8KC4CLPpuTPAQtn1Esxxic6njU3O/dcVG4WBfl1l5dgK0TVmaS4oYIa6CiZSX7vMymqiLsBLh4titUGv+y+46Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293077; c=relaxed/simple;
	bh=5sMNBhhofjUSwHwpCJHYz47k8DQ3iDJTNvlik1g0nqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM8fIrgsk2XcQnHCfUpVZ5RZ8wI74MeNJFycbCaVUKSN/ofLWDom0HuyMEz+DAYmbTDSTiX4c0L9K+1WlHiRVpTzL2mHJ/1OPWzIaLT6oT9Mh0SxJHzisLFv8Y6hIvg78diIPHDOiqnXMLLnExxFbKLWIowM5oj6g1nZqCMMvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy/WTWso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy/WTWso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E0C2BBFC;
	Thu, 13 Jun 2024 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293077;
	bh=5sMNBhhofjUSwHwpCJHYz47k8DQ3iDJTNvlik1g0nqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy/WTWsosZ2VmESS+e0pS3JalFj3xGQk/2AbZZCF+f4wCm9ra12XjkBgeKgQNQ7nf
	 7IsDahl09exPcNuJksaiDf+YB0jfnmzU0pCWUiCRp07Dacwv9M062f+TiSvSwTUTKA
	 X+TMOgOAXAxpDlIj01zGYu8DMErsdPK+af1h3z9/mAHBF4uaKYcKiBjndea9vIQ3pS
	 GyMlCU+Uw6mdy+UYXCS98Nqm3x/Sw9vY8luFWHWHDMOHqPgjzxquGdGiS9OjVxg1bo
	 Rey8oFwCVwai+58R1MalMI6MvutBgzwCjk8HSVstWIeq9cekfcgyki5NcwseeSyLA+
	 PYsz+aO30GXkw==
Date: Thu, 13 Jun 2024 17:37:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <ZmsST1kF34A9f4-y@ryzen.lan>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
 <ZmrwksRyOkQq1OPV@x1-carbon.lan>
 <Zmr2a53RwyevjQYA@ryzen.lan>
 <10f95864-3674-4c69-8abf-d4b9f56f9ec4@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10f95864-3674-4c69-8abf-d4b9f56f9ec4@t-8ch.de>

On Thu, Jun 13, 2024 at 04:49:43PM +0200, Thomas Weißschuh wrote:
> On 2024-06-13 15:38:51+0000, Niklas Cassel wrote:
> > On Thu, Jun 13, 2024 at 03:13:54PM +0200, Niklas Cassel wrote:
> > > On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
> > > > On 6/13/24 15:34, Thomas Weißschuh wrote:
> > 
> > > I suggest that we:
> > > 1) Merge Damien's fix.
> > 
> > This might of course result in us getting other bug reports about their
> > distro no longer automounting their eSATA devices... and they might
> > consider that a user space regression as well.
> > (Since that behavior has now been there since 8a3e33cf92c7 ("ata: ahci:
> > find eSATA ports and flag them as removable"), which was merged in 2015.)
> 
> This is quite likely.
> 
> How about reverting the "ata: ahci: a hotplug capable port is an external"
> for now and work on a proper fix, including dev_set_removable() for an
> upcoming release?

Perhaps I'm missing something here, but how will dev_set_removable(),
which sets a different sysfs attibute solve that "problem"?

I think that dev_set_removable() can be added as a follow up patch, since
IIUC it has nothing to do with your bug report.

Calling dev_set_removable(.., DEVICE_REMOVABLE) should simply mean that
the sysfs removable attribute ("fixed"/"removable"/"unknown") will be
correct, so lsblk sees the device as hot-pluggable.
But AFAICT, udisks will not automount the device just because the removable
attribute is set to "removable". You seem to be familiar with udisks,
is this understanding correct?


To be honest, I think that it is wrong to automount devices just because they
are hot-plug capable. eSATA and hot-plug cable ports are according to the
specification both external ports, and eSATA ports are also hot-plug capable.

I guess you could trigger on an uevent if a device is attached after boot,
but automounting a device during boot seems wrong to me.

Regardless, it seems quite clear that the RMB bit should not be set for
neither eSATA nor hot-plug cable ports.


Kind regards,
Niklas
