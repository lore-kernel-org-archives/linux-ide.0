Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E54519A4;
	Wed, 30 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754128; cv=none; b=GcX1HuF4LeoDSS2Sq+BEHm7ZCcJuKkw6SC5ew5AQJmu+WVGLvUVMBbtBq3juAxJdecR/S7EBBjJJCaJ8ZCf08mTWs+cPe/OBN8qu6i2BT+9F3w49j83B4qj5BFGtcwtFf2dXQd4vAMsQcGRayFOP7K8ZBVAUVJUkjr0WNXvMqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754128; c=relaxed/simple;
	bh=aet2p0wuyzoWWAhgwwG1Wb51jhLKpcpmvrEVclDX7lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMjYXga840XjRrNKeqMH9XEMc9LlonIZhPUHYx2WTvFYIab/fiCfvqR4LZ6nbK0jHBXkJruGUStG63SMB2sTerAzOENOrxg+O89QB1OGwngTSuddPTTc3xtjaamIpZ8BeAllX4mnyzztnYMEL2OuHuSYT7zZJ30ekHL0E74cXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0QdR0hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0QdR0hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE2C1F00898;
	Wed, 30 Sep 2026 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790754127;
	bh=9gX9mBRcIUZdZftB9xvavBJn4/NHiZat8tx/fC5TJFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K0QdR0hOhMaBwwJy0nIlaslp+U53TSHU78PUqzeuBhMMBEpOyhOZvOELHMe4pUYN5
	 jKUYeijuuhH2X121YvsWrJTW4TJ7fyNII+UDA4sHQVV7N7e9TZnp1G2eeDBmp2bZWG
	 y9VnRge26y7aBu89TI6Oa/xXOSKw5Akh8seiKO2Wpc0tD+E6/vPb50Rz6NBYHelhN1
	 NRnt19YmRdUAx1xCBBiO9B0e5lPcpV6biJtdpsp8QKHM1OSmY5gbnFobECTi7D3dcP
	 dVvp0aLyzFhQ3N2a+ekb+v65IGIUkHeHQLEct4263/S/RKIvRJ2SAlPJj61rrui4mx
	 prA6UNnzUmzdA==
Message-ID: <54f1795d-faa4-4176-a1f3-15e2987f1d91@kernel.org>
Date: Wed, 30 Sep 2026 09:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: do not lose CHECK CONDITION for
 failed ATAPI commands
To: hengyul@cs.unc.edu, cassel@kernel.org
Cc: mkp@kernel.org, ipylypiv@google.com, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260929164135.266708-1-hengyul@cs.unc.edu>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260929164135.266708-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/29 18:41, hengyul@cs.unc.edu wrote:
> From: Hengyu Liang <hengyul@cs.unc.edu>
> 
> Since commit 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands
> on time out"), atapi_qc_complete() sets SAM_STAT_CHECK_CONDITION for a
> failed command only if cmd->result is zero, so that the DID_TIME_OUT or
> DID_REQUEUE host byte of a terminated command is preserved.
> 
> However, cmd->result can also be non-zero for a regular failed ATAPI
> command completed through libata EH: ata_eh_analyze_tf() calls
> ata_eh_decide_disposition(), that is, scsi_check_sense(), on the sense
> data obtained with REQUEST SENSE, and scsi_check_sense() sets the SCSI
> midlayer internal byte of the result for some sense codes, e.g.
> SCSIML_STAT_TGT_FAILURE for ILLEGAL REQUEST with ASC 0x20 (INVALID
> COMMAND OPERATION CODE) or 0x24 (INVALID FIELD IN CDB), or
> SCSIML_STAT_MED_ERROR for MEDIUM ERROR with ASC 0x11 (UNRECOVERED READ
> ERROR). For such commands, atapi_qc_complete() keeps the result as is and
> the command completes with a GOOD status byte, even though it failed and
> valid sense data is available.
> 
> As a result, passthrough users see these failed ATAPI commands as
> successful. For example, with the emulated IDE CD-ROM drive of QEMU and
> no medium loaded, a PLAY AUDIO MSF command issued with SG_IO completes
> with status 0x00 (and no DRIVER_SENSE) instead of 0x02 (CHECK CONDITION)
> with sense key ILLEGAL REQUEST, ASC/ASCQ 0x20/0x00, and the CDROM ioctls
> CDROMPLAYTRKIND, CDROMSUBCHNL, CDROMPAUSE, CDROMRESUME, CDROMPLAYMSF and
> CDROM_GET_MCN return 0 instead of -ENOMEDIUM or -EOPNOTSUPP.
> 
> Fix this by setting the status byte to SAM_STAT_CHECK_CONDITION whenever
> the host byte is not set. Use set_status_byte() rather than overwriting
> the whole result, so that the SCSI midlayer internal byte set by
> scsi_check_sense() is preserved, as ata_scsi_qc_complete() already does
> for ATA commands.
> 
> Fixes: 2e1d2e65e773 ("ata: libata-scsi: terminate deferred commands on time out")
> Cc: stable@vger.kernel.org
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
