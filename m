Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD8185E53
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683192; cv=none; b=G33oXs3TeYo3VtbgDtrwS3+b9EC+e2bTamk2B1owazIkcmwbjYzP+0bkLuSKbiiNG2we3aTXhIWJqLaoC3TK/n5+Xm7HfaSGXvtguZlZOeF1diU20jxMerSKxaxOEyna0IuJ8CTNe8dIaJ3YTLpNNVradb85mEn9joTBYBKAZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683192; c=relaxed/simple;
	bh=3b/FT8jBlGo0PtZ0giGMEMlOAiARzdrkX8GwL8AqvQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diUFd6ao64deUvp52zGTKZSDqIy72ur/rTcQm32vy5cU3BWmkmxJ0+TMsDCqbHBXyfmLcSIpL+6ZmaTi8mVwlMQdmb1SWTVSLSKYIWYwu5ZGj7ICEm/iO8A4fETMDvvYhqo7N5GZD+Xebj59g8n9c2vezPultQh7n7JXIpshleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE35NXIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE35NXIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEACC4FEEB;
	Mon, 26 Aug 2024 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683192;
	bh=3b/FT8jBlGo0PtZ0giGMEMlOAiARzdrkX8GwL8AqvQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE35NXItHnQ8/APq4gMXo7FuKDdo8ApHb1m4ljyRzl8vJKv5HZeJjTiX2s6We/mDA
	 zgYS2Hj1e7nZRQQ1HmQNmSi7xbN57854GQH/x3SMRE8PdDWJrdhjqKBSWufjjEWWvG
	 TKNyuGDGZmMsaOsFbQiIVhKdYr+haMDWzX7Hi+m1Uus0sI5HNC9E8XDH6yACeAmxLk
	 5E4fXhEVzy32TvKmycMvjLuo4R/Fvoieiz15DvFnmR4w1mhVXe4fAxf0NIX/x/Z9a6
	 6hpeRrND9u+1P3sQXKcCFY0hKL0W3Cwy0cEiyZHktrXn7PI8VHBRjDvdZOXbt3dJaK
	 sxC3XonmWpVPw==
Date: Mon, 26 Aug 2024 16:39:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 4/7] ata: libata: Move sata_std_hardreset() definition to
 libata-sata.c
Message-ID: <ZsyTtGKFqdWjWyY-@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-5-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:03PM +0900, Damien Le Moal wrote:
> Unlike ata_std_prereset() and ata_std_postreset(), the function
> sata_std_hardreset() applies only to SATA devices, as its name implies.
> So move its definition to libata-sata.c.
> 
> Together with this, also move the definition of sata_port_ops to
> libata-sata.c, where it belongs.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
