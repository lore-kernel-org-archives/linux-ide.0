Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA7563FCB;
	Thu, 10 Sep 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062009; cv=none; b=cRvY68QqCqsrctRfk9rQlrAm9rkQtCOnPoyL9mYVcHVXLt4f3unErVpkEexT+wYizeKM4NqBWOME7dJSkhEOqMI9F90CXMO4JG8l24b/tN6FQ0oN7siI2Y4ig7dRBaY5/pDGte+xDecEigwViLQYp9RrxElnHXXBoKUApmHyFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062009; c=relaxed/simple;
	bh=Re1nNjc88tMIq7kazi9QqOCRYyikuB7Slre5d7DUpYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB1lXxZk7f/gyHBxfyQxgvKdPsH0qfvZthIvNZQeloShGwehXCiCb6ghOMcNUmvLLt78t6Qh+LEpFRjBHiK5iGo04mg8wv9lF81QLfDLPz5Bl2oGr+tqqeirZzSMkV+wi26t/lC/RsNkmQI2zCzFouivA5So1rkSpyWVswiIVtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MANb+xxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MANb+xxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D5F1F000FF;
	Thu, 10 Sep 2026 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061999;
	bh=T8CoS2l+O0z0tAlSAm+Zvv1ub23ICl3ib0aFRyAwxsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MANb+xxt56K5ryM97uUDpad5A0EkZdBRuKRjmiPUGaO2NxE7F/Ik6FglUTp1lvDyt
	 VnoxqJ1VOtZk6jzaMbI903ZztLG/IHU52TjnPATCtHCEFcg+pZ9rwzcthFbiyt5wxk
	 KcUZhB9F1H6sBvGuoIuouTmiLmJ21i5UqkNOGOw8Dgu2Yt+IGtbwPjLXaM1ZJVZl/e
	 rz6aPwGf4k5DJ5BwVgZwOmhwpkL6J6bXgCz0qOhUTdoIShJLrk/bLaoKWurO8u4faS
	 xHFv9K21QrFvgAxwFYdUYREaFR7/cTHyWAkom5drSJPC051ybzNMWLabeBq1TF60f4
	 +eP7yzFHvnhpA==
Date: Thu, 10 Sep 2026 19:39:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4 1/5] ata: ahci_st: Assert the power down reset in the
 probe() error path
Message-ID: <aqLra9zRifL_26LJ@ryzen>
References: <20260910171406.131211-7-cassel@kernel.org>
 <20260910171406.131211-8-cassel@kernel.org>
 <20260910172904.397C41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910172904.397C41F000FF@smtp.kernel.org>

On Thu, Sep 10, 2026 at 05:29:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] st_ahci_probe_resets() blindly masks all errors from devm_reset_control_get(), breaking probe deferral and leading to kernel panics.

I do not intend to fix this pre-existing issue.

Would be happy to pick up a patch for it though.


Kind regards,
Niklas
