Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F4269CF0
	for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886855; cv=none; b=vCBC/D7nUfGXyahUzwr9rxZk7CgDV/jvENGDZm2ydHvBiUUKpdDSKn03D1+oxmg/f0OCX3voFTFKXFrraLOQipOk8Qx6WGB5licLyzvJC9QRPZtyAz4xgG/cNuVwtHJ1+EIFG8Sx9gMcIeGcLkSCQRUyUJ2odv3h18PYzXmRD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886855; c=relaxed/simple;
	bh=VzGfcz72KQQgcNuiZFIWHULVI2KF1C3QLfBCBPInql8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D27AWlnoaT/1EzGfR307kCsHx+KO4XCelwv05ScBkbf4Mw7MSragDGkyp+lKlLpDmKY3Sk+od2sQXlaAMjjTgtPBKqyZeulBkuCkQyvNF0JFv8U2BYS/S++F31Z7whTQiOs6ODNTQZZR63715cdbGqhGd04WApqw5vji/5c5D5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFi6xecU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFi6xecU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CE0C4CEE2;
	Tue, 18 Feb 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739886854;
	bh=VzGfcz72KQQgcNuiZFIWHULVI2KF1C3QLfBCBPInql8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFi6xecUwRAxDukt8n3/3ojtL4FBsjYMaUjFFKK4faO878pgkoCxoo4UO9hiRORPn
	 UM1wLMV4nqeRPCQq/LSAPxjyjFiiwcB58c4KaF7z6CHzHHlc8KxoFACa/xi42CmruK
	 4Ae6GjTbjJqJpL0uBDPpSFVgoh+GmwYmIKFn0OCsMJTtYLgLPqsTg1ed2W2FSkvaMM
	 Z6Z2+S03eapHxIn2g93ChUlkP8SPwEW6M2NggIDV6fIH+B8YUdQlUSUjps8DFSODH4
	 i++TiYpKlB6Ky+I5d3NUdsRdyIODG1diUh0nfvNXrscTa0E8FWo+RTSYuOER3b4Ucz
	 019bFPuC0WYCw==
Date: Tue, 18 Feb 2025 14:54:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Samsung SSD 870 QVO LPM issues
Message-ID: <Z7SRAoABAXsPbs6w@ryzen>
References: <Z6MjZ1Nniwn_uldf@ryzen>
 <Z6nePJ38aL92agTW@ryzen>
 <bca345e0-391c-432a-a294-5da36bfcede0@debian.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca345e0-391c-432a-a294-5da36bfcede0@debian.org>

On Mon, Feb 10, 2025 at 06:00:07PM +0100, Daniel Baumann wrote:
> Hi,
> 
> On 2/10/25 12:08, Niklas Cassel wrote:
> >> Dieter is using 'Samsung SSD 870 QVO 8TB', rev 'SVQ02B6Q'.
> [...]
> >> Daniel claimed that enabling LPM for his Samsung SSD 870 QVO drive,
> >> caused them to stop working.
> 
> We have different firmware versions and all of them don't work for me
> with enabled LPM, however I don't know the versions offhand.
> 
> I'll check and report back on Wednesday morning (not in office tomorrow,
> sorry).

Hello Daniel,

Do you have any update on this?


Kind regards,
Niklas
