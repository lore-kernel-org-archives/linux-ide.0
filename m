Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5053DDAF9;
	Wed,  9 Sep 2026 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946060; cv=none; b=aMvpkxWg2WTxxeo72mYBI0+FiIFObpF1RP61iv6EX5j4pjDwSB/qDSqwH3cDUtMv8+p3GqzDKAy4rrcC02xWP/I0vpoY2Hd0C7SbQy5A2xX1ySgkyo9l8svBpepj3FLV8Dc/gbsx0BcOO7F4F4BxAEqX9Qq9TftWRHJJfdrvfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946060; c=relaxed/simple;
	bh=cMtY+OlZvXnCmWMc74UhI/h6ytHWZ75p+IOydXYRyEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To6c03b4tCn+UpY9Pa0MFubZGMwiOC4I1L+Dz0QwAh5mVQIHP1CRoBSgj2XRrDhxKb72vAYwTpAbvYDrQWmwwe3+DA+nvHxCwsMISrbEvMtKkEu5goUMo++d6z/U8Xa0logfF7x1trdidYwSwWuT6uKMkY0p/c/ZwlXdjMELWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doqP2yZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doqP2yZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013CE1F00A3E;
	Wed,  9 Sep 2026 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946051;
	bh=o0951nSG+rxS5NfdN16h+hq0RtUDQKHbZiM+0cviWtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=doqP2yZowAoVYjhp3ZmJ6eCm363/sejxhrWbJriBOJruRb3GEMb63p21RBb34l3YV
	 7/h9fzt2QelAt+TWqlvSvD+zLEKo9ZNSF+Icbuj86Y4P20GaYY6jCvJ9ADeyI9t+mD
	 aLmbez/GgP1m2oRi89nL63lnGpoR/UVvEAdRy92pfrarIhBYqz68Z6DOyoZB+QBS7d
	 nB0iJtFGpxmE5MBlaCKQt4PHla57kz+Ni+4aUfNSX1jyHBNkkvpmT5KrsGkCRT9w6o
	 9Di6EZ17x2mJUPzUeAkXvcJibAixJhXWmj5yYtv0qgvZDoXdVl3J8Wjg/IOvli7ifu
	 06AW9AjSCF4mQ==
Date: Wed, 9 Sep 2026 11:27:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: sashiko-reviews@lists.linux.dev, dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
Message-ID: <aqEmf-68Dvw-zj_6@ryzen>
References: <20260908141538.731237-1-nik.borisov@suse.com>
 <20260908143042.964151F00A3D@smtp.kernel.org>
 <8e426afc-b534-454f-9880-2b25764f370a@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e426afc-b534-454f-9880-2b25764f370a@suse.com>

On Tue, Sep 08, 2026 at 05:34:51PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8.09.26 г. 17:30 ч., sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> > 
> > New issues:
> > - [Low] The patch introduces a `goto err;` statement in `sata_dwc_probe()`, but there is no label named `err:` defined in the function, resulting in a compilation error.
> 
> Fair point, however I'd like to hear from an expert whether enabling the
> interrupt without properly registering with libata core is fine or not? I.e
> whether this particular fix makes sense?

Your fix makes sense.


Kind regards,
Niklas
