Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D932A1BB
	for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102061; cv=none; b=KVIP6TixgwzXuMAQ7RbM20OkHjJU+ymwdMa+ymKOhelqi3kXVpihUhaetk4GWEchEMkBhKrn3RUrE6ZEHt+jKZGO7DASQ20rN853jWKSE2NyzgJcnj+HDEvkQHe+Bb0dzdi7JgSvZ0Mx/L4O21NCwIjpDs1h5immvZ1B39bnxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102061; c=relaxed/simple;
	bh=nrVUifgNDNEaOyA6Ivg+CEgYRMu2gOv/aoluKwGsfpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQG0iaw/0JdnlVIrYHrdHZz3eCRq8yg2SKH4r0w0XGjUZpDZ2GG7YkY5XWAaqyQ7oi3lBL4Tc7dNcB6p8bl0jhpzDegzRmHwowFpkcIfrZ2Zcg0xhkV88QtTXCsQCX9znLAhB93NsPy8VUO+4qNsdFgeJ20KS+qpigPCcOJPv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdkvQwxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdkvQwxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF1DC4CEFB;
	Tue, 30 Dec 2025 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767102059;
	bh=nrVUifgNDNEaOyA6Ivg+CEgYRMu2gOv/aoluKwGsfpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdkvQwxc7jZxN7p2qKjApwJS2iqsHFbDKNBbaE1u0km6xPYlrACVtUmNKvlgeycVv
	 TBtrBwGhlipDMYEqshGxqrfBcVlWgZqLgK48f9p1NJMgRdhABws02quxY7aRFvEEab
	 zWjU18UK4juDyq4Pa5RdtRVdaRETxIfvueXZKeeXUZVENWA9U9YKo9JK328kh04nyY
	 NVWkDcfYwNZYtNhI5QfjrsZCnzq7dL/xS5twqtjFcXFqWcPSHlyj/AkteusAqEjr6i
	 X0F0nSHhPGbRt/sp3GFjGCXFNF0tEuMIeNfP6X8ahuwClezVTklNbg4sdBGy+L++Yy
	 GVovpGbZM7Dow==
Date: Tue, 30 Dec 2025 14:40:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Message-ID: <aVPWZ7Sd_a3bMAs-@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220002140.148854-2-dlemoal@kernel.org>

On Sat, Dec 20, 2025 at 09:21:39AM +0900, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback into the new function
> ata_scsi_defer(), and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
