Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056351FCB9
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651114; cv=none; b=iKxE5ihBpQt032epcwSByFhuG2LNf1mn96DQsE5rO+/QNeIS2kFmmbpcxk4w75mAFVK540RVRoNXGVc87rhpiDgZPg+edXo4dypa/R+erHaLUK4gP/CVt7fLnVhYabDCU3IePKaiad/sG57adwpqjdg/rHpn95EdnPTTB1Wk9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651114; c=relaxed/simple;
	bh=WVKQWmFuFU/+mSK7+I6kEcsL2pqT1YOX+3YB+tf0wM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTqI0o6T9R89e++IStCdiuUa2q8qcsSVvML9m9S9IC1/+KR7pI1Biu+a2PNgGMZSJlFlK+W1V+wsYh5tTED/h1lXDu134Qa1BYSKzutKP141gR+dtR8UJXfY3h7ng6MPu+wBTkh1GevbtT0ADTgO1YaDGEaqzloTYAb8FqhrjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftF4XCW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftF4XCW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C5C1F000FF;
	Thu, 17 Sep 2026 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651112;
	bh=FeKHOmc1wTJuCL9diRmizOZS4kHKsRq0s9/uB16+A3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ftF4XCW4jlprzb9ciVTP1UivygxbezCiVqW+yz4fwS7KMc502ktvCMKz4w1xVtEel
	 i45hnQq4fKbMyKptijFCA6/CmKOorevk7iVRhTqr2MMxmdzLBpk+laVBEukeNOQ2sF
	 YniC7vC+HeO0kXEO5L7I3h+t6bPUaKGBBQ6uqgOxqGETFY1s6TAYmdGukWz3ndwKmr
	 jqBr4eVQIo1pQdNgMNQwiTPesJ77EJmX6/MQu1+fwzMRcnslFyuMFD6YKBmw2Xy3wU
	 khXgpwfaQY6lnMHGyQ5SMp1NU71t4rmH2RbqYdoY3ZIYO/d7+41w1s862wS7DgVdY8
	 BRTSm4tf1xirA==
Message-ID: <71caed6b-2aa9-4c4d-bbd9-aac41aa6a011@kernel.org>
Date: Thu, 17 Sep 2026 20:18:29 +0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
To: Nikolay Borisov <nik.borisov@suse.com>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org, rosenp@gmail.com
References: <20260917113526.1589813-1-nik.borisov@suse.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260917113526.1589813-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/17 18:35, Nikolay Borisov wrote:
> Recent 4bbc16a353a9 commit changed the timing when interrupts are
> enabled. However it didn't account for the libATA registration step. So
> it's possible that interrupts are enabled when the device is not
> registered with libATA core.
> 
> Resolve the issue by ensuring that interrupts are enabled only if the rest of the
> initialization is successful.
> 
> Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
> 
> Changes since v1:
> 	* Added proper goto label
> Changes since v2:
>     * Rework logic so that interrupts are enabled if everything is successful
> 	and don't call phy_exit otherwise, as the driver is quite broken w.r.t to it.
> 
>  drivers/ata/sata_dwc_460ex.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 8e3fc713891a..e74335dec42a 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1185,11 +1185,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	 * error_handler() to execute a dummy Softreset EH session
>  	 */
>  	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to activate host");

Why not simply "goto err_out;" here ?

> +	} else {
> +		/* Enable SATA Interrupts */
> +		sata_dwc_enable_interrupts(hsdev);
> +	}
>  
> -	/* Enable SATA Interrupts */
> -	sata_dwc_enable_interrupts(hsdev);
>  	return 0;
>  
>  error_out:
> --
> 2.55.0


-- 
Damien Le Moal
Western Digital Research
