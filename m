Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DB175A7B
	for <linux-ide@vger.kernel.org>; Fri,  3 Apr 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204344; cv=none; b=QEMcxqbE+oU3kp7n+rLfH3AMZe3YdJgE1hLmit6W6JZPw6QzZHLsn3r8kYc6U7958ctODjyTkGh4SLqQLoJiQuQUxyR7En9F/Gmk4Z9DSVDKg0vm0nG3wTb2ogNX3D9bpObiO7fSyPv/qyCScnMmcKQzR/H6Pv2kmMDRjFppTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204344; c=relaxed/simple;
	bh=noPti39zCNOgZ84iHdz/tQnVEnPjev+m5yFv/pouuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozpVkJNC/YhB9ytLLAI0rmEi3Hk94f6z2etlNAIDmOENTve/45ZqNIZLoS5oNVPoUnkEckId0jJ1OdbTRSo5h6/2SAduCVWMH2q6ErBhcJfv17XT6NWnsP/+fx/wJMGzOu9CjbwIQCzc4IaBGR8LJ770ATWxzAySoj9I7DHMrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHvYhHUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHvYhHUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49ABC4CEF7;
	Fri,  3 Apr 2026 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775204343;
	bh=noPti39zCNOgZ84iHdz/tQnVEnPjev+m5yFv/pouuzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHvYhHUod68d4PJvLI88eYeN11OVXplQeAcVZKRSggYDx31ze6u1t0GP2UvEx7YsB
	 hqq6kjQcvJ07pN92DZOJyPnuoaCft8b+qEP9wcJHg8JK9x9lqhyoD+9e/wHPyDr9H5
	 HKhAW9x9ErYW+0GYVVS/jWiLPEJf+1/21dMksWW+Ojqjs4QZNLrc/gMZR+gijEVIYf
	 t1nPBR+PBdjrLSnDWy+NCpmJjAmvzwNXJUcLa1ocYpTf3xo4sfOr5LhM7Tux266hQB
	 w57NoT7dKTCd/e8D6HSe+zrPKSQiiu3jfZTpIBT3+5BhMP07qmIGvz9zCH6MMCYOVj
	 Fw982XsXQWP0Q==
Date: Fri, 3 Apr 2026 10:19:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Arthur Husband <artmoty@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Message-ID: <ac939EPg02HvVmqv@ryzen>
References: <20260403050418.50398-1-artmoty@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403050418.50398-1-artmoty@gmail.com>

Hello Arthur,

Please also prefix your subject with "ata: "
(I know that we have not always been consistent with this historically.)

i.e.
ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585


Kind regards,
Niklas
