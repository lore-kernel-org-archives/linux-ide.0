Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AB1ACDE3;
	Tue,  1 Oct 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767534; cv=none; b=rt+YNyjVbiPoEVzZNoYlH8FQM2e2UhN0HA9JNuoUQskdvt729cWwhBvcm/GZ85azsyuGamfrA3MsU+MPocddkdRaDSotvIfa15fsPPBcckeFQFSEXnPBf/zcUHSOpyhfnIc4ubHCDE70o8WJI9QbsnXF/W5TrJNZ+QTv3qqlZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767534; c=relaxed/simple;
	bh=ZP1FgKxbC+L7gJSL/GdE67rcvYp4uTOL17+6wlaX+Ng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V6odJluDR77L1JL/01B3SQ1IJuLLYK0q8PKSo4htMrTuJ4/4yK+7g8uoPfvVrdDgyusuZeWBhnPbvwBF0XaIB/Ac7rPOjyE1lNJuahBR61v2p6vo0T16pHwFPXSQhgQd4QW3l+p06APVlJlEu3aBVXiON2NJeqpwY4VzqkIXbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrhzgqpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrhzgqpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0A4C4CECE;
	Tue,  1 Oct 2024 07:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727767534;
	bh=ZP1FgKxbC+L7gJSL/GdE67rcvYp4uTOL17+6wlaX+Ng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JrhzgqpCci5mDJIquFndbxQ+7frnzX7Q2Y6zEeAq0XTkFyrrBThCSTeWIBIA5RNa+
	 nhW8pwTBVUY+F3/WcESrKZUb4e06WO59/oHspQUmBH9u3vx5vbiMDEtpIIpiTwgJWC
	 sS/qyT8vsyy6ahU16OToKsCA7WR70XSKlViKcT9fwfKNH4X4SEEMg0GJuhWTHI5WPH
	 bv4OQOan/Nexi9kdZl7qEuE6sDVgT07fNmzjq5fCgOyjmCKXRRsw4mXxAolvvfsINn
	 WfNuiHnVfYBAy22xGspBSVkSy5NZTnKNuKCAMrOPnNFcvDFqq8bF1fOcFEqlSfOIUH
	 Zkg+FTBSb4MIA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 Yan Zhen <yanzhen@vivo.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, s.shtylyov@omp.ru, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240927060056.221977-1-yanzhen@vivo.com>
References: <20240927060056.221977-1-yanzhen@vivo.com>
Subject: Re: [PATCH v3] ata: Fix typos in the comment
Message-Id: <172776753169.28176.15276797442572104038.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 09:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Fri, 27 Sep 2024 14:00:56 +0800, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'multipe' ==> 'multiple',
> 'Paremeters' ==> 'Parameters',
> 'recieved' ==> 'received',
> 'realted' ==> 'related',
> 'evaulated' ==> 'evaluated',
> 'programing' ==> 'programming',
> 'coninue' ==> 'continue'.
> 
> [...]

Applied to local tree (for-6.13), thanks!

[1/1] ata: Fix typos in the comment
      commit: 794007a8c848dab99dfdfbaa2c7e143481026f32

Kind regards,
Niklas

