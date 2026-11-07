Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060416;
	b=TtLVBuSgni9OLh7iwSkdRRulGmDnmFX4kXTbsxEbDEGv/LJobe9JgGVHypAc/zOXDaYS
	 8cFZyxmS6PU+FaIGtPCMk+GE5k/KBDHNu0231O080wyY10EA5xZttlzeqwFvWeS9MWXI4
	 W5FvNDvk/qC1FYZco2iMg8q+049302C6tgkATmho/egQ/bdW8YIGMOMGg50jtPnKZmurF
	 hCGGRYifOriHKyWavGBtDRYnL+JJswYK4ILAlIbGL/2Yv0Bcr+iPGo26RcAWfPjekZANs
	 4CWjjwFe81R/r5WkmdJvCyfqjn+xbuZEOyU17R6BgsNE+vMPDTSDrth3PTVP3nVM0kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fYgcH8z7Z9gm+LGe8AyWBlt9UWfGFFAiVOn5DT/UzGY=;
	b=3oDZm6r27lb1MWjgPvFlsyGlP5LCAVO1QAg68i6uO86vy4bvaXVj7gB7YiQbe+Aiu6/V
	 FA4gJqvd3DCGE0Ena39C5rl/jyc7D0WrUc90Fs8HkaFRtwKsiJDR9YDo0ZQirvZ2P6hBX
	 Gb05NOviXiSOEno3pazgCd+PCijPnc0InQdeHJaU5FEF5vrClpR2KL83UOxNjHKNjbtIp
	 GoU9TJ5TIMTSKDkUam2zdIAsZFBKXJZxN0Uj81XQF3L5VMYFefMv2N27CTJdbXUJsw2GK
	 9jn4syQCabgi7L+/Z3ji/Fz5z1BQSUZGnAMAGRS0VSbUhH4pq9yOsGEBEDw54LSlFaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp1QqCtU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A155606A326
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp1QqCtU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2209C1F0089F;
	Sat,  7 Nov 2026 14:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794060415;
	bh=fYgcH8z7Z9gm+LGe8AyWBlt9UWfGFFAiVOn5DT/UzGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gp1QqCtU87E8u+TKsexPKcugRz3Shw2Tc1K4fdGZKu2q70RNgKjuLEXBPlUA6/Fq2
	 cyEHRyi8dI6GIe0EyjSRXmwtNfii7c4ZpMXDSBk7vVt+4NPq1RKlkqJDjzW0YID4ha
	 MDKgulHtMeMVbr3tCDBeLlFc5E9a+AgiK6BkQFVDI5sCrHsfgayH+cUWRKNPWKRXXu
	 OdpLNXyyUNO7MMfgN4GFs+P/vNX9mHKQW90kpW0e2huv8oahu08rWLdUv6Aq9Vxrx2
	 T4UuuTehymaQrboy2yxZTGgpfr09EiDRoQVGubm3FqoR08AGpc82oERdoZQp0j9+j+
	 K4DfLgFrBAgqA==
Date: Sat, 7 Nov 2026 15:06:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Vignaud <tvignaud@redhat.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NOLPM/NONCQ/1.5Gbps quirk for PNY
 1TB SATA SSD
Message-ID: <au8wfDKEh9Nzt3D0@ryzen>
References: <[PATCH]ata:libata-core:AddquirksforPNY1TBSATASSD916a>
 <20261028145535.623209-1-tvignaud@redhat.com>
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
In-Reply-To: <20261028145535.623209-1-tvignaud@redhat.com>

On Wed, Oct 28, 2026 at 03:54:34PM +0100, Thierry Vignaud wrote:
> Without that, I get the errors below.
> For a year, I workaround it by disabling NCQ & reducing the speed by
> booting with "libata.force=1:3.0Gbps,1:noncq".
> It tried out disabling LPM only but I was still able to see errors.

The body should be readable without the subject, so please
rephrase "Without that,".


>
> Related: bko#222187

If you want to reference this, use the Link or Closes tag, e.g.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=222187

See:
https://docs.kernel.org/process/submitting-patches.html


> 
> v3:
> - add firmware revision check
> v2:
> - remove firmware revision from SSD name
> - drop speed to 1.5Gbs (as there's no 3.0Gbps quirk)
> - disable NCQ altogether (else we still see the errors from times to
>   times)

The changelog should be after the "---" line, before the diffstat, see e.g.:
https://lore.kernel.org/linux-ide/179405688421.943559.6118296661484264171.b4-ty@kernel.org/T/#t


The patch is missing v3 in the subject, so right now it has the same subject
as the previous patches, which is incorrectly putting all versions is the same
thread:
https://lore.kernel.org/linux-ide/CAHSMvrFXEnsLKF_BSYWz=V=ht6++RocuHJO0tkhUmPcHHvXp5A@mail.gmail.com/T/#t

You need to generate it using e.g.:

$ git format-patch -v 3

Which will generate the proper subject.


> ---
>  drivers/ata/libata-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index dadcaf9ff462..cde9d367c20f 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4398,6 +4398,13 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>  	/* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIPM */
>  	{ "PNY CS900 1TB SSD",		NULL,	ATA_QUIRK_NOLPM },
>  
> +	/* PNY CS900 (variant) drops the link on DIPM and NCQ
> +	 * This covers only the 1TB variant but other sizes are affected
> +	 * according to forum posts */
> +	{ "PNY 1TB SATA SSD",		"H220916a",	ATA_QUIRK_NOLPM |
> +							ATA_QUIRK_1_5_GBPS |
> +							ATA_QUIRK_NONCQ },

Does this drive really need 1.5 Gbps quirk?
Right now we only have 2 drives with the ATA_QUIRK_1_5_GBPS quirk.

Ideally, it would be nice if we could just have a single quirk.
If for some reason a single quirk is not sufficient, then two quirks
is fine... But three quirks?

I'm not saying that it is impossible, but it is very rare that we have
seen a drive that requires three different quirks.


Kind regards,
Niklas
