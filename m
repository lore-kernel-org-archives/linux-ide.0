Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A182F549C
	for <linux-ide@vger.kernel.org>; Tue, 31 Mar 2026 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920731; cv=none; b=DWgAhyoueyDGq4UnWWofCNBvG1Tm/YR34A0OQbH01vSMFWCP32h0od4OArXEilbcQw3sOQb0Eswq4OlXGryhM+9DYK8dgM6X76QuMPLbT5+2xnuWNvqG+W3cX3rzbG0DCAkgWu9snNokYPYpcQMSQ+v/+LC99AeCgsDkJeNYfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920731; c=relaxed/simple;
	bh=H6mT9vTY/69p/nFXTCKbzMPSWVHHmgabYybIZ0pR5EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPkuSSoIL6h7NTZU78MtiN3eu76mut7rzxNzTSDtXxQ8FywBVfm5Py2ViF08d89NkUqhiDrPIOnM3v2eX/xaInXMsq5DGRX9aPn18ZSeFayk3NgFxCt2poNBbi6aSN9g5bsilSB8hjo/YT7itQKle/7VT/5PUyhhERzBvVDlkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7MLNMTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7MLNMTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8FFC4CEF7;
	Tue, 31 Mar 2026 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774920730;
	bh=H6mT9vTY/69p/nFXTCKbzMPSWVHHmgabYybIZ0pR5EU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V7MLNMTWwJfTS4ndSp7BwFQD1xkmhKQ+6JqMo7Xn5WOsKzfAoPHS8EbnEo9103FTf
	 f4WCLzqDLsyaUvo99mx2WthCSRNdO1eUUmbtG4bCPTrwBc9SrP3T8TSpPCCquavEbM
	 29Ko6WoPSZTY5xgKFQrJwIgbVAYRGkeo3vtF8OGovc2lg46hQhe60E2PnD2l3s7tbh
	 Vigt987rdbKhnwuWu2rXd+YeQ2SUeX3Fs1CT602Z4INum2sq3Ixp1LPPtp5dQqvZjE
	 W7b3IjIXXPIXgQsXM1EkY/qbXFH0D11lr4Qs5dKDcnbL0oQHjUBfNcHLK1AkQ+p0HN
	 MQmLgIxN3AJrA==
Message-ID: <70d9cb85-97c4-4a7b-924f-f8cd6434d416@kernel.org>
Date: Tue, 31 Mar 2026 10:26:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ata: libata-transport: instantiate struct
 ata_internal statically
To: Heiner Kallweit <hkallweit1@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <8592ed06-3a6f-45cb-9811-e163f31f7183@gmail.com>
 <ad6ef45a-1e47-4bc4-b9fd-6ba3ec8ca83e@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ad6ef45a-1e47-4bc4-b9fd-6ba3ec8ca83e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 12:18 AM, Heiner Kallweit wrote:
> Struct ata_internal is only instantiated once, in module init code.
> So we can also instantiate it statically, what allows to simplify the
> code.

s/what allows to simplify/which allows simplifying

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
