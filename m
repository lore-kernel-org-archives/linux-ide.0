Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7778299AAA
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885016; cv=none; b=iSBM/Wr2+tciT27HmTOU/7juCgG+uAVNPy9wWwnfLhX31AbE5ZiseazeMW/kgcaccEWxIv7JIjsEySYJ2YecU1PEuAq9PzPVc5Y+PjirknMMm816fvajsX9N1x3BemPMZCLbiTcAt/GUGOePm1sDhfpc0mSPONGFUUD+FqHhm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885016; c=relaxed/simple;
	bh=Sqb48PEAXMzR76MLNx+uIy9vO5ureTRWsQ7iBAXc+sE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ItxR8QzGtGr+KKOzV9mR/HuxM9OGR+d8cNJ3ecItQ7TGthApUegOpWkf0CILuHrMv+wSFl36aFSfeIa6cRHT1ChJAKX3Azc2gjOh1qyPJa78+wCByC1UogRe6R9YT8KTJR9+F1WRrEbiAtqxiTh4XYMyPDr0+U1/JcZQGS3/5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igQ3jK4j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igQ3jK4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1290C4CEE3;
	Mon,  7 Jul 2025 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751885016;
	bh=Sqb48PEAXMzR76MLNx+uIy9vO5ureTRWsQ7iBAXc+sE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=igQ3jK4jvOqUhR2KZth1nv6siYsoYIhaIdgcyoxJmShTpAbi8Cm3w6+0Aad80SzhQ
	 D2BarEZx1iB9gfOVjfd9qNNP+F79sVA18PAB1JTDippe5EfL1pSweZzqgK/EHy58T/
	 KaYGGQzqdu4UGrlJVy/g3qg2WRTTnic50HaGXMK7o5em5fsaH4U2r5QSTkXg1m279U
	 yW17aklBlBQAFs3pzYAlreF87Z2SPZtM1kLXO19KeuOq6eNpqyrBOTgKmLYz5dfVzV
	 KmEFX0Zv9QNAsqe96hWwVn4JsACZWONGdZcnebB3nhEhNr+Viz9bxGBv68PgEQk5by
	 wL345u3ru2Uuw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250704104552.310630-1-dlemoal@kernel.org>
References: <20250704104552.310630-1-dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: use bool for fastdrain in
 ata_eh_set_pending()
Message-Id: <175188501565.569970.1241661070606775882.b4-ty@kernel.org>
Date: Mon, 07 Jul 2025 12:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 04 Jul 2025 19:45:52 +0900, Damien Le Moal wrote:
> Use the bool type for the fastdrain argmuent of ata_eh_set_pending(), as
> it should be.
> 
> No functional changes.
> 
> 

Applied to libata/linux.git (for-6.17), thanks!

[1/1] ata: libata-eh: use bool for fastdrain in ata_eh_set_pending()
      https://git.kernel.org/libata/linux/c/c5fccfe9

Kind regards,
Niklas

