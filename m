Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F11A4E91
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310920; cv=none; b=O3t1h2K1iUyDTS2Kes54N2G/H79MKPjutIRIRkB40yxT8iYukQSRCSWLFTG3clBem4XYDuiJQ4soGaS9n9YSZzgwLOaHsRLmAPxM1SkO++dA+W/RhA+unFMk9ahFLpyyAWaD1RTuFuMrG1f2Mi5IMv0xJRSFw7JbQZhsbtvGcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310920; c=relaxed/simple;
	bh=w9hr6kihKEallzet9R41Nwq7FbOLMx4jlv0cIfyCSM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atj86da5HrRlzQTo69z8qzO496dJYZC4N7sXswk52gJ5Lp4EGqh/L85zLKNhLzj3Gzkys8IGCDHxGfY5As/zdthMSrvt9De8QLhK2J2FLf3Bvh4moHlCW720URFPULWMHUcBkjzjqSB45/wvIIJH7Mb6f5plADwkYsli04ZLTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W40rHt7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W40rHt7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0FBC4CEC2;
	Mon,  2 Sep 2024 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310918;
	bh=w9hr6kihKEallzet9R41Nwq7FbOLMx4jlv0cIfyCSM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W40rHt7b/gLhdCv/uF5jyBW1UXCwGyUiNz0e3XIeKHv/4q2DTETR48XFOyQKVe0CC
	 SgsRr7Ufw4zKe6UU8Bv93Wg8uAq3WK8pn6n8UMRlK0/8J7MplpVHQ0KajeWbD8jeYM
	 6W4Un/MTqTCBsGBeBhm6888wSzZtGsZdQKcEJXxWPFudc4CwGbSMQQK4KMez+XoKdz
	 mFcRfbG1FBPYhRnEbawsEcSJczmWl41SJ/eRn17JGxUMjfOV1n5ygNZKQAzNoa/LME
	 KhEXj4GYTVrnX6YPM5TCSom3MzDn36x+3Rj6qnf20sdDw+Bf+xbJYM1RZxGbBYs0Nn
	 fmcpNtIAK3hmg==
Date: Mon, 2 Sep 2024 23:01:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ata: libata: Move sector_buf from struct ata_port
 to struct ata_device
Message-ID: <ZtYnwqWFNeDx3YOt@x1-carbon.lan>
References: <20240902115400.166881-1-dlemoal@kernel.org>
 <20240902115400.166881-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902115400.166881-7-dlemoal@kernel.org>

On Mon, Sep 02, 2024 at 08:53:59PM +0900, Damien Le Moal wrote:
> The 512B buffer sector_buf field of struct ata_port is used for scanning
> devices as well as during error recovery with ata EH. This buffer is
> thus useless if a port does not have a device connected to it.
> And also given that commands using this buffer are issued to devices,
> and not to ports, move this buffer definition from struct ata_port to
> struct ata_device.
> 
> This change slightly increases system memory usage for systems using a
> port-multiplier as in that case we do not need a per-device buffer for
> scanning devices (PMP does not allow parallel scanning) nor for EH (as
> when entering EH we are guaranteed that all commands to all devices
> connected to the PMP have completed or have been aborted). However,
> this change reduces memory usage on systems that have many ports with
> only few devices rives connected, which is a much more common use case
> than the PMP use case.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

...and since I suggested this specific change in my reply
to your V1 series, I feel that I should get a:
Suggested-by: Niklas Cassel <cassel@kernel.org>

:)
