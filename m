Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DCD32E12E;
	Mon,  1 Jun 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304067; cv=none; b=LKjPW08xEQqBNNMG4vMSwerI5D1G8erbIg+0yinVrUfJPIBzIrmaXbcX6W05AIUnVmJu0hxXQsHV0AIuX3Xd7ucb2REj2rNLIglaD5GcASwW3eD81Vpf5nE/LaXvGVE/LLBKwHiffdLhNb35AVjw0avoPUCYS4FwUfjTk8kYP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304067; c=relaxed/simple;
	bh=r/b2gc0KcepyxuL1Nz95NoQgnStuovJ6HgMmDjQ44xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgDs86SFYPHUm8snfeSSBmxoxuiqnEv/FL7gfeYBpd58bfXk0emFe3CE5Eiymi1d02sGrpp5q4vWUHyVmMepEMT/DQ+pwNAmcjXIXrtdcjpN3NhVQ3LOEiE6AHIYROwDOHBgpeItSDsuzKGDkeUo4Ae3f0P2NNVz/ViBm3TFg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0/cLYRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0/cLYRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E51F00893;
	Mon,  1 Jun 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780304066;
	bh=0wgU9RvIxiS9GmfXUyrP6vG17Kl9xTl0oUzPEKaWeTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C0/cLYRhfNNBKAEWTI+aWBkH4fWojFDuJLe0bEiIcLaKcpx3QQPdbyIu40iDlZTkG
	 xFpRe/XPkQ03IEhaQGDrRZJxpbH0p80ECzv8EhqhlZsWQjVab9esJVl1eTurN40vUo
	 N4Cw58cretBZ3uMHTHBqFdEbq9/+Es9m7wyXgjA4SJ3IM+rKFeFCzq6iX/KJIcCXvy
	 MXxQEQHqxM1YyMijHdmyN/MyS3uIu+4UPMCJ8tVN3iHxMByg+9uu9ScS0iH7+dIv3t
	 DIWSY5jbODo2G9YA0fYz4n553xVk2oBibXNKhQQbneypNQhVGKgLZrSKL7iD6pU4e4
	 OcpKvxHmEF7TQ==
Date: Mon, 1 Jun 2026 10:54:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ata: pata_ep93xx: COMPILE_TEST and ARM fixups
Message-ID: <ah1Iv88PGkU54T65@ryzen>
References: <20260530003627.42473-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530003627.42473-1-rosenp@gmail.com>

Hello Rosen,

On Fri, May 29, 2026 at 05:36:24PM -0700, Rosen Penev wrote:
> This small series cleans up pata_ep93xx to allow COMPILE_TEST on
> non-ARM platforms. Patch 1 avoids including ARM-specific asm headers,
> patch 2 switches to unsigned long for the data variable, and patch 3
> enables COMPILE_TEST.
> 
> Rosen Penev (3):
>   ata: pata_ep93xx: avoid asm on non ARM
>   ata: pata_ep93xx: use unsigned long for data
>   ata: pata_ep93xx: add COMPILE_TEST support
> 
>  drivers/ata/Kconfig       | 2 +-
>  drivers/ata/pata_ep93xx.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Your series looks good to me.

I do not think that you need to address the pre-existing issues reported
by Sashiko.

Intend to wait 1-2 days before picking this up, to hopefully get R-b tag
or two.


Kind regards,
Niklas
