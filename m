Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5848E0E4;
	Wed,  9 Sep 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949617; cv=none; b=W1a3ASuu9gmwiir7YZujWdg662pLgVYP3XaGRDF1AyYRmNzcTunIwNKMho2yWeGpJVrONQ7TvGFE57fcO8raBm/54rREo8+HvCLcjIE16KVVnvKlZGsFe0FfcQfrzStecsbJbEz8+KHwxwUHqtG04UnBvBExUtdffZgC/C1hyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949617; c=relaxed/simple;
	bh=MF7hMiu8iCFzdoHr3+1me55Axz+QZtd70M9LEpC5P7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHQTp8NOeiBJcOwy9334DfBoHObdRbjaM/N6RjlwtWR9ipnIzP5N1oABzqQAHx6uxQhRiS6atcyZ1NNOgpJXiz3w5ZNQ+jH7ycMzSwDlvifuN5eljSBnc2Q8fPkgEpxvIiSbfTWt8cUfwUf6QTR9U2gAv58cUkaYu980rCwuNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEvaC2et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEvaC2et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49271F00A3D;
	Wed,  9 Sep 2026 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949616;
	bh=Z4AAcfybyycO9ePQy4CJTdOBX/SLCpxXhGObUhkPJPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FEvaC2etirXL+R5yRYIZ0k12BcnyNIU+VcRZDXkVHoYcAAhjUBajhAFVoiOilza9+
	 H8yYSVRqQIEX8t+DNJgZTmpd8ycG+detHeYOz6l0qZEuxDAxsy3t9uq53IjNWIw1Tx
	 Wtqyh4tNEHgXiQ8WGwdG2fYmYS3OTZovBiG1ZOBv3vLzEwAL/chHPV5YVsO4ylG/At
	 zJh4M5i8Tug1tKPtpKnt8zhKg5qsVC7llpmWAk3HyngdO/9v0MPfSle5F9B33u9gkX
	 5DVQgdZFYA4neZLkW6uD23MQlFwwpe7z4C0VJp34GsHxHVYBzogxRZN59V/81lxdpO
	 rX8wbdzZg6CSw==
Date: Wed, 9 Sep 2026 12:26:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Mans Rullgard <mans@mansr.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] ata: sata_dwc_460ex: fix data race on
 hsdev->sactive_issued in interrupt handler
Message-ID: <aqE0bJHPwF9Rer_E@ryzen>
References: <20260908214212.597139-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908214212.597139-1-rosenp@gmail.com>

On Tue, Sep 08, 2026 at 02:42:12PM -0700, Rosen Penev wrote:
> hsdev->sactive_issued is written locklessly in sata_dwc_isr() before
> acquiring host->lock, while sata_dwc_qc_complete() performs a
> read-modify-write on the same field under the lock.  This creates a
> data race that can corrupt NCQ tag tracking state.
> 
> Move the zero assignment inside the critical section so all accesses
> to sactive_issued are serialized by host->lock.
> 
> Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")

Fixes tag seems wrong.

Commit in fixes did:

-       host_pvt.sata_dwc_sactive_issued = 0;
+       hsdev->sactive_issued = 0;

        spin_lock_irqsave(&host->lock, flags);

ie. it simply did a rename, so sactive_issued was assigned to zero before
taking the lock, both before and after the commit in Fixes:.


Kind regards,
Niklas
