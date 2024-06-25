Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AA6E614
	for <linux-ide@vger.kernel.org>; Tue, 25 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304600; cv=none; b=b9z4sHqDH2lrVh+6rZg6wnlLi0zuhY3kbao6zklhdZ2EM/7v1c8b6e8X+K97AqFRc61sv2ksxgw0roLIa3pbfHZFfH2RneV34Lcl6RAVUhbcDkC9S01FDS/il6HJ2m9WMxEBmVnIPclrrHGsoCh2j+kbat+fH9gc85mZB6/JxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304600; c=relaxed/simple;
	bh=sh7X2Vgvv3PxowRN5xfnBxlTKFwz4fTUhmmNCAjOwsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7wvCSx1HVZGXwNl120iAOK6DUEazkuKPcQXTXDkBPJ3Qt0kE0hKS6jMKBwJ27LYnp2P1qCqa79reZwHnn1WOW34vSKy6DWD7FOKyPnktDKUjHRcpXdkjVokYOz8WKhSRsMPiuJT69Xakfknqw9bavAqhd91RcdS/IPxLFCy8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGG0hM5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGG0hM5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88829C32786;
	Tue, 25 Jun 2024 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719304599;
	bh=sh7X2Vgvv3PxowRN5xfnBxlTKFwz4fTUhmmNCAjOwsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGG0hM5YzFsf83/bYTz4eT6w/eFemKxzqhtjmPLTfVJF1Z8iVBb1qhMQhbeVoLcqO
	 J4gtVzWsHmA4DkSc8LpXjcEl2x6pCYHulenO3DVD4ILa+ZkrXPXzPVf4ecR9lexaOv
	 hHY/yDEUlbxFD9UwCoSwMejWO/GT2pMUZ7XMmuN35uDRbm8ItIQD9g3RonsXBcjE3D
	 CbDnkSWL53SRFV3/WwwK/EJOjdgpC24cJKtKom8hxtliltKidcxlqWLdJxJ0K+Fs7p
	 HfT01uCNpG0OL/ZJAp1zy3C0csOjX72vHZjuBdOxebBto2isczsTefZwY8YKXXaPCF
	 mXImAhvbGTgSw==
Date: Tue, 25 Jun 2024 10:36:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Alessandro Maggio <alex.tkd.alex@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial
 BX SSD1 models
Message-ID: <ZnqBkyxPp5IPARvl@x1-carbon.wireless.wdc>
References: <20240624132729.3001688-2-cassel@kernel.org>
 <82e310a4-5668-4edf-b3a8-2c7898a7c4cb@kernel.org>
 <CAOHHr1_3rigY3vM03uVkfpvbmNbvcPbxYyKBdktXkKsQBnS_8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOHHr1_3rigY3vM03uVkfpvbmNbvcPbxYyKBdktXkKsQBnS_8Q@mail.gmail.com>

On Tue, Jun 25, 2024 at 08:52:45AM +0200, Alessandro Maggio wrote:
> Hello guys, I've updated my full name on bugzilla.kernel.org, thank you for
> the patch.
> There's anything else that I can do?

If you know how to compile your own kernel, it would be very appreciated
if you could test that the patch actually solves your problem.


Kind regards,
Niklas
