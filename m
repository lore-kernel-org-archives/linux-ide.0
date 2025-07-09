Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD9BE4A;
	Wed,  9 Jul 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068876; cv=none; b=qdp8poB44RrxYwpZWfcU+o1Ll5deygu+qNnTZeuHKuO3IeZOCCbkc6068m56UJcaSxbn9jTLt9LMVmkODibOCQHe6vEYreFCH3g0ShVDasMn7ONbu+iwCxyfwWm1uZEhqUyoiLBDiwvjGOxvA2gXZubZVqcraut/AjOTionjN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068876; c=relaxed/simple;
	bh=cwQR1JJ8J9ylqx91mKqrQiGKbvgAcWxX2rgGhJsPHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUj0TR+1VtfMFWhT7OSfzJTOZvpQJKhqFHK6zH3l6fORPpTn7cyUkERgRvUIW1OvB/j/mgmzMUzEyO70Cm1Lu0Qq85/BwMoc0uSG8HzceyQkU6vLAVwL0O288Z0XWwISVaeEY/R+LPR4HFxLIPnK/DXXI9qB7e7wKoYUI2GwunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqbKgTBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqbKgTBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2300EC4CEEF;
	Wed,  9 Jul 2025 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068876;
	bh=cwQR1JJ8J9ylqx91mKqrQiGKbvgAcWxX2rgGhJsPHsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqbKgTBahsrYfRZ/3EXvyQSgufj0K7HkfrN0kwNpshRxqSVkFM2/8v83fosJKySfU
	 PlwIcfzFGVYuQXo+rpBmDclm+uwSxNZn/M84+ij6CeKLyj0deHry89k2yKw+bdfBkt
	 RJyTlRjQVVNmrNzlxm+QkWmkanNzIt01tfIEFyXOd51HOfqAqMnmjl6wE4l6CR+Sm/
	 jsGy1IkHd2xTUJFRO5ej/sZSs6VZRDou5qQJzTWb0T6+tFAuHe5eailw4H1umiA/Kw
	 qURf9JtC/WSkI43cfCySUtEqzgJvf1ghfaTz3SFqgxTCT87xr03HXSDwbd4sovu8qn
	 weEi6WxgsDAAw==
Date: Wed, 9 Jul 2025 15:47:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jonathan Velez <jonvelez12345@gmail.com>
Cc: dlemoal@kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] ata: libata-transport: replace scnprintf with sysfs_emit
 for simple attributes
Message-ID: <aG5zCBjpOuwFs5mh@ryzen>
References: <20250709133330.3546-1-jonvelez12345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709133330.3546-1-jonvelez12345@gmail.com>

Hello Jonathan,

You forgot to use -v 2 to git format-patch (so that v2 is in the subject),
and you forgot to add a changelog (changes since v1) after the '---'.

No need to resend, but until next time.

Thank you for your contribution.


Kind regards,
Niklas


On Wed, Jul 09, 2025 at 01:33:30PM +0000, Jonathan Velez wrote:
> sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE maximum
> of the temporary buffer used for outputting sysfs content and they may
> overrun the PAGE_SIZE buffer length.
> 
> To avoid output defects with the ATA transport class simple attributes,
> use sysfs_emit instead of scnprintf().
> 
> This aligns with the sysfs guidance provided in
> Documentation/filesystems/sysfs.rst.
> 
> Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index e898be49df6b..62415fe67a11 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -202,7 +202,7 @@ show_ata_port_##name(struct device *dev,				\
>  {									\
>  	struct ata_port *ap = transport_class_to_port(dev);		\
>  									\
> -	return scnprintf(buf, 20, format_string, cast ap->field);	\
> +	return sysfs_emit(buf, format_string, cast ap->field);	        \
>  }
>  
>  #define ata_port_simple_attr(field, name, format_string, type)		\
> @@ -389,7 +389,7 @@ show_ata_dev_##field(struct device *dev,				\
>  {									\
>  	struct ata_device *ata_dev = transport_class_to_dev(dev);	\
>  									\
> -	return scnprintf(buf, 20, format_string, cast ata_dev->field);	\
> +	return sysfs_emit(buf, format_string, cast ata_dev->field);	\
>  }
>  
>  #define ata_dev_simple_attr(field, format_string, type)		\
> -- 
> 2.43.0
> 
