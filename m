Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338B28AAE9
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295004; cv=none; b=U2mp51bdd10iKlwdDLUZmVRGgsrhru4QcmBXljuvbzbmNXbduao53EqPSUtbHBcmLp3Xv9W6CoWanQKEJNgkh+s3/xePxxXxNzO0CVKP9+0h2wi1voSUTmKT3+svqMNwT8LhJuUTZ8ak40DDxhpP4+3Cp+n5QV6aUz+LsHeSl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295004; c=relaxed/simple;
	bh=6+vWCRIVul7ADc0RlIA6F0mG9b7AlQLTpMBTFabZvzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKZOCwk+E0kFy61rapxYMJGmuAD80GifkSkdR2+1FBkxD6OC/VJYisTalPU8z5KrnjrQB1QJPtiXmLlpBRZo8E3u/RAMXdu4XO9h2NRh5Tzk4WazZocBix/DSF/kOO1N2v3Yiku+JB3SVz0I9ysVjRnLmSOSK7KlPGs5PU8Eo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgyCNrtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgyCNrtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3EEC4CEE3;
	Mon, 30 Jun 2025 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751295004;
	bh=6+vWCRIVul7ADc0RlIA6F0mG9b7AlQLTpMBTFabZvzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lgyCNrtPRDslIQC4l9wp4IF7d9WiKPRmGJYRmK2J7l74AZwW7zHeuvll1fiCybFGF
	 cpj6OmbGwRWQ6d1QdIQ23UnNU6ofptFTPE3AjTzl7A8dHHFtoV5NMOXb5IdPu+v84g
	 40RxpAQc1XK1k3Rgz10f+Ozp3m7I6dPz0XYIN6jJfWMQ4doil6APdQJ825MGBi3Vp5
	 mcPvhn8eA7JVM8ghAP80iC3kGi5MD8mkRtoqqALS8Gdw4W0+oWXXTg/OoaUWsgRMt2
	 Mak6vpZLDkIQQ6qfchNQStoSYMrdlyt6CPLg0YLvPtbo5D0KT3ODxxZXieRjLZIQ5t
	 fp993S/pOBWCQ==
Date: Mon, 30 Jun 2025 16:50:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 06/10] ata: ahci: Disable DIPM if host lacks support
Message-ID: <aGKkGKaeOC1jxueM@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630062637.258329-7-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:33PM +0900, Damien Le Moal wrote:
> The AHCI specification version 1.3.1 section 8.3.1.4 (Software
> Requirements and Precedence) states that:
> 
> If CAP.SSC or CAP.PSC is cleared to ‘0’, software should disable
> device-initiated power management by issuing the appropriate SET
> FEATURES command to the device.
> 
> To satisfy this constraint and force ata_dev_configure to disable the
> device DIPM feature, modify ahci_update_initial_lpm_policy() to set the
> ATA_FLAG_NO_DIPM flag on ports that have a host with either the
> ATA_HOST_NO_PART flag set or the ATA_HOST_NO_SSC flag set.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
