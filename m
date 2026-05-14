Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CF3AB480
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741355; cv=none; b=rEGrRRFR3mz6nJ9oDUA85G8BDRzRHWyh1aObPSZSLypVlkGc4xi030yfFx6ddTcU+RVV2puJ+4YQA7TsxUB3dPjlhO6PZoyBa7vg7V+fNJcRXE0bqiFWNRz9z3rM++3ihTQ8z6EGyuecQxc8eOGV3E5BYWTNiSqW8enEl8pvR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741355; c=relaxed/simple;
	bh=7nVJkMjT9OLPGOinxVhfyggpv/5wrKPGZmAakhZNjqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geqfvh3qfTq+DvtFVfnE0W6hiHCJHNd1ZXncRJtvDstX2mB2vhbpiYefwpe731/5M+CCyldvKv4Cn+SmDhEpQwvPcZ0Yv8mqf0SHS9KlR8cXGdAU8x5OK7IPwM/0LQN5Z5BLwn9Nw5KU4ziv+9r4IuODS1B/Ge6ID4ah2UIskZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kouSdQEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kouSdQEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9C8C2BCB7;
	Thu, 14 May 2026 06:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741355;
	bh=7nVJkMjT9OLPGOinxVhfyggpv/5wrKPGZmAakhZNjqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kouSdQEwRlf9jKm0Asl4WFm44bFWtCUO7fVqtpigC5AcHblzxt5o/S1d9Z/dVeJaA
	 /BGMNTJHLyc1wfP9BOpBAqyDeUJQlhS0KVMyTSfRQoPk9UsaAsMmJhB64uvEuRvimy
	 WH/qaWFUxLmX/QEkr0+i9YEcUfIgcY7Iu6kulQiSpMubw4Ecz0HebVui72FEzT0lLg
	 Xu6ogTMTER8LEER9R1O+m0tmnnYz1KwwIk+g3fgLIn/KMYb9WJ5uwk4bGVJcA4P8ym
	 32tPsAeGSocfKXcHADv4jOk/J8pZ/Citb3gswoNO/6vaF87l5W436ah7T+lM9snFjW
	 M7aMflmP1794w==
Date: Thu, 14 May 2026 08:49:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
Message-ID: <agVwZ6wPDdtIYhOI@fedora>
References: <20260513151359.1075403-6-cassel@kernel.org>
 <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>

On Wed, May 13, 2026 at 09:09:35PM -0700, Tommy Kelly wrote:
> 
> Then, some power issue(?) caused the system to go read-only and I can't debug
> anything because I can't execute any programs. This has happened in the past a
> few times. The system crashes after a few minutes in this state. No logs are
> available because the log system fails. Unsure if its related to these patches
> but seems to happen when I build my own kernels. For these CBS tests I'm using the
> unpatched fdt from u-boot v2026.04.
> My root/boot filesystems are on an nvme drive, not the SATA PMP.

FWIW, if you want to build using the same kernel config as your distro,
you can do:

$ cp /boot/config-$(uname -r) .config
$ make olddefconfig

or

$ zcat /proc/config.gz > .config
$ make olddefconfig


Kind regards,
Niklas
