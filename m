Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488133;
	b=2LTk640gnHBkLaLuzA0DKLUN0FoB0FxqHGXlssQMj2BBQLQAlqvdn4Ujwg7YQcw5e7I2
	 NOzg4JG/sQ4QseSD87pjBoKvZjLTbhfVfweNX4+EwoA4IuJF8QX5cWIVupGyzgR3OU8IX
	 AE+RdBpOogiYV5Fb9yhvd+wzF94kwExg4r4w6Fj8W14zO0qrbJdGn68u9E3LYPGQavYFw
	 rOsxCBEkNWP0HzjiHUAQNwqexV+UObxv4seQqm4hvj7J0VJjJ3WjWSpNqzTdaDDFBIFwf
	 l/ClPAQQ6lQK90e/ULhuNo8RaQjBrdlwOgLQ9Kg7GU/UUBoEB4CN6cCMfpnMB17eO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488133;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s/zA3YcFfeGWk3+2Ani1rFAk8ESOlZTdIxrX6Wm8QKc=;
	b=vALNs4Ahm9dPZCfz2jvnDfmlXj7jq9oZXD7T3DVu+n1jfdjC9lYYk/ATDoJ8JFjn44Kn
	 6xeI02ojlPbdswFknXSOI8hoc2LJC7mdCZqus4BSavE0659duXCr0Dfmllzvhpy2iU2F2
	 4re16PQoHfCwEXyw4qL1P48fzktE52TU6x4lgkYN76zfKfVUMsXOckqqRDOLvBiBBI7ka
	 BiGYGnmnlnFT5U1BsNabzJmKmmpF5jZIE6ITnSOnSnjKDOJzmMVqOav9EZW+Qu9dsRoqE
	 IZu5DJDjxfDYyFGW85X3EVbik5VdirU5P7zvL+EDjCkAuidtUCvMTNIuPwmKZYg6vNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RznHr0A1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D7606A319;
	Tue, 20 Oct 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RznHr0A1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33BD1F000C4;
	Tue, 20 Oct 2026 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488133;
	bh=s/zA3YcFfeGWk3+2Ani1rFAk8ESOlZTdIxrX6Wm8QKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RznHr0A1xXF5rTgYtknLygpc+SK9T9FFaCjbAz3fVoZGx91ho9F/cLBsD5wKs3xMi
	 jZu28V/xzO3gT1fxVGq7a9lH1TDL68xiu4pYyFp504NRM35slx1BYA2xu2HNuXgCCP
	 onK51xBhG+zGBAtv8bIqjyHO3/tfVbd22FsGF9MrCKouuiweN9ZQYLdfsjNPx1g3IG
	 ssFviSWGgFz6BKTDPIC3WQ7JV4A16mGTAs3C8hUvCN9SvO26NPoWQdOnfGQPqLhyHe
	 KN8OX1AFNbs8snxy6t+UaAkg8KShpLzWzr9/dz1KGajA1ajFUF8ydFwNZX/7T4liMM
	 I6av/5B/MJp8A==
Date: Tue, 20 Oct 2026 11:22:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org,
	linux-kernel@vger.kernel.org, yang.tao172@zte.com.cn,
	zhang.yue5@zte.com.cn
Subject: Re: [PATCH] ata: libata-eh: =?utf-8?Q?drop?=
 =?utf-8?Q?_redundant_ata=5Ftag=5Fvalid=28=29_check_in=C2=A0ata=5Feh=5Fmay?=
 =?utf-8?Q?be=5Fretry=5Fflush=28=29?=
Message-ID: <atcywY0eDL8h4QeD@ryzen>
References: <20261020160101007xAtLUWDrReLsKCbDsa5eu@zte.com.cn>
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
In-Reply-To: <20261020160101007xAtLUWDrReLsKCbDsa5eu@zte.com.cn>

On Tue, Oct 20, 2026 at 04:01:01PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ata_eh_maybe_retry_flush() validates link->active_tag with ata_tag_valid()
> before calling __ata_qc_from_tag(), which itself evaluates ata_tag_valid()
> on the same tag and returns NULL when the tag is invalid.
> 
> Since the NULL return value of __ata_qc_from_tag() is the single source of
> truth for tag validity, drop the redundant explicit ata_tag_valid() check
> and simply return early when qc is NULL.  This mirrors the style already
> used in ata_eh_get_non_ncq_success_sense().
> 
> No functional change.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>
> ---
>  drivers/ata/libata-eh.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index c93c24b22d9c..bf3313175a97 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3571,11 +3571,9 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
>  	unsigned int err_mask;
>  	int rc = 0;
> 
> -	/* did flush fail for this device? */
> -	if (!ata_tag_valid(link->active_tag))
> -		return 0;
> -
>  	qc = __ata_qc_from_tag(ap, link->active_tag);
> +	if (!qc)
> +		return 0;
>  	if (qc->dev != dev || (qc->tf.command != ATA_CMD_FLUSH_EXT &&
>  			       qc->tf.command != ATA_CMD_FLUSH))
>  		return 0;
> -- 
> 2.27.0

We are in the middle of the merge window, and since this is not fixing an
actual problem, I expect this to be queued on for-7.5 once 7.4-rc1 is out:

Reviewed-by: Niklas Cassel <cassel@kernel.org>
