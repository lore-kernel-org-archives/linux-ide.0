Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEB1EEE6
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683183; cv=none; b=O72D9PPJabbu0k2B9Bp6STg6IQwdbBS8i00+GA2C6iqv9cX/WF0/azcMvXDaB7zIwu2Yh/OxXTJLJ4g4hCljDECDp72Op6XrHNo2m0qdf1VokwIb0Mc/KU5Ard73bhhMEXxFS47a/K/IV40YjCMvkENy1Rz5Uj6V0fO0mVxT+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683183; c=relaxed/simple;
	bh=6JkyiIoowJvlbWCGXB0WhSOUahP04FnyNHm+1BH3B6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h23ze7Nn6S06teynhr3o6VxGGgpVuKjMBBD4l1jy3xh73FIiIwylLh0fwXyzS1wwDwasgTYf7PkM8i7Znfti4MGPXhkDoqBPQMVB+2qJYvncxtAGqzklfT0gB1WJ5DrSjCdNAounr6WhyE3DBUU7ccXJqFqn6O3L3p0M7tmTF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S651SlTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S651SlTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20902C4FEEA;
	Mon, 26 Aug 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683182;
	bh=6JkyiIoowJvlbWCGXB0WhSOUahP04FnyNHm+1BH3B6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S651SlTKjdmdyLNMc+FOpvr/TMYziH72Iy+XUrcN6OpfwjSO6fEfzcmiz3NmTjj9l
	 hu4J6/gmaAeaODiePVUrNBLrLXB6xnyh/fsk6DEfvO8RIHYzSIFBLE+3R/FBwUVZ5f
	 gSqz2tS1qSWfRfdiPKJ2pGlg5b1SxONkukE5kUqtmKkm7U1yvuvqDMYYNEVz7n392W
	 6zK4q5Q5MaQb13HU6b4jUNlRQWu+PUiAojYgPrSFwWfdyaoR4i/XdAKV1FYlX98aaK
	 csu3zAK6F4seZjHsQwiiREZ+rYEW2L6l9FtY4hDdEWfEYRFvpFQ1j1ARvA7/E6EUS/
	 2oBiP3duTGyNA==
Date: Mon, 26 Aug 2024 16:39:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/7] ata: libata: Move sata_down_spd_limit() to
 libata-sata.c
Message-ID: <ZsyTq7UBTFMemKYz@ryzen.lan>
References: <20240826073106.56918-1-dlemoal@kernel.org>
 <20240826073106.56918-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826073106.56918-4-dlemoal@kernel.org>

On Mon, Aug 26, 2024 at 04:31:02PM +0900, Damien Le Moal wrote:
> Move the definition of the function sata_down_spd_limit() to
> libata-sata.c where it belongs, together with sata_set_spd().
> The helper function ata_sstatus_online() is also changed to be an
> inline function defined in drivers/ata/libata.h.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 85 ---------------------------------------
>  drivers/ata/libata-sata.c | 80 ++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata.h      | 17 +++++++-
>  3 files changed, 96 insertions(+), 86 deletions(-)
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>
