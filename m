Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B883DB62B;
	Fri, 24 Apr 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039208; cv=none; b=Rt2MnnudeycRDIIXyck5VB31VHmS9uXzu4UUYKr8m4Z+ukbaVU1kCQIJ0p36AyzGi9lS8OpEqznWSOpqq+JKrjT8P6Qcscde6g/wBjLup6obn4biQiz2JDrU3g0f9K7VSDbqDOyaJ8RyKfMT05heEqvCkvACgLlvFH91lfg4DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039208; c=relaxed/simple;
	bh=SeW6iPYd3xGlfZcdHVYtjeL5z64t9zmFkAziMmjJk8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3r/M9TGk1H+xhIQVyd2sseVqXJ5PyCjZWVbCeuNn+uClF7cUeX7JqrUDjwHOsXFuUBE7BULirN4a008skNxfr1XmmwYt17uuTUNvUrfxmK2qvUggBNfpfIFXgFnu/WkMLWnCGS/T7ANOHPRcVX89klntgXXJ/Nd6wZVqV6jJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuuvGWM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuuvGWM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD14C19425;
	Fri, 24 Apr 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777039208;
	bh=SeW6iPYd3xGlfZcdHVYtjeL5z64t9zmFkAziMmjJk8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FuuvGWM+As4zIm46k95R3vjZFm2l2fH89I/gn28YGxOOizM9AVT0g3DnqoJzZdNMe
	 RGXTOaH+kl9iWFlgtJrpbRg509EPdEuJWyS/1JJdyZhaAgrP3cCJVeX7ht0lG8H/Ng
	 cLu0yrc9h5K9IkIS6skpNN+oiPW2iNtI2Dgk9dFpfJYtv1xiyONLOCyikqPxPchnGa
	 TMN5zWcQXixz9VQ91TMMk7faNnJqrvPgK5qPSxC91IyKWtrjkI2bb839anSCweCzmB
	 0E4pqKdPqyRhCL1yf6wCOu/WPz4S+doZnPrc8zq1v9rF7zXqcVbBzW47U4MP9PHsRs
	 VgdrJ5/wVaIrA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGH4g-0000000B1X7-1VET;
	Fri, 24 Apr 2026 16:00:06 +0200
Date: Fri, 24 Apr 2026 16:00:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_parport: switch to dynamic root device
Message-ID: <aet3ZhRMCSHcWoOe@hovoldconsulting.com>
References: <20260424103830.2616828-1-johan@kernel.org>
 <c5a202d0-3938-4bd0-8f95-b4628265840b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a202d0-3938-4bd0-8f95-b4628265840b@kernel.org>

On Fri, Apr 24, 2026 at 08:18:31PM +0900, Damien Le Moal wrote:
> On 4/24/26 19:38, Johan Hovold wrote:
> > Driver core expects devices to be dynamically allocated and will, for
> > example, complain loudly when no release function has been provided.
> > 
> > Use root_device_register() to allocate and register the root device
> > instead of open coding using a static device.
> > 
> > Note that this also fixes a reference leak in the unlikely event that
> > device_register() ever fails.
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Looks OK to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> I suspect that this should go in for 7.1, right ?

Yeah, probably, because of the reference leak which someone may try to
fix in the meantime.

Johan
