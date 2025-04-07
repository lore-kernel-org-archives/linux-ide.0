Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF25D3C0B;
	Mon,  7 Apr 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018029; cv=none; b=LhA4OFD/6ND3cj8GBUCDHDRU45XVBS9cFhyBdaepeH1vewcaVT4RRNV/I9bAVXd/wHJ1cL8yp890GpUkuFCTg/nTxIbLzk+C1m7UkT6vv9RuUHxHRaEPax7Xnr2i4/dqm9Balz46DczaGgviMcMqnrC/Y2msT6f8hY+OdQ56tVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018029; c=relaxed/simple;
	bh=rXEHGEuxHK31ihMMt9r5s/+C3v5fC7FBNn4rj7Av2Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV8qEjC+ixzcZsM8J5MIPzvEpS2uJbG+dgWECAultpvJoY3JR5GsF/QLayh+aFm6gobJJ4o6ifURrPiI2P7LiHPvbEk8Jwa7h8EWiTpfElZZuybLDr0KsahOS5DyK0Jt5NERvIfqtcZr17qKWDSeCy4ZN23vd5rUbARaZAEcZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeIi7nvW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeIi7nvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61781C4CEDD;
	Mon,  7 Apr 2025 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744018029;
	bh=rXEHGEuxHK31ihMMt9r5s/+C3v5fC7FBNn4rj7Av2Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeIi7nvW8psV1Ff1Pimq7/hjQIRRiP9JCtvgpO6UNcAe8xpdrbA5encAj31BhtVtU
	 KvFsVK7T7YqnBeIuvikU9xUbLuo5hqU9+vL87UyeZAcvoXRyCPhH6YkttnMl5SYXC1
	 HH2S+qxCBRZVp+dBF1XdNUwasUUrJ5jyHQKy8GnCxjzWBJGoRdeKphrtiRp1T1WJqt
	 9Vp6NQUhpheR16yDwtcWIlmFHK3TyOk72xXfIIXmjLD6wArx08nXCyktvc8MVS9Bi1
	 Wai8zpbQAfQsByA2GkJlVQd3dXfW1gvHW/awAmFPlq8/DS3xjw96WLA4EabHV0GhhB
	 v+R/9AehpaSrw==
Date: Mon, 7 Apr 2025 11:27:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z_OaafNRHhTiBzFG@ryzen>
References: <20250403212924.306782-1-ipylypiv@google.com>
 <Z-_JExGDyO9pVTON@ryzen>
 <Z_AweMPLRJgBIBF3@google.com>
 <Z_OG6jdsX0_uar2a@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_OG6jdsX0_uar2a@ryzen>

On Mon, Apr 07, 2025 at 10:03:54AM +0200, Niklas Cassel wrote:
> 
> If we look at the ATA Sense Data for Successful NCQ Commands log,
> it has a bunch of Sense Data descriptors.
> 
> ACS-6, 9.29.3 Successful Sense Data descriptor,
> does have the LBA field and an INFORMATION field.
> 
> The definition of the INFORMATION field in the Successful Sense Data
> descriptor:
> 
> """
> 9.29.3.5 INFORMATION field
> If definition of the sense data to be returned when a command completes
> without an error includes an information value, then the INFORMATION field
> contains the defined value. Otherwise, the INFORMATION field is reserved.
> """

Side note:
Considering that this is just two bytes, and the INFORMATION field in SCSI
is four bytes, I honestly have no idea what this field actually contains.

Anyway, the biggest question is what actual problem this fixes, since the
sense data is not returned to the user for non-passthrough commands.


Kind regards,
Niklas
