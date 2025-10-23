Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D49313E0F;
	Thu, 23 Oct 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222504; cv=none; b=AEkEniMjsgX981UYQnLPw3I+kcAx7YZo9vPZdjZVSigtasuhTpIas15KAPEJyxXfxe7WYE/11rY0Y5m8ok22QfeIaBFngiO5xcGNrF2QK/DOOZqbc2qCMNC8TZJWv7C6ASY2/NEVpAyy1Vv4JnvumJU0RM3a0ODdDGSCm2tDfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222504; c=relaxed/simple;
	bh=hKNzt+xgYZgDDCqY4vmhqUPnjY/TN1aVxfjLzHN8pF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/N6uzSIOX4U0oyXLAMrdmdzHpHLfrAXVkfc72chBNXaMZ4EZYKM738wCPZFEhIB+uKDWixFr9Ez/9/wAZNjr2B7K1xoU+B1F5ouxN5FbJZdvbZh+o0CmLNQOOM2X7vmtwXBP5QqkR3Yjtv2D58v5pP2jdg/mf7f6g0NuB7C3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re6Kz3sS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re6Kz3sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58FC4CEFB;
	Thu, 23 Oct 2025 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761222503;
	bh=hKNzt+xgYZgDDCqY4vmhqUPnjY/TN1aVxfjLzHN8pF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=re6Kz3sSAUojREwJ5/qxeFAi1v4OQuB0xHEDuErOtYq2poFVRBSuIopjkgFe2EhoC
	 s7ZM60Yoz81QRkyTq/WoadlTnTiWZlFm4TKmbJaKRLxF3r9hZXZ36w5FRvwUArzZgc
	 lNYNTg+ufSGG/z3erHdsNbdB4u1YyG3bQXRQVlL2ySKJHhx1D4CtwVQUaUVmnIftyu
	 7bv5Y4HC2tf4y6EhXhwVN1WidwRvYvWG/MFIRf7QnluGt23CC3bk6kO+XItT0za0/W
	 RCSGd7f6CRtQADJ7s0pciV/I1zHMEfMak29wYlZ8G3KHuE6v8TfHitUZOxH4J1f5EM
	 ZZzdoenuFwTXw==
Date: Thu, 23 Oct 2025 14:28:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-hardening@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: Replace deprecated strcpy with strscpy in
 it821x_display_disk
Message-ID: <aPofY8mWyRATm6T5@ryzen>
References: <20251018105146.29808-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018105146.29808-1-thorsten.blum@linux.dev>

On Sat, Oct 18, 2025 at 12:51:45PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Replace the hard-coded buffer size 8 with sizeof(mbuf) when using
> snprintf() while we're at it.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied, thank you!

https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.19&id=4ea303d9e9862ff8bd3707f67b267646b8ffd3ec
