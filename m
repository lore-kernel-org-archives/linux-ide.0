Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A0389452
	for <linux-ide@vger.kernel.org>; Mon, 18 May 2026 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096188; cv=none; b=Kk51psbQ9/fyA9yADA45ShZme/8BhjhGxs1OCEeteCfwp3hIvgX2DqITx9T7EBeqboF6DUxmJ+bm+iwvY9PrQNf7llabyZgqndmaUlFzaWy7Wpvwbtf0G7SC6KAtxP/cgmfxTxA408gJeyjr8n0t5DkE9I0JgluRHasKySHUmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096188; c=relaxed/simple;
	bh=4cAvRA+RkyZ8xlgXy+R5MMntECgfWmGGsUo3TbfA7LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkzE7zfffYw6dcG93VGngv3wbtD2WIf3L7GZXrQz9vXMCWMqgnIv/Xe5qn0S92MFZep/nnFoW+dIX7f++SyJHRo85AEl4hNLaqldro8MEcQ0X5iTgpRHdLbIfXCo5RoRENJfsshRK3ICZkDptMCbgbhBDWK5+AIP0W1JmDV6a5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT12oICG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT12oICG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0825EC2BCB7;
	Mon, 18 May 2026 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096188;
	bh=4cAvRA+RkyZ8xlgXy+R5MMntECgfWmGGsUo3TbfA7LM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FT12oICGWu8uBSxgs+NVH5h9/LYETjysORwBzJHSenswWxuMhchpFy7yqc5KXURKd
	 lFddtiW4cMBZm8h2TnUltHs1HfDjxH4wFFTzeA8GtpdU9eEvrAMLF4mr4yWiJX2iVI
	 t7FXZnd7akJCfzp1jFi6d22yF1pD+heehX7AQbJ+nEs69lzfXgvShXe1zXmdkgLD5R
	 peFnPcsYxvk8eVz77DtYXBCeo1mAcF8xAgGBD6V1FFQohbZq/8tQ57tZkw89j3iiGQ
	 en2GTctGPOiRw77W9CpcM6+MsPVgDtfqmnRUxdrYbcvQvmQE5xdRzQdcjqPZha0wJX
	 rNhy8VGt+O+BA==
Message-ID: <a93e6459-97ba-4d42-bbb8-e813c3607d4a@kernel.org>
Date: Mon, 18 May 2026 11:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] ata: libata-scsi: do not use the deferred QC
 feature on PMPs with CBS
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org
References: <20260514073858.1175072-6-cassel@kernel.org>
 <20260514073858.1175072-9-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260514073858.1175072-9-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/14 9:39, Niklas Cassel wrote:
> When using Port Multipliers (PMPs) with Command-Based Switching (CBS), you
> can only issue commands to one link at a time. For PMPs with CBS, there is
> already code to handle commands being sent to different links in
> sata_pmp_qc_defer_cmd_switch() using ap->excl_link. sata_sil24 also makes
> use of ap->excl_link.
> 
> A user on the list reported that commit 0ea84089dbf6 ("ata: libata-scsi:
> avoid Non-NCQ command starvation") broke PMPs with CBS. The commit
> introduced code that stores a deferred qc in ap->deferred_qc, to later be
> issued via a workqueue. It turns out that this change is incompatible with
> the existing ap->excl_link handling used by PMPs with CBS.
> 
> Thus, modify sata_pmp_qc_defer_cmd_switch() and sil24_qc_defer() to return
> ATA_DEFER_LINK_EXCL, and make sure that the deferred QC handling via
> workqueue is not used for this return value.
> 
> This way, PMPs with CBS will work once again. Note that the starvation
> referenced in commit 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ
> command starvation") can only happen on libsas ports, and libsas does not
> support Port Multipliers, thus there is no harm of reverting back to the
> previous way of deferring commands for PMPs with CBS.
> 
> Non-libsas ports connected to anything but a PMP with CBS (e.g. a normal
> drive or a PMP with FBS) will continue using the deferred workqueue, since
> it does result in lower completion latencies for non-NCQ commands, even
> though the workqueue is not strictly needed to avoid starvation for
> non-libsas ports.
> 
> If we want to modify the scope of the workqueue issuing to also handle
> PMPs with CBS, then we should ensure that we can save both NCQ and non-NCQ
> commands in ap->deferred_qc, while also removing the existing PMP CBS
> handling using ap->excl_link, such that we don't duplicate features.
> 
> While at it, also add a comment explaining how the ap->excl_link mechanism
> works.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
