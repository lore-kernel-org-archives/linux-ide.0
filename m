Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830F4334D4;
	Tue,  4 Aug 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836828; cv=none; b=CtpkX3mloSZ5KAmMS8qZZFEsLC5irWQayTz9fPKBJ5KDnv3u8si+k7CD94QjnS5w2mspKo8EVivDZ2uDbulq6tQSvPlqE2nEYbH501RCGZRVzRvMKhKYsoUpBgQ7fXJCw/SOoWnlt2NU1kaIWflk6zrKXYtrK8KBmQ/iAh31CxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836828; c=relaxed/simple;
	bh=DR5RfB9Jr/Szr8yyQyniTzxB7tA9gtTi5PE0MKjMCR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIPajlKhIB8za/iDCqflUEQFCZtnQav5HaHk+BVdATjBFwOYnEcWSPSsDuJ9eN8Xrlk5GwFwIEFHKMSvldGll8jLFmrcfxbMRZRZvQ+kXntH6LOfjJWiiQZNT6W/PBWbFoVzpWeDZWjdj9mSG4cK6amfnR3LfwaDsfqS2KO7qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpBOGaDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpBOGaDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982E61F000E9;
	Tue,  4 Aug 2026 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785836826;
	bh=NBealrSblJ0WwAwbKvPCX56LremEBPFI6ouoK9k/dwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpBOGaDipiA1XDdzy2lH3iLMsn0stWlEokYBfxU7TAIajQdVNSrEegWWWOYAbN61Y
	 gIHDix/K52Xtq0rYOfjyX6WafG+LxD4qk4qBtmEzeL3+mVCASeVGR+wjLapjrQcn8e
	 XZiU9W1ZblkOWCw3YWgHaLHYEZnb7pA0XLAr3mjPfo7wz+oTLs/KFl+ELqZD/iIQWa
	 JGzywfxgUNP+nUKWuMtjbdezpWkb9APu9uqZl/SpM0bySL7U+h0F7S8P+8riMQS7aS
	 st9dF8yuSnaUUhL/mG8N7pTdcdfVcfEvxsLRHa4gnIKQz5h/WXSTkreaPGvzH1BTeR
	 NGK8jPcc2o/aA==
Date: Tue, 4 Aug 2026 11:47:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: pzalewski@thegoodpenguin.co.uk
Cc: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: use named initializers for acpi_device_id
Message-ID: <anG1FlnTOqxjf9CX@ryzen>
References: <20260804-ata-acpi-v2-1-8825e646b80d@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-ata-acpi-v2-1-8825e646b80d@thegoodpenguin.co.uk>

On Tue, Aug 04, 2026 at 10:44:26AM +0100, Pawel Zalewski via B4 Relay wrote:
> From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
> 
> Use a named initializer for the acpi_device_id fields which
> makes the code more readable and consistent with how lists
> are initialized in the rest of the kernel code base. Also
> drop explicitly setting fields to 0 where it is redundant.
> 
> While we are at it - unify the list terminator to have
> a single space between the brackets and no trailing
> comma.
> 
> Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
