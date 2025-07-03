Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC408244675
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539724; cv=none; b=Wu55zld8jsZAPBiblMAy81SERk9GPDThPEovw51TtpdvJ2rmCOefSfaC/vL7BYM+WcUsTvtSgAU5CNkWINM/n//+u0f74/ckOhyttMOwhy+pJORFHr7DB/jmoB3m0pc4hE7U0Zc7dKpjpWth2kob3GGEndX51aePaCu8xeTzocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539724; c=relaxed/simple;
	bh=mUsaPlh+5zxox0CiuWI2hECbkxq1a8VzVYJ4MbDAdFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPIFJsR/sOBV0900phj+XP8+G/xIlT3g4Ti788gx4eDUg7Kccks8xEyP9Ok0O4+cRDtiv8wLvQenNDcOuIC9sJYNpZuYD/VtlYoKMDBGntoGJp/GM7wMOs850YeV3wB93B4z25mlPSwt2FwngEF2pwMInXMob7GJiQupYWOyprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewRODFOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewRODFOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB858C4CEE3;
	Thu,  3 Jul 2025 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539722;
	bh=mUsaPlh+5zxox0CiuWI2hECbkxq1a8VzVYJ4MbDAdFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewRODFOr3b9BoTX+xxU0r3CTZe5bCIXURsmyiuoIO0HgKybVy1PBYQ+YL/RxPEm1w
	 C0kil+tOs4cvydmvWPKu1piAmLaNlmcsd7JjuERVmocm91+Y4Zc1tD80nULWF2m+iR
	 QzQWjyUh9L63Zvt9qRuCMKKGbL7hvxYfmegoYmW+4kKaHGIueQVS9pnILzsYtTWibK
	 B6YanBAGgg8s++TUvccIQfOKhfiuAxxKiNMQtllQz+J6J4dxcVIJ/yLrG5DZ69fvqA
	 eNNiuFBXqhn9rmElM53yobhBsnFP9a5cG9SjgNw+7Xv8Od/++XM7k3XAg22kjbBXGo
	 MR0sxS3OB3WUA==
Date: Thu, 3 Jul 2025 12:48:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ata: libata-core: Rename ata_do_set_mode()
Message-ID: <aGZgB6V5PK-1F5QU@ryzen>
References: <20250703103622.291272-1-dlemoal@kernel.org>
 <20250703103622.291272-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703103622.291272-5-dlemoal@kernel.org>

On Thu, Jul 03, 2025 at 07:36:22PM +0900, Damien Le Moal wrote:
> With the renaming of libata-eh ata_set_mode() function to
> ata_eh_set_mode(), libata-core function ata_do_set_mode() can now be
> renamed to the simpler ata_set_mode().
> 
> All the call sites of the former ata_do_set_mode() are updated to use
> the new function name.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
