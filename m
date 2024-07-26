Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0381EF01
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992382; cv=none; b=OM0LGlK6L6Ot9I4JM6Xat/BJvtgEjyedCA2kiZHHsO/bMQUpxwG5Iw2egzqLUOFNCU8YZ6hYDeYHoa4+dC7QGxcBRWxLfgjWzKxdaY1JW6IBwraefr42EbqxGPNiBJA/juXrP8qoDJgRoEqtBMwkJi60Zw9KXlVOOXwczDEOgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992382; c=relaxed/simple;
	bh=omLNEqy2qVDST+6W0WlSA04Moo1y1QCbjwqbPzDyHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwueYusnjx9k1FnmbW7UyousomgLEaIzjyNKBZ+qjLeCfJoYXqeO2qdnqkmQAOpAN50WBN5O8ClrwDfe7Fpv3U249V5ofdL8eo4pI/jtQ0LvzB7vL+h95scKI4es8o0VbJ6sAMR6t9EwEU30mNHGlufG9mBiDMExInWjCOh4WmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvRkoHdL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvRkoHdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30652C4AF07;
	Fri, 26 Jul 2024 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721992381;
	bh=omLNEqy2qVDST+6W0WlSA04Moo1y1QCbjwqbPzDyHgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvRkoHdLzbtFptVxUSOuuiGnIsBu6jmukiVINDxLgVT1lVzeS1ZfIa8kcRBTSCoSv
	 C9l7SFMEM7y1yKjpab+aFrO8WrhOF/IkELQ8kxiWuYmAmjLr5CqW4s4W4c0ZqZcgxr
	 BbQL+CLx9U9H/guI81CjLv0qYLVXv/ObOaWjq1Ct+gbBrfLdSJxeDSgp49RP2WJXLX
	 HHMSLYvTcOwhJm1Q5eftG+/py8bPKTar+90RMhALMBFQU35CMeOCNpo/PNdERR1mU7
	 1LxU9YYeEHdvneeDYtni6WDrZigFn97wrnfE3dFMA/U9QtJkHCq+nO5dPN6psLFiNm
	 hFS/POL3deBOA==
Date: Fri, 26 Jul 2024 13:12:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v6 05/11] ata: pata_serverworks: Do not use the term
 blacklist
Message-ID: <ZqOEuvhFko4rhI9X@ryzen.lan>
References: <20240726031954.566882-1-dlemoal@kernel.org>
 <20240726031954.566882-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726031954.566882-6-dlemoal@kernel.org>

On Fri, Jul 26, 2024 at 12:19:48PM +0900, Damien Le Moal wrote:
> Let's not use the term blacklist in the function
> serverworks_osb4_filter() documentation comment and rather simply refer
> to what that function looks at: the list of devices with groken UDMA5.
> 
> While at it, also constify the values of the csb_bad_ata100 array.
> 
> Of note is that all of this should probably be handled using libata
> quirk mechanism but it is unclear if these UDMA5 quirks are specific
> to this controller only.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/pata_serverworks.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
> index 549ff24a9823..4edddf6bcc15 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -46,10 +46,11 @@
>  #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
>  #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
>  
> -/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
> - * can overrun their FIFOs when used with the CSB5 */
> -
> -static const char *csb_bad_ata100[] = {
> +/*
> + * Seagate Barracuda ATA IV Family drives in UDMA mode 5
> + * can overrun their FIFOs when used with the CSB5.
> + */
> +static const char * const csb_bad_ata100[] = {
>  	"ST320011A",
>  	"ST340016A",
>  	"ST360021A",
> @@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
>   *	@adev: ATA device
>   *	@mask: Mask of proposed modes
>   *
> - *	Check the blacklist and disable UDMA5 if matched
> + *	Check the list of devices with broken UDMA5 and
> + *	disable UDMA5 if matched.
>   */
> -
> -static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
> +static unsigned int serverworks_csb_filter(struct ata_device *adev,
> +					   unsigned int mask)
>  {
>  	const char *p;
>  	char model_num[ATA_ID_PROD_LEN + 1];
> -- 
> 2.45.2
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
