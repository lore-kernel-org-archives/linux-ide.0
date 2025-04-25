Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601C3594E;
	Fri, 25 Apr 2025 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544363; cv=none; b=Tfcaeh2DzrbQxZA8cq6BVAKECBkA6mlYEV0LCcnbU8UDX9e3Yo0YYk0dA9/SEn7q3W0sN4xWwwmO5AcxMgESVAayA+9KaJjASOXK4XZRBKREF1z0TmhV7xFWJakennOesjWzOubXVtMIDe4UBJcntyV+yYd72GQTQaab7KZLWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544363; c=relaxed/simple;
	bh=zZhhveuhacURq6wUmXqlmvLCXowRmY3258fmMA+iATc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ape1Tr0LgV4TMaG7YzZBpZ2Y6jMwScJ10tR23npCQRptP/OdoNUyB+LNxQxgi7Mu0yNfYJwFWpVsEbjlss14cB/hVoURcs4jPh+bSsZg6plOaKV0763doGvK5cvuQGtwEw7hrWFdAIm56pDnHKHdZYG/tLDlxx2NMFA4UuW/6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFZ/O3ad; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFZ/O3ad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACC3C4CEE3;
	Fri, 25 Apr 2025 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745544362;
	bh=zZhhveuhacURq6wUmXqlmvLCXowRmY3258fmMA+iATc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fFZ/O3adpABtNzLcx26RX2iiMj8wYPb5+FKlbTl23LjxBV2TxXJkS2yM5eak+M0Wb
	 pzZcs4MOjguvku6M/cZ/soK9A0r2gT9n4zzl8fegDrQ1VAE8MhGM+hsfXHS4gC4f2k
	 Xd/4za/vLfCqgjPJyS3DXw2VFzUeKUjvCMxlf8RC/z8teZND48qdS+WVznaSxPIJ1h
	 d9VrN+qW9JC+8PWpNpWzIwN8zDb4FJZGLbIx808Dlc5oAZlAXJ0djaFNjNxrNC02bV
	 RSihg7maAoolBL1AHgxiqdhcdgWFIyBXo19J8/GqVBJLgT6y5uvkg90oLp5XQcx2SG
	 cjJGLw8IE0J0A==
Message-ID: <b24414b9-c7b9-4116-a4d2-59a6686dc343@kernel.org>
Date: Fri, 25 Apr 2025 10:26:00 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata-scsi: Do not set the INFORMATION field
 twice for ATA PT
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250422172123.281387-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422172123.281387-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 02:21, Igor Pylypiv wrote:
> For ATA PASS-THROUGH + fixed format sense data + NCQ autosense
> the INFORMATION sense data field is being written twice:
> 
> - 1st write: (redundant)
> scsi_set_sense_information() sets the INFORMATION field to ATA LBA.
> This is incorrect for ATA PASS-THROUGH.
> 
> - 2nd write: (correct)
> ata_scsi_set_passthru_sense_fields() sets the INFORMATION field
> to ATA ERROR/STATUS/DEVICE/COUNT(7:0) as per SAT spec.
> 
> There is no user-visible issue because second write overwrites
> the incorrect data from the first write.
> 
> This patch eliminates the reduntant write by moving the INFORMATION
> sense data field population logic to ata_scsi_qc_complete().
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Applied to for-6.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
