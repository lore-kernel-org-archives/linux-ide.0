Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C832D3219
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978318; cv=none; b=bByivJWeKUygACX8W/s9M2Edrk0RwwqD7nfmrKIrq03eCgsDZudpZgOdOk97CHhRhtuKwrbdCFKuTDTyz4rm7IKX6WeUSxn7qXQNtiRiYL70qYJEgTPcI3s4h5WFP3WnPfBp8IiPOcaDPlrUbUMKsbNppB3SnPxpk/aVUl3647Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978318; c=relaxed/simple;
	bh=tx3+eOmEVtaHxSd5VBecjloSA5OuwNlDaXhW9TBU7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFyd3EA7VX0cS57O2B8ep+maw/ZBzES4brmi/v1UNReGhqi97oSY8QXxB5JwdtNVXRyJnRdXBoBde6gIA51SmZ/0H3KiHQ2NxODv9hLNCeqxtI3FJx8gjMqCnbF9nrEs1iMXAUQTGv01F3Kax9CFsTt+MYUsf977fxR/lqRfOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYsiDT6h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYsiDT6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA7C4CEED;
	Tue,  8 Jul 2025 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751978318;
	bh=tx3+eOmEVtaHxSd5VBecjloSA5OuwNlDaXhW9TBU7ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYsiDT6hlyp+qTiGJDLBS8ALBPtvYH31hAfRscYOVWre1KNdX8i+ex667Y/bop52M
	 TQYHD52LQ5EG3kX2sawGL7P60Ctbv7aHNHIIVn6+Ooy3SYN+uiUeEJ8z/XeDr9BXyv
	 uPL2D1MNB96geYY0dx6AqnWiu4gf1SFNXr7QzJBxz8SGv7L1lBZhSwxrSr5PUDF2mg
	 txr1Z724cG08blZq8o68iFxqKe+BK/8ZLTQJAIyezqLp/AyuwHzrhQorRXcVTPwWFW
	 a9sNEM0IqxZlamWE/SJxio30Qf/zekCTpNUqDlf/rEqcyDmeBxiqn3tdOzguMHelu5
	 0HaANixF3xVSA==
Date: Tue, 8 Jul 2025 14:38:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ata: libata-eh: Remove ata_do_eh()
Message-ID: <aG0RSsr4lUXw1hAy@ryzen>
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
> s/operations/operations/

I of course meant:

s/operations/operation/


> And then in:
> int ata_eh_reset(struct ata_link *link, int classify, bool use_pmp_ops)
> {
> 	...
> 	if (use_pmp_ops) {
> 		prereset = ops->prereset;
> 		softreset = ops->softreset;
> 		hardreset = ops->hardreset;
> 		postreset = ops->postreset;
> 	} else {
> 		prereset = ops->pmp_prereset;
> 		softreset = ops->pmp_softreset;
> 		hardreset = ops->pmp_hardreset;
> 		postreset = ops->pmp_postreset;
> 	}

Oops.. these are swapped, but you get the point.


Kind regards,
Niklas
