Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A415A85E;
	Wed,  9 Apr 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180048; cv=none; b=rPTsYTzCiCC8x6DE2tdvjg/V/iFUOLAMK1v2FKMCVkz9JD1MS0kmXJsoLnTfhitrYEg0CIbwmq8gY25g0X07rpSuHIWHNoPrVvhLuMU5oslb/6OTIycgljMXEzSlUupN7o7WuNH6xJ2Ii8UQc+1vshAwAJWPzRr2cBeFPnPlZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180048; c=relaxed/simple;
	bh=PjttsRKFPYNqJPx2NsZyabFKwjkjcZO76l75hbEFaHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahze5FV2z4eVbCV7AQdcce7Fpy+IPJyjsXwC6rUT+D11DAF4G0ZFli/IcsBMgfQPVPa5Lf5DogqfQVrUHIX4twg3MKSHyfVRNQ5sIH3ZCmgtWuYpP+3+DD2TVVrQEvdcQSf8b6iiaWZDAt5igJD/WlgoNdgNub0ZMW4QvmVY0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDmHBtlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDmHBtlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B8DC4CEE3;
	Wed,  9 Apr 2025 06:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744180047;
	bh=PjttsRKFPYNqJPx2NsZyabFKwjkjcZO76l75hbEFaHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CDmHBtlLpQKYh+Wl9tEezcbf0w544OVkyjgC2gvNkiy3wmgot1CgpJll73ttaITod
	 Dt0utoQAOv1jHVfA3YBxczDP/RRiuqnxZooPkI00w2fSQjTCNJQ2BKhyvmVgH13x/r
	 t5XkrlTlxMrg1T24yDfg8YoOGaWVOe/WPzlhsrDPIihPVixhG8A3WZ2S2k9b/zJjEs
	 x5dGv7nPQVdEp+R5w2D7JmG+fL0Iev2yxRqOi6WkTBO8ANaxOHNWjETZBi+ldF0utg
	 bGR6zUJ2p+HxdwgKUUOj/xcGo9rrQ/hoO5GbWdHOe0v9sSlRxEwqjfEQcMLtSDt0EP
	 dhnINVZaU+m2w==
Message-ID: <206fb99f-a884-4f62-acd5-def886891ded@kernel.org>
Date: Wed, 9 Apr 2025 15:26:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: sata_sx4: Add error handling in
 pdc20621_i2c_read()
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408073001.3121-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250408073001.3121-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 4:30 PM, Wentao Liang wrote:
> The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read()
> but does not handle the error if the read fails. This could lead to
> process with invalid data. A proper implementation can be found in
> /source/drivers/ata/sata_sx4.c, pdc20621_prog_dimm_global(). As mentioned
> in its commit: bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0
> might be used uninitialized when pdc20621_i2c_read() fails.
> 
> Add error handling to pdc20621_i2c_read(). If a read operation fails,
> an error message is logged via dev_err(), and return a negative error
> code.
> 
> Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
> return a negative error code if pdc20621_prog_dimm0() fails.
> 
> Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied to for-6.15-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research
