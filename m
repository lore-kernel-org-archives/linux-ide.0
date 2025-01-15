Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA948248BDB;
	Wed, 15 Jan 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937850; cv=none; b=Y60Z2R8XjI/KUFN3Y3TkYS4CZLZ1fYi3slCfauVfpC55nFls0a2q60dE21+3jncpHVQioaYXYQ+rf8zSlPvUCH7n2dcWtR0+I47KfZtf6fU/wszbcNrgE+dvxAZQx06MeC5eHIOiJELnhVF7+yc2OP0Du3NKvont7bw5OnndXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937850; c=relaxed/simple;
	bh=Rh9+zfbblKTz7REy4vq9oXWLyW2wZUuPHguspBBF3yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQgXAHhyyaAwaUTb6rnTovcc6LcZLTP9ZeQMiUDY1umO4i6nnlRURggXFQiA2FHWKndkC3dF0YBtoJoTpcg3tlb6mLB0VSjtxwA31JtZK+fwHKbIVC4SqlAWyJkmoLbMMUP2M3/MpURe7VbXcEAYFAGgZOE76R/qHokYlQzIh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m718dBXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m718dBXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E493C4CEE2;
	Wed, 15 Jan 2025 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736937849;
	bh=Rh9+zfbblKTz7REy4vq9oXWLyW2wZUuPHguspBBF3yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m718dBXecQN4+ocJDTZ1eOSTh8C1dZ4FNX4xRlM3rKhzpEmNOfaJm2IX4kJRF1G3W
	 xQh2H25F9Fwn8SZQLqbT+pmACfC1JQKx8FpUvCjIrLwOaDQIXiCcCxpXgFwhKR8Nb6
	 rTM9q5pOZ5JGXvDeLbUAqno9R3ZjQUW1P27XAv9tk2dSsoYAKRcEvD+lOiFGKRT06u
	 jX72NYiHvM0qsFXWYVC3bER3JAHWKFMA+zKBGpqxUrACCuXfHH0Y5NUmNRuC6tB7pm
	 ZGtwZpQj2ZAoKbcchwewCLMLSr/uJa+xVRdwx/5CZLqFSi0p84VC9Rh/8GPh3edK5F
	 KP4Z2kJrYtg2g==
Date: Wed, 15 Jan 2025 11:44:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?Q?Rapha=C3=ABl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ahci: st: Switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
Message-ID: <Z4eRdYc40veNWcxl@ryzen>
References: <20250109175427.64384-1-rgallaispou@gmail.com>
 <07a7177d-7705-4eb5-a11e-02a9429ffac2@kernel.org>
 <Z4EDKUb+hO0ovV2i@x1-carbon>
 <cfecaa65-f6bc-48c1-9295-9bfe18f13db3@kernel.org>
 <261f9fac-82de-4f39-bf5c-cdfcee917588@gmail.com>
 <88fb7ad5-e2b3-498d-82d0-cdba8cf50c1b@kernel.org>
 <a5608ccd-e427-404c-8eb7-f189591a57e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5608ccd-e427-404c-8eb7-f189591a57e8@gmail.com>

On Wed, Jan 15, 2025 at 09:28:08AM +0100, Raphaël Gallais-Pou wrote:
> Le 14/01/2025 à 01:59, Damien Le Moal a écrit :
> > On 1/14/25 05:28, Raphaël Gallais-Pou wrote:
> > > > Do you want us to do that cleanup ? (fine with me).
> > > 
> > > Regarding the other ata drivers, if you have the patience I can do this
> > > in a few weeks.  There is other things on the stove I would like to do.
> > 
> > OK. We will work on this.
> 
> Sorry to change my plans,  I actually started working on this.  Is this okay
> to let me handle this ?  I will try to submit something promptly.

Of course, I know that both me and Damien are quite busy at the moment.

Looking forward to your patches!


Kind regards,
Niklas
