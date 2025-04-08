Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE318DB0C;
	Tue,  8 Apr 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099214; cv=none; b=Zz+PdRfJx3UdCXYllb5wvlg0Tv+srMCwWzi/fgpov/0Iu/E1c/BkCTmh006p+rgSiDbKZlZCLVqXfKYNH0MBCNu//p4IGj4QMXCW56RDUep8CsF7d8e9//oOay2jmAWwfMkPAb4xSPz4znBY3xjRsFZS8pyo/9qP7eNkHZNc3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099214; c=relaxed/simple;
	bh=KK+yAxCAYHbE4CX7MKmmtV0S6r4GlgEqDtA/Vmnqw14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3dkdIYa9kc4uKGz2X6XRiLGWVyg1HkTou1/Gz/Na32RbwgYvJ7LW3A3gPaXt8ZvLPMKqqqhGb+b+udyLOJgIY2SBSECAXm82HffPhjtEihjd3uLpOeZGoSrdbYmfEhqfe9uqi+xy19/luw+rsVewc1q1dhqXe44V0WJoQyX6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxWS+KQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxWS+KQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1131C4CEE5;
	Tue,  8 Apr 2025 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744099214;
	bh=KK+yAxCAYHbE4CX7MKmmtV0S6r4GlgEqDtA/Vmnqw14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxWS+KQqMFp55rsdlhsI+SYIlsHQIcp/+2heYcpWtt5EXZtWfm4p6M8puNwr4YerR
	 6Kit66apd/SIcvB5hpyyZ37CtCYLIJdHTzI+8jw3zJ1Wt72fljYEaP8fR+ogvASfvp
	 Vo+/0Drfotut20VRcOy5OBwQa/EUorJo/SiTT//EOt1Jrj96XW+wqzkw2whIHI8UtT
	 fe5NpiHuq3MiUcR3tfK8NZL22Nce4XbbaDDkPjTaejxOfro3L1NUdXyqZcu+QvIJja
	 0WCkX8eI/HoJJpGcI1aMtAjBjTGi5cquXDnYyfmpXU9SkyvxCIcaXSGTZBGZXYmi1g
	 e92+g0Zw+bg+g==
Date: Tue, 8 Apr 2025 10:00:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: sata_sx4: Add error handling in
 pdc20621_i2c_read()
Message-ID: <Z/TXilfhUPuVfXLA@x1-carbon>
References: <20250408073001.3121-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408073001.3121-1-vulab@iscas.ac.cn>

On Tue, Apr 08, 2025 at 03:30:01PM +0800, Wentao Liang wrote:
> The function pdc20621_prog_dimm0() calls the function pdc20621_i2c_read()
> but does not handle the error if the read fails. This could lead to
> process with invalid data. A proper implementation can be found in
> /source/drivers/ata/sata_sx4.c, pdc20621_prog_dimm_global(). As mentioned
> in its commit: bb44e154e25125bef31fa956785e90fccd24610b, the variable spd0
> might be used uninitialized when pdc20621_i2c_read() fails.
> 
> Add error handling to pdc20621_i2c_read(). If a read operation fails,
> an error message is logged via dev_err(), and return a negative error
> code.
> 
> Add error handling to pdc20621_prog_dimm0() in pdc20621_dimm_init(), and
> return a negative error code if pdc20621_prog_dimm0() fails.
> 
> Fixes: 4447d3515616 ("libata: convert the remaining SATA drivers to new init model")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
