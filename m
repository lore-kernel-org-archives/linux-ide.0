Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E61F3B83
	for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980963; cv=none; b=IkmabAr4SLEwLEiQAjHZsd6aUhnRj5mJ09OgeDfQEhocEi3qcSNAhJo5HMMvH8afPKsgQ91QFGvoje0PH12kDG7zMu+QJRo/C/vicRkVW8gnv0rILld9DiwXdHLlYQ3+4OC1vI7gy+IJ0dHOmObitRPWfo+5qqQn1SAQwOl41QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980963; c=relaxed/simple;
	bh=vlE4Nw7eAEepD9hngLR2Npb/JR82EkB/iBby3uxMtPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYVYBQYaZ1xC/EuBp1TZFm/2Tv0Fgyl8SPpK4SIz+nmBwTtj4QaZ4qD45T6js+GXVqQ+MEm2UFx9cgRRAGp2kFg5Jm1PVlXW2C/TP6G7593BC8XadQUbROYRVVRgfy/uoYvJoQK/o8dj7rDQCG/fdmo92E+55bJPOL/T2ftMdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipBpYeCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipBpYeCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E2C4CED1;
	Wed, 19 Feb 2025 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980962;
	bh=vlE4Nw7eAEepD9hngLR2Npb/JR82EkB/iBby3uxMtPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipBpYeCJygyn5BDrll3aaycSdXs7dMdM1Y6rQkgUDs2xbera6ZbceHjiN+zltPyXw
	 YGdIoV9b1ZGEZ46B/HVaEgAe93wvOk3aBrDmAjUAqafNr5Y5aSNK/PaYX/9uPoSPls
	 /3CHiRcTLzu/u0vjrqyGKTUBwfUaTTukYNUlUKblTRSJ/jerKbkjPV/2ftakSEalJ4
	 9pWE5rUPNFYMpsE0+qZbCdQs6zSBO01HOsUCbaf+36mQ1GXO2njSNJnDGFB8LMtHlI
	 RshJOWf5nqkLHGwiQWe2I+E/8BTKSkJgFhIDQejNW4n70u+IN6V72W6IpVkBVYCmmr
	 cd9XlYpT/FaEg==
Date: Wed, 19 Feb 2025 17:02:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z7YAnqGsrWSzBirf@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
 <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
 <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
 <Z5NlVjIMp6Wo8dQd@ryzen>
 <9253b1b9-0f92-45ab-8b8a-44064ffa9cd9@philpem.me.uk>
 <Z7X9aPpgBjNln9CJ@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7X9aPpgBjNln9CJ@ryzen>

On Wed, Feb 19, 2025 at 04:48:56PM +0100, Niklas Cassel wrote:
> 
> Perhaps your could try with something like:
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 3b303d4ae37a..bc2a317c97da 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1543,7 +1543,7 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>         tf.command = ATA_CMD_PACKET;
>  
>         /* is it pointless to prefer PIO for "safety reasons"? */
> -       if (ap->flags & ATA_FLAG_PIO_DMA) {
> +       if (0) {
>                 tf.protocol = ATAPI_PROT_DMA;
>                 tf.feature |= ATAPI_PKT_DMA;
>         } else {
> 
> To see if NOT using DMA for PIO cmds makes any difference.

Or the big hammer:

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8e895ae45c86..920462101775 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -249,7 +249,7 @@ enum {
 
        /* ap->flags bits */
 
-       AHCI_FLAG_COMMON                = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
+       AHCI_FLAG_COMMON                = ATA_FLAG_SATA |
                                          ATA_FLAG_ACPI_SATA | ATA_FLAG_AN,
 
        ICH_MAP                         = 0x90, /* ICH MAP register */




Just make sure to not use this on any system other than the machine that
you are debugging on.


Kind regards,
Niklas
