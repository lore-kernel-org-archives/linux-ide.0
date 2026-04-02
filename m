Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472A355F5C
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156638; cv=none; b=Zt0/HHz0pXUDBWirTSZy7J0vvTPQvwbYcv2uzrGWnld8hVhlvK1ixwaC/RpZEWI3wOiluxjNRvTd7962O1s+cOrvu5xQuQV4fdnHRoVTeFyr+xMG2wIyaalPnUhKKon0n+YpD/fYUNG880qoc/xT/Wk7Rj3ZDdNzzPl9fQl63QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156638; c=relaxed/simple;
	bh=gOkHtXqIfcoHvm9VQKhdPCneEVBp5AZmGbzO21skjbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kQXOy7VS6Tjr+jdr7jaJeJ5mqY+di8b01OaHL9gGjAvyOlFqimh466p1DKXeF79nMjQQDPXO40O28hZhsUfsjexxbl5TPNgyoAyKFDjDcG+MluBUMjJbs+96mdgrrhSURR8fJglr3ltj79qmFj7fK37RftTWRuUDZVh5DuGe1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgIvdTiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgIvdTiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05A1C116C6;
	Thu,  2 Apr 2026 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775156638;
	bh=gOkHtXqIfcoHvm9VQKhdPCneEVBp5AZmGbzO21skjbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rgIvdTivhC95ySAwC6YkqY5hDE2l/rUUV8iDcSpYetZLMFCRashL+KrsCeE6yACEg
	 VihOJ1qmm/cJOOUyfrUsK1qfjTr4/t8oUQo6Su8q+n3J8q+rkNJyj6QcTuPpIj42E6
	 R22Jh8iuURPC0LpKBL0ALsL8GCdmY6vZyUh9iaf/3fvnKQzMGTOLJcJxTmq7NGi435
	 q7AkJLuPEcddDpYsss/DK8X/3WqWHRyq2CRpNTxa4tGZUttJheCfSin4D8YyIkSCS2
	 0OpARH+fudMnBbLDJJblPgGd2ozjhdfTIhFBTNFJnPPq6EhN4uPJK7sT2jQ5eo2llM
	 8XA2nrXo/Z7JA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
References: <93fc6c62-ed8c-4953-ad7b-522031bb7ed9@gmail.com>
Subject: Re: [PATCH v2 0/5] ata: libata-transport: series with further
 refactorings
Message-Id: <177515663736.2808255.10836515587597827279.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 21:03:57 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 02 Apr 2026 15:28:29 +0200, Heiner Kallweit wrote:
> This series aims at further improving and simplifying the code.
> 
> v2:
> - improve commit messages for patches 1 and 2
> 
> Heiner Kallweit (5):
>   ata: libata-transport: instantiate struct ata_internal statically
>   ata: libata-transport: inline ata_attach|release_transport
>   ata: libata-transport: use static struct ata_transport_internal to
>     simplify match functions
>   ata: libata-transport: split struct ata_internal
>   ata: libata-transport: remove static variable
>     ata_scsi_transport_template
> 
> [...]

Applied to libata/linux.git (for-7.1), thanks!

[1/5] ata: libata-transport: instantiate struct ata_internal statically
      https://git.kernel.org/libata/linux/c/ee1ed7a8
[2/5] ata: libata-transport: inline ata_attach|release_transport
      https://git.kernel.org/libata/linux/c/f2122465
[3/5] ata: libata-transport: use static struct ata_transport_internal to simplify match functions
      https://git.kernel.org/libata/linux/c/365da8c6
[4/5] ata: libata-transport: split struct ata_internal
      https://git.kernel.org/libata/linux/c/359942ba
[5/5] ata: libata-transport: remove static variable ata_scsi_transport_template
      https://git.kernel.org/libata/linux/c/7bf6ddc3

Kind regards,
Niklas

