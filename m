Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6A76056
	for <linux-ide@vger.kernel.org>; Tue, 27 Aug 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750467; cv=none; b=OlQ+V3jbRMLMGJqd7whNsrm13eN4u+TZedffmDBsCFO5EW7o3JnG50hq05qAHZu9MvfWwnzIT80melhsX1/O4MdL16zzSuU26B/GyrYgv6zcYNsPqqem1wVD0JHsuGmi7tLPAafKEiKohfSJJ13nzIO9RUPNw5kwVdXJe+mSllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750467; c=relaxed/simple;
	bh=ORjUxBAxE6n6Otau6MRXK2vZQNW5VVzsdI95kyRFVRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I88eCqR3LV/M6Six/gSQki9GvSOKuObno+lMdwhlMNASd/oSClKbZ8fYADlgmTJPedP9VqNQbEaw904q1B0dkkCTFmYPTp/1/AvYY/2NDaAO5aGJW0au/CtXqW07uWgGFw/w3IbDTrGkDaLS5Hc7/uqKHk5Itd7C9+41meSyRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzfYlnxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzfYlnxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F83C8B7A0;
	Tue, 27 Aug 2024 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724750466;
	bh=ORjUxBAxE6n6Otau6MRXK2vZQNW5VVzsdI95kyRFVRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzfYlnxJbcNk+CSz8pwZRdXdweUycXq1i6ZOvEH7QnqzH37xywpsjPRreNLfM0dJ5
	 niY51mgUxNIYEhjeheR1p5tpgrcEsBLnZg8mXWMKs4PeLvtzTHNkyMXTCF8PncmvJP
	 GcfzeaA202rbLs5WUYJHycHee9Ck2cIL0hjZHTQ0Boi1q6WBxS3F6qx2StJeSJ06Fs
	 j3G8f2dfZ8J+02Az+FvcUkkoQymj59NGz/RBxxM8PEk9DsXz+Z+vk8873p+fGem6AW
	 xUrmELZCUv/HV1aFwC1jjZKJgXr0i/rmfH8MVJ0QWANxPNI9DZokDt7oPYlHhbR84m
	 fSDdz+594pt4g==
Date: Tue, 27 Aug 2024 11:21:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 6/7] ata: libata: Move ncq_sense_buf to struct ata_device
Message-ID: <Zs2afyKxAtLp1xcw@x1-carbon.wireless.wdc>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-7-dlemoal@kernel.org>
 <ZsyVqTYDDNwGDCoo@ryzen.lan>
 <b0f21e36-d29b-489a-9df8-83493d3992bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f21e36-d29b-489a-9df8-83493d3992bc@kernel.org>

Hello Damien,

On Tue, Aug 27, 2024 at 04:50:14PM +0900, Damien Le Moal wrote:
> On 8/26/24 23:48, Niklas Cassel wrote:
> > On Mon, Aug 26, 2024 at 04:31:05PM +0900, Damien Le Moal wrote:
> >> The ncq_sense_buf buffer field of struct ata_port is allocated and used
> >> only for devices that support command duration limits. So move this
> >> field out of struct ata_port and into struct ata_device together with
> >> the CDL log buffer.
> > 
> > The ncq_sense_buf buf is currently only allocated if the device supports CDL,
> > so the currently extra space that we take up in struct ata_port, for non-CDL
> > devices is just an empty pointer.
> 
> No, we have cdl descriptor log page buffer (ap->cdl) which takes
> ATA_LOG_CDL_SIZE (512 B). Furthermore, thinking of this some more, having that
> buffer attached to the port is totally wrong if we are dealing with a pmp
> attached device: we can have multiple devices supporting CDL that will all end
> up overwriting that buffer. So this is actually a bug: either we move the cdl
> log buffer to ata_device, or we must not probe for CDL in the case of a PMP
> attached device. The latter is fine I think as CDL is really an enterprise
> feature that is very unlikely to be used with consumer PMP. But the former is
> more logical.

I think you are mixing things up, we don't have any ap->cdl.

We have:
1) ap->ncq_sense_buf	(u8 *ncq_sense_buf)
2) dev->cdl		(u8 cdl[ATA_LOG_CDL_SIZE])
3) ap->sector_buf	(u8 sector_buf[ATA_SECT_SIZE])

I do not think there is any bug in having ap->ncq_sense_buf in struct ata_port,
like the code currently does, because like you say, we currently only fetch the
Successful NCQ Commands log from EH context, so this should be safe even when
using PMPs.

For dev->cdl, it is currently in struct ata_device, which is correct, because
as you say, caching the CDL descriptor log page in the ata_port would not be
correct, since it could then get overwritten by another device if using a PMP.
(Changing this to be dynamically allocated would be a nice optimization.)

For ap->sector_buf, I suggested to perhaps move this to ata_device, such that
the ata_read_log() functions (which already take a ata_device as first
argument) do no longer need to take a "buffer" argument, the buffer could be
derived from the ata_device if we move the buffer there.

If we move ap->sector_buf to struct ata_device, then I think that it makes
sense to also move ap->ncq_sense_buf to struct ata_device.


Kind regards,
Niklas
