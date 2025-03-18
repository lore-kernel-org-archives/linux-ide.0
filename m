Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00D207641
	for <linux-ide@vger.kernel.org>; Tue, 18 Mar 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289279; cv=none; b=pnDpLYcTAZ+vC0Ej7bq8BGfLb2mW5yVWPOq8wEq4XeA3gp5ZJFbbpH1tEhvJHDGnk+Q8sLa7P5FqzGzMKGLMa9FA7F6Ph99BdAaB1K1Wx0vSJen1FGvxPrlRYK9785z/Pw/0wmTrnAyXwtHEQbOiMGkpappSvZBrkTpT61Xzsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289279; c=relaxed/simple;
	bh=J3GfXt0j2iexuCwTZb4J1S8dJ7HoyBPpsylx46jVAJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oBiN+obIQcvcw1o/NJRZ/WA4tdjPsEZu8hVxXriuAhjmpkTQFJrCExd+6/6hovNKI3zI4E8ewwpxYYvUB8qcwq4iDbMbQbFUgQ6RuhlIGKsnFvd0GBmBqgtxwRjaz7zIB9v1Yfu3COMNCLJg0Rn2xO9i4KTFpOxRE9Wb47vPrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXXyGS3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXXyGS3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E36C4CEEE;
	Tue, 18 Mar 2025 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742289278;
	bh=J3GfXt0j2iexuCwTZb4J1S8dJ7HoyBPpsylx46jVAJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IXXyGS3Qf/mB8RfUK8ot+WCOYDuh5Re50h2+1/Wyp6sWE4uiqiYkJMABo2NpKr4eL
	 lg5bKlWeVPUCsdZyqM1QTT/chn2zt6i9Pe7fGvIVtwC3IpGHxvJ1LP8To7yjjH+Wbo
	 E3326ZLLFs2xzq3WKaltWEkQ/D+TUIGF5ziWjIQguQWY1w3HZEj80MqLCjGRmRlXGh
	 qfdn0IDUmoT+O0MZW5E1qiWneurnwW9YyJwTVkuwD3e8ai2wc13n6gAp/8mIgz+9ri
	 Bj6lfWBiWz2oH67GQx8tR6Q1w+1KZ0gkfjjib+NISqVgJ0t/zaHy0Yb3Y16eGdsccT
	 DNzc9VVHIyG4w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Jian-Hong Pan <jhp@endlessos.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Eric <eric.4.debian@grabatoulnz.fr>, linux-ide@vger.kernel.org
In-Reply-To: <20250317170348.1748671-2-cassel@kernel.org>
References: <20250317170348.1748671-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for
 certain Samsung SSDs
Message-Id: <174228927606.1766726.17326013286026138020.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 10:14:36 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 17 Mar 2025 18:03:49 +0100, Niklas Cassel wrote:
> Before commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> the ATI AHCI controllers specified board type 'board_ahci' rather than
> board type 'board_ahci'. This means that LPM was historically not enabled
> for the ATI AHCI controllers.
> 
> By looking at commit 7a8526a5cd51 ("libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI
> for Samsung 860 and 870 SSD."), it is clear that, for some unknown reason,
> that Samsung SSDs do not play nice with ATI AHCI controllers. (When using
> other AHCI controllers, NCQ can be enabled on these Samsung SSDs without
> issues.)
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSDs
      https://git.kernel.org/libata/linux/c/f2aac4c7

Kind regards,
Niklas

