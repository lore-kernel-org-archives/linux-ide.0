Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA02241690
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942100; cv=none; b=kdi2vmC7Oi1/AZLzm88fyRUtaDpmR36GpCFUg1At7EAcOiaZL9zIKmumSJqMyYb0c7U6d5v1g9T0TsFua3jvBoKA3cBOWlAbksfwiHs32wFV/ZJQjT4j8fFJobuhIe8t1TjDceJ/b2X2k0oKFY2YKxzmLnnhQGTKCOUprVB1VO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942100; c=relaxed/simple;
	bh=uJF5kwDVDHYO5jEfg/WXiSp7znQbD8lSFIFl1GEjuZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syfzgqHWUMAlcgLuSgfcpdf9GlSVTM4PQ6w7iAh5XVj1FDRvlEcx6l2ePwCvVu6HOUvdxxmcHO3XUJ3doTl5XteQ5beiDD9bToADHq4S6q8y2M7cOd/VulL1YDvm35cnSUNvfLsmFDHerruotZ7tmm6xVGYtunpu/UFOP/LqpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYg7n73L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYg7n73L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711B2C116D0;
	Tue, 24 Feb 2026 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771942099;
	bh=uJF5kwDVDHYO5jEfg/WXiSp7znQbD8lSFIFl1GEjuZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYg7n73L9ocO4X6r0Rvckao2SWL+opMUNQH1G82rSsMypCadqu8+WNkJphCv1bEGO
	 0o5fDMySYFEGfKx5+WfWcCl+ifVQUM4alvCA0IOMHU8bK7eKniA5rBAWmVnd01uZSC
	 AnKKjuFeSpysnBcmb0BlAfb76bjRSIt5XFs/0aYAbUa+e9mO7bQ++Mxa8e1OVVSypf
	 P8/UQTruAlN+sEkJfxM786wLlD8wx55r2RE5zaWSVZNfRn9ZnX0u1qmPPlMsKI4Ywd
	 7NORBXTNZxn6ocatc5YlC6g1c8Ce/XqbUatDDHsbupUWoOJLGHej6E+LL8wD+rEVvx
	 jtHqwhf0KhP3w==
Date: Tue, 24 Feb 2026 15:08:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: avoid unnecessary calls to
 ata_scsi_port_error_handler()
Message-ID: <aZ2wyWgR02F1cEvJ@ryzen>
References: <20260224020638.1194842-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224020638.1194842-1-dlemoal@kernel.org>

On Tue, Feb 24, 2026 at 11:06:38AM +0900, Damien Le Moal wrote:
> When handling SCSI command timeouts, if we had no actual command
> timeouts (either because the command was a deferred qc or the completion
> path won the race with ata_scsi_cmd_error_handler()), we do not need to
> go through a port error handling, as there was in fact no errors at all.
> 
> Modify ata_scsi_cmd_error_handler() to return the number of commands
> that timed out and use this return value in ata_scsi_error() to call
> ata_scsi_port_error_handler() only if we had command timeouts, or if
> the port EH has already been scheduled due to failed commands.
> Otherwise, simply call scsi_eh_flush_done_q() to finish the completed
> commands without running the full port error handling.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>


> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index db87c99e4189..c872d1f9f43b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1225,7 +1225,8 @@ extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
>  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
>  int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
>  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
> -extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
> +extern int ata_scsi_cmd_error_handler(struct Scsi_Host *host,
> +				struct ata_port *ap, struct list_head *eh_q);

Nit: we could drop the extern while touching this line anyway.


Kind regards,
Niklas
