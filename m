Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304C374C4
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978821; cv=none; b=jirFRcVmMI5brwldZRBmbEaK5gNQqIyJvyw/+T7sBDxZu7FF83nS3Gs8p9mq8hR7Yskl9lfNKsVYaNk8m3tTWhvwxsaFtpmbAw+u27mr+58bjU0E7Q4Ugv5kihwI769cMju6H+tdypdZqlb9APPjb6yuhz06zIwuemmtpoPFDzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978821; c=relaxed/simple;
	bh=GE7X1lTPGbLv90bxcBHwLVU+2h7nTh9XEyAJeLrXDA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+VsXLojIousDiLaYt4vIP2dEiG+OmF/YhCNVSKMDJ5uJJtUpbml9Kx5ShuSulhc/g5EcS+7z6dJIbYG7Q6ITsZrmYjUJNX0Dv/10uJp/VknCvRB3WU07HoFXHrunEMHc/GJUqICjRccB1gKm8GA82scGt7Xh/uQolIem3B5oW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUKoXY/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUKoXY/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D072EC4CEED;
	Tue,  8 Jul 2025 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978820;
	bh=GE7X1lTPGbLv90bxcBHwLVU+2h7nTh9XEyAJeLrXDA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUKoXY/L+lFFOeOOHoMwPn8lbn73OmH5WHxZWGcwO8GSpwU2lTskvG3Fs2Qbfli6V
	 6v59DpgxfglArw9Vab6j2rtAFcCE8jnDTdo+X1HnID7/q650OThAstUo6fSglpt2m9
	 S+oC34Y8viNUP/dKmTh06v0Q1oMpfnWrTUCCsPhjbpJ8Hc4gWJe0sC/WnvCLSopob7
	 RGD7mq8tMvfUAcACuWJJAOE1vrrz+zqZf9jjoUW3d6FPC7KO2ADU8i4269H1+xKgtM
	 RO/NAhqYDgSDYSe4Re6EWnXeSo2eJKzCMiP2P+IFpE16j07slChZipQnjWn2tI8Ffu
	 dU/5O0oNnV8Zg==
Date: Tue, 8 Jul 2025 14:46:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ata: libata-eh: Remove ata_do_eh()
Message-ID: <aG0TQabGtX-JrGwp@ryzen>
References: <20250708073648.45171-1-dlemoal@kernel.org>
 <20250708073648.45171-3-dlemoal@kernel.org>
 <aG0QRvgIt4R3ZNFi@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0QRvgIt4R3ZNFi@ryzen>

On Tue, Jul 08, 2025 at 02:34:14PM +0200, Niklas Cassel wrote:
> On Tue, Jul 08, 2025 at 04:36:47PM +0900, Damien Le Moal wrote:
> 
> I think it would be nicer to just do:
> 
> if ((hardreset == sata_std_hardreset ||
>      hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
>      link->flags |= ATA_LFLAG_NO_HRST;
> 
> since ata_eh_reset() will already do
> hardreset = NULL; if that flag is set.
> 
> This way, we can also simplify the function signature of ata_eh_recover() to:
> 
> int ata_eh_recover(struct ata_port *ap, bool use_pmp_ops,
>                    struct ata_link **r_failed_link)
> 
> and ata_eh_reset() to:
> 
> int ata_eh_reset(struct ata_link *link, int classify, bool use_pmp_ops)

Even nicer would be create a new:

ata_reset_port_ops {
        ata_prereset_fn_t       prereset;
        ata_reset_fn_t          softreset;
        ata_reset_fn_t          hardreset;
        ata_postreset_fn_t      postreset;
}

And then modify:

struct ata_port_operations {
	...
	struct ata_reset_port_ops *reset_port_ops;
	struct ata_reset_port_ops *reset_port_pmp_ops;
	...
}


and then modify ata_eh_recover() to:
int ata_eh_recover(struct ata_port *ap, struct ata_reset_port_ops *ops,
                   struct ata_link **r_failed_link)


and then modify ata_eh_reset() to:

int ata_eh_reset(struct ata_link *link, int classify, struct ata_reset_port_ops *ops)


Kind regards,
Niklas
