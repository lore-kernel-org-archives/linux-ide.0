Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307803;
	b=Rg/zm1NpLXaT+jShOwgmZdCg7xDUgHDSA0Nele4U4eBVYpCEtz11V6NJkPISJ3dN85x4
	 i0bprILzff3Ers1dKfuuElnh+0Beh3TM2d/3QdlzD1wMysZMCdBtwyzAoTVUmxOUWUI1f
	 VxgGurRgsQT/MLc/wZbMnEaGUc6KJ3+u68ELTrrsC4jfdmP7VpM0oCpEDkwrEyz4e6Md1
	 vPvz+FsIoBUzDdsEgS0leMLIt8zEizNWW1g1K8gQKD1BaPae3sgu+ieORlBpss9Px5lI6
	 hMgDx4zIKOn2JmLkzJ4TRMASszUJWdYJCZzenZrQZoMNIIVBKQUx1IHICs00/7NyW1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bPk1bfovMrQzqMiTrMYNCt5DVPkMQCG01pyOU5nTCcQ=;
	b=NRYHD1kingWcjAmjLtakMus/7+DaFFiU/SdMznTg4B+HVVVPjN00zq7HTYSdWpbt0rTP
	 cU1s53XoBLv8qxGkEongG8d3XyppQppckX9oXz2g/NU7MQlElXljcNVaKHLDCqQTVb0XK
	 a58vuHjCTkjUdkigoYhI3Voe7lV4qN1VHyhcQQ/XdRFrQa/36U7lOo/fFSglBY5JExL8g
	 5uDIy2WYycY/Cb618a0GKKbcJlDN/+nx6Nk0FjyHo3kloshIy0JEqfhXBLCEs+utQNPQV
	 bt3fOGC/hguQMnukyIwGT8bSCu6WzdLYlUg91Y7EWj3Wp+QtjSQKo4A43Yr9b4ieNIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gxgsY/mE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4210606A31A;
	Thu, 29 Oct 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxgsY/mE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352D71F01816;
	Thu, 29 Oct 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307802;
	bh=bPk1bfovMrQzqMiTrMYNCt5DVPkMQCG01pyOU5nTCcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxgsY/mEtcQDMWilKYoUvRE5Q96btIKXnI7LUSBtZ58xZLk6nv+9j7NPZDZgvc6nN
	 N4P9hQ0gnBRgZc6K6wmFf92AKJEcw+2fEFixT9++kqwsx4Pf+/A0bW/oaVyaOrXkAl
	 uML464qkFyH2X2188iliQKpPodzyUpKVvXxWgyIY9aPGKT6k7dAUZwu2rpsxKCrR6o
	 5Q5/gFcD0Vtww8gNdAJ/kAyDznwlLMlaj3B1liScS+5Sxw4KTfA21+ksrjOEkZ9xi5
	 3dTA31cm+z356Lt8i3H+TQqZWweex4AACNdT9s9B1izedKR9RaAsaYMABPjPuEeYws
	 L47UDYMhdoDVg==
Date: Thu, 29 Oct 2026 22:03:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, John Garry <john.garry@linux.dev>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: allow re-enabling NCQ with the same
 queue_depth
Message-ID: <auO0lmGIi0AZUH40@ryzen>
References: <20261029184445.1615717-1-ipylypiv@google.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029184445.1615717-1-ipylypiv@google.com>

On Thu, Oct 29, 2026 at 11:44:45AM -0700, Igor Pylypiv wrote:
> When ata_eh_speed_down() disables NCQ due to excessive errors, it sets
> ATA_DFLAG_NCQ_OFF without changing sdev->queue_depth. Userspace can
> re-enable NCQ by writing a queue depth > 1 to the sysfs queue_depth
> attribute, which invokes ata_change_queue_depth() to clear
> ATA_DFLAG_NCQ_OFF.
> 
> However, ata_change_queue_depth() returns early if the requested
> queue_depth is equal to sdev->queue_depth before clearing
> ATA_DFLAG_NCQ_OFF. As a result, writing a different queue depth > 1
> re-enables NCQ, whereas writing the current sdev->queue_depth value
> leaves ATA_DFLAG_NCQ_OFF set.
> 
> Since ata_change_queue_depth() already checks whether queue_depth equals
> sdev->queue_depth before calling scsi_change_queue_depth(), remove the
> early check so that writing the current queue_depth > 1 clears
> ATA_DFLAG_NCQ_OFF and re-enables NCQ.
> 
> Fixes: 45623d33bfc0 ("ata: libata-sata: Improve ata_change_queue_depth()")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
> Commit 45623d33bfc0 ("ata: libata-sata: Improve ata_change_queue_depth()")
> didn't add the first queue depth check, but it changed the return value
> of the second check from -EINVAL to sdev->queue_depth so it seemed like
> a better candidate for the Fixes tag.
> 
>  drivers/ata/libata-sata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 32fd0e804654..d917242ac136 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1287,7 +1287,7 @@ int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
>  	spin_lock_irqsave(ap->lock, flags);
>  
>  	dev = ata_scsi_find_dev(ap, sdev);
> -	if (!dev || queue_depth < 1 || queue_depth == sdev->queue_depth) {
> +	if (!dev || queue_depth < 1) {
>  		spin_unlock_irqrestore(ap->lock, flags);
>  		return sdev->queue_depth;
>  	}
> -- 
> 2.56.0.317.g454f8302e1-goog
> 

You could probably even change you commit message to say:
before 45623d33bfc0 ("ata: libata-sata: Improve ata_change_queue_depth()"),
ata_change_queue_depth() cleared ATA_DFLAG_NCQ_OFF unconditionally:
-       dev->flags &= ~ATA_DFLAG_NCQ_OFF;

So the subject of the patch could theoretically be:
ata: libata-sata: re-allow re-enabling NCQ with the same queue_depth

Perhaps that is too many re-..

Anyway, re-gardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
