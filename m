Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA63A16A0;
	Thu, 30 Apr 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541284; cv=none; b=BgpM/j5C2uO55D9jhHMoLtNnF4zkbD9/MV+ovxIBEujjKH9UuImDZjjbdBkjz0fO8YSQcSj+PJIZRno+91s9H8QnQluzftyVEA1MMSFxkgi4yustQcThZJDHIcT6yfgUdy+lmMCG1LpYXrYbu3nYqKBe809rVgs6CypHVLP2i50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541284; c=relaxed/simple;
	bh=QjF8M8eq94doDD8ljiXqNcFncYsw6vQvhCXVxZQUyn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzk17miB+pMlCs86rfIXJnNw5ZHlDT12V6LxUdSDAeN9E7EvdnbC+4gDzMs4sKg1cWhOXk3dQEK2+obZzXnPzf7PsLZf3qp2mt0FZt2c8muzNnfHE70N/TY65aN4ivRxeiEgmXzWFDmOdLwXK4NxmRuPP7kFQJtvmRK7QNjSCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOJQ4uTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOJQ4uTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D33C2BCB3;
	Thu, 30 Apr 2026 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777541284;
	bh=QjF8M8eq94doDD8ljiXqNcFncYsw6vQvhCXVxZQUyn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOJQ4uTNFnlazTkyB6L8OrYENelgf2tF9IIw6ruxVkYOwhbPahFN9xm/Y5nQoZokN
	 n6XMdflHnQbouSWgcg0GMabXW4lCfShPpcOSMAjis5H9LNbkaW/CF+UHA+Aab8CXq6
	 iu3KPx3hkaJKDN3ROMRR/hyPKvbvrZCeEAlIeHovA1DjsYGFuVVSmJmwx/3RMfHNuw
	 SXlSn9FL/LXeRPI9gm0Dc4VWQP5+QgvbaUvTvZDWRHoQvOb05BIeRhMCRkdWWGz0N5
	 XTk3hfdsUBgxO+HalmpMad6mdRfdP2eSRBVSe7otySbpawtnbUOIo6E8r1JiByT93w
	 qP6koXWlCCtDg==
Date: Thu, 30 Apr 2026 11:28:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: yangxingui <yangxingui@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, kangfenglong@huawei.com,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
Message-ID: <afMgoFBFPWR0f4gK@ryzen>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
 <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
 <c78f6dad-b0fe-a2fb-8458-9fe182cd6b54@huawei.com>
 <afMW2scJrBSI_jLo@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afMW2scJrBSI_jLo@ryzen>

On Thu, Apr 30, 2026 at 10:46:22AM +0200, Niklas Cassel wrote:
> If that is the case ata_do_reset() would return 0, and
> ata_eh_followup_srst_needed() (returns true only if -EAGAIN) would return false.
> 
> Which should eventually cause us to retry another hard reset, as long as
> tries <= max_tries.

I see now that max_tries is just set to 1.

I think I would prefer another hardreset (with a larger timeout) over
a follow-up softreset after the hardreset...

If -EAGAIN is reserved for "do an follow up SRST after the COMRESET",
because certain Port Multipliers need it.

Perhaps introduce another error code, which means, device detected,
overload max_tries to 3 and goto retry.

That way we will retry using COMRESET, with increasing timeouts, since:
deadline = ata_deadline(jiffies, ata_eh_reset_timeouts[try++]);


Kind regards,
Niklas
