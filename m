Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48A14D283
	for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529989; cv=none; b=L/eIsmsmee1yQ6xjLh7qD81qLQSmybhDn+F/wT1BjyXRzsddZS+MEvaDMZUysKtYX2j5aytzPuEp5zzVMznfjHMC4uoByUoqWElRDCA8ws4KDjjytvEvb9nfmkkQ2C93zmOaZwp4mpIuWyPhJLERI+K/J/t09BysPttFiCEPKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529989; c=relaxed/simple;
	bh=oS2PD3i4RAZ3gnnGc9q8VXIiC82+s66UmEqtxjzh7Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPZASI285VshkIFN1BcaDJWDXhwevKP4id7ZhHDC8yHUxcM73eXv1teNURP33efHkO0mC7DBiC5bUjCNgaBH9/TUrya8sFS5BoxsU7T3e+PaOVdX0CnBWBp8w2Mzb5Hj6e5IRk25JFuUQswggWLk1nSTGst0g+nv1yssuaizVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um1WO4dO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um1WO4dO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B2C4CEE7;
	Sat, 21 Jun 2025 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750529989;
	bh=oS2PD3i4RAZ3gnnGc9q8VXIiC82+s66UmEqtxjzh7Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um1WO4dO4cGo9UeGv8PixyCAWC9WtypeVOj108nV5CMmGwEgJdtyNipuFSPLo9D8B
	 +OMzH7JBXgDAw/2DMza9ZZjn6hVwaWBYRO2juyEEKWxUdZOO3ZcbhTgZb5X/e9AwHq
	 6Pw8ntgkUouV0aL26VnwVaqZj0jRiIS2TNs7/LaV+ea30Iwe5p0FQ6I1d59FEx55kO
	 zvxN9cnbWLy6+sLw4yqHUBJdG07Ykx616Rj9daTSCa03bGffi25HBkWghQ4NvmAHNe
	 kiMYyDjYVLrSdvk4Lq1rJjKWxcu6TsXt6MaD3ITPfAL1PyZunDOxCiH8la4AmCd8CG
	 6dY29qQUYiMeg==
Date: Sat, 21 Jun 2025 20:19:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Andy Yang <andyybtc79@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: Issue in the patch "ata: ahci: Disallow LPM for ASUSPRO-D840SA
 motherboard"
Message-ID: <aFb3wXAwJSSJUB7o@ryzen>
References: <CAGEiHrCs_V8w3cTCY44rgQ0nZrhAo7=0jAn0=79HZxMJ5wEp8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEiHrCs_V8w3cTCY44rgQ0nZrhAo7=0jAn0=79HZxMJ5wEp8g@mail.gmail.com>

+linux-ide

Hello Andy,

On Sat, Jun 21, 2025 at 06:06:10PM +0000, Andy Yang wrote:
> Hi Damien & Niklas,
> 
> This patch isn't working. I've mentioned this in several previous emails as
> replies, from the time it was applied to the libata work tree to its being
> merged into stable. This is my third email addressing this issue.

This is the first email that I see about this issue.

I also don't find any other report about this on the mailing list,
perhaps you were sending your email using HTML instead of plain text?


> 
>  The DMI_PRODUCT_VERSION field is incorrect, we should consider using
> DMI_MATCH(DMI_PRODUCT_NAME,
> "ASUSPRO D840MB_M840SA") or DMI_MATCH(DMI_BOARD_NAME, "D840MB") instead. If
> you require additional DMI information about this model, I included it in a
> previous reply to the patch mailing list.


Does this patch solve your problem:

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e5e5c2e81d09..aa93b0ecbbc6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1450,7 +1450,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "ASUSPRO D840MB_M840SA"),
 			},
 			/* 320 is broken, there is no known good version. */
 		},



Kind regards,
Niklas
