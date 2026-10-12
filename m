Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A86371D11;
	Mon, 12 Oct 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794573; cv=none; b=Qtxx9oN5uZ6A7WVhis/QVj26aZ3pbiHc7GayRNNze7QW/HhqrQvM8R8CtDMloFDT8eJfQA6s9JBYY/Mdph9y4RDB4pcdiFxkt4W1iSPs4f1QgmsY4nkpqGCsSQKqU6iLfBk4sB+3PuhZhQhK3fxYL3Oh0mQqqLaM5q5syXj9jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794573; c=relaxed/simple;
	bh=UKeEdOv5aVhCCI4SbEU41nI044tz4/pAR4fAMlHsSkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNhvGZVhxHfE39tqqkJNzl/o8YxtlMg8wzTmNcUWiTw/GunvZZBNoa1Gk1zRpQ2IkC/FAXm+47TFJ0oiXU8o4ibmLaVUjAUr/yzPjYNuh8Hb+qLNzIxYxG14Pw/P5WP9VbTooUU3zSBwo6jyP4Z2RWGVWZudKmzpZDvDXgwvkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLmT6wpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLmT6wpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711001F0089B;
	Mon, 12 Oct 2026 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794572;
	bh=rUyD3ajzzRHRDIPPD8DcR4xDrGs0JYK498USmcK5RcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLmT6wpLrb0IDCnn1KWq/eX2FHaSov8PZT4wrN9TeOD22GbV5IVykMVt4s8GT1w49
	 ynh/2MOZdfmxNYOD/MD2i0nlk7oOgG8gvG3L9Zu3ylmKDQ+nd2nnYef3lzvxCutb4u
	 Hqe0WVIb0W9FQvw5ZsBI1qHUle9u8a5sJoLdJ8K+CKLo6Ys2kcfnvU9Jgu8seZd4Us
	 RKAXLepdjG153AkbXW0Njf09V2nDvnI+uHayRl8si4MyULpTK7uPYG/IH75cvA9guE
	 bOfplJX/z4gMtnIjLO9/aWuMS7f/KFYcw+GnlOYcmyA3BP8feSCstoJwQXqRtTtx5k
	 Yl3YdqjKlSikA==
Date: Mon, 12 Oct 2026 10:42:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Kyrylo Biryuk <illofspeed@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libahci: re-enable FBS after error handling on a
 port multiplier
Message-ID: <asydieBd75dkiWzX@ryzen>
References: <20261011180236.735-1-illofspeed@gmail.com>
 <20261011183126.389-1-illofspeed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011183126.389-1-illofspeed@gmail.com>

On Sun, Oct 11, 2026 at 08:31:26PM +0200, Kyrylo Biryuk wrote:
> An automated review (Sashiko) of this patch pointed out that
> ahci_enable_fbs() writes PxFBS.EN after hpriv->stop_engine(), which
> clears PxCMD.ST but leaves PxCMD.FRE set, and asked whether that could
> upset strict controllers.
> 
> For the record: this patch only adds a third caller of the existing
> helper. ahci_pmp_attach() (every boot with a port multiplier, after
> ahci_start_port() has enabled FIS reception) and ahci_do_softreset()
> (after a successful fan-out softreset) already call ahci_enable_fbs()
> with the port in the same state, so the patch does not change when or
> how PxFBS.EN is written. If the helper should also stop FIS reception
> around the write, that would be a separate change to ahci_enable_fbs()
> and ahci_disable_fbs(); I am happy to look into it if the maintainers
> think it is worth doing.
> 
> Tested on the 88SE9235 + 88SM9705 setup from the commit message: the
> hot-plug now ends with "re-enabling FBS after error handling" and
> "FBS is enabled", and parallel reads behind the multiplier scale again.

Looking at:
3.3.16 Offset 40h: PxFBS: Port x FIS-based Switching Control

Enable (EN): When set to ‘1’, a Port Multiplier is attached and the HBA shall
use FIS-based switching to communicate with it. When cleared to ‘0’, FIS-based
switching is not being used. Software shall only change the value of the EN bit
when PxCMD.ST is cleared to ‘0’


PxCMD.ST will be cleared to 0 by the hpriv->stop_engine() in ahci_enable_fbs().

I don't see any mention that PxCMD.FRE needs to be disabled in addition to
PxCMD.ST.

Presumably, if PxCMD.ST is disabled, why would you receive any FIS?

Sure the spec says that PxCMD.FRE should be set before PxCMD.ST,
but I can't find anywhere in the spec where it says that you need to
clear PxCMD.FRE before each time you re-start the engine (set PxCMD.ST).

So I think Sashiko is hallucinating here.


Kind regards,
Niklas
