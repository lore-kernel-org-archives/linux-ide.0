Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B2346FA0;
	Mon, 31 Aug 2026 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161467; cv=none; b=LJXpnpmCdjKCFL88U2T7i8iFuSiS1oxAaoed+Szof+ZhugPfWd6ojg/QsoImvH7B8Cszf/jyB/5HGv0ODLixSmviXmlGaL0y70YAEUcbniJZxeoE6/teIz3QqEqwB/E5YC6pzsLkmTEUW+5GVkb8sNKRoUd+CgSy5W2d8sY2HMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161467; c=relaxed/simple;
	bh=pQEZ6Fsnk8Y1FJm9K1MtBt2K4W7O50VEEu5ZBVlnfUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mdKnODaWqHyFBu0lcwHIdnWn8Tcpa0/GMMjWlOZTg/aqTIsuIQUZZg0wiWwJfenXKgH6U23JqrbRhJn9qO1xEQFM+qTlinsXcZmr5glDe5bNRB8OLJKwTjsJZCkc5FZ2sgodOKXDHaU2BqD/QToG9K+TaZ6yoN+jDs84ikBxwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuFr06G3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuFr06G3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B041F000E9;
	Mon, 31 Aug 2026 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161465;
	bh=NU8hn5C6Bdl4vOTwsV3m5W+8YUuPfz9+nFyQzNo86x0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UuFr06G3RiHsRIIPtTpVUXqNCSr2RK1RAxm9DCTLY2EsIUfwMV78k3tcbAVWZWErF
	 JQlk3EVwXi2TfhDPcYK7NpS5xwuP7LZYbWEermJYHSJxehHwXE64Zs9GauwUHtw8Ra
	 ZbWueerlAsCc45m2eEIyvCpzXnu0DBsWrGMTXrToJ3Qne38cOCj0N52iYQGgkNm+Hb
	 8VJfTTynlTMAwq57KwMcqpxXEY8c0jaU6UDw1hK3FAVigmcX7Pr3Rr51g16mJlvWGV
	 0eqIn2MiB3IFeolkMVeLirnEdx2vHlGkgwQMSZ6kKUudICCM2RAuOa6qhbfius7oga
	 x0pnUmW1KpDNA==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260810132502.460566-1-vladimir.oltean@nxp.com>
References: <20260810132502.460566-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH v9] ata: add <linux/pm_runtime.h> where missing
Message-Id: <178816146465.164769.5545608485416070644.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 09:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 10 Aug 2026 16:25:02 +0300, Vladimir Oltean wrote:
> It appears that libahci.c, ahci.c as well as the ahci_brcm, ahci_ceva
> and ahci_qoriq drivers are using runtime PM operations without including
> <linux/pm_runtime.h>. This header is somehow being indirectly provided
> by <linux/phy/phy.h>, which would like to drop it (none of the functions
> it exports need it).
> 
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: add <linux/pm_runtime.h> where missing
      https://git.kernel.org/libata/linux/c/abf62e9d

Kind regards,
Niklas

