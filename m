Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD363C0A09;
	Wed, 24 Jun 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310864; cv=none; b=ka74g2y5l2aPczAI9Q2u6isJMjN2ePJys+pq7OtVw0beUbAx1hr7I8N7HCQ4gu6Pfw/i1Q/s+ZErmW1veY4OOLgrzGIFkvQWMYIcE100eUXJutiF9ggx2i03H2VCtOGAO8LXWGsad+rZhgLtZaIJO3h/zxi/I0MIpnCKzCpHmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310864; c=relaxed/simple;
	bh=kJ0Gr85Rp0gGigLTnzui4SqPV6dwYPE+PLHZOa4KqnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBYbMeQzf7mlmkGztO677tQ7o5SVWxh//DlGWDQEIGSOTUtr+eUEtr8yfpJ6JIaWhwREl1qxwfLfTFxJwLBHXL32ICX0/D+3Wb+gS70TciYpk6+W6Hq2AEdFBAN/uTJGpLtUTd4nAFD5+MipbEEQ6NAZuud7S19rTcff1Q0mNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiznc4fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiznc4fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9742F1F000E9;
	Wed, 24 Jun 2026 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310863;
	bh=XLTa3rEANKsidus9X31We55gRgAStYGDj2gokPb6hjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jiznc4fwnkn6FWmX52eD/4Aae6nM5ktNyKALn6zqbEJV4USFnNsbIi4CkSz79BHz6
	 M4kJZSKo4iqAY1/+qm3+YR2dNvHDTMmeRWF3uAqyEP2WysRpn57AuZ44uVaH8VYoD2
	 BvVtLUzg90yTLrZ4VRgQtHKM2JHNweN2Hxcb6TftAAJPqkq7i9KtKBvaBHXHuVOnTb
	 CF3h9b95wrIKxsFgr1j2+uAvnlOtRajA8LAzJedO8Z7sarrmkXU/mc0w3gEDmkCu1x
	 cqyYJ9NOJvm8vRQFxdCDGsXpIQ1N2KFcuiA9HRA0y1lBkc0f7gP4vkiiRmMTzWcujz
	 ITyUc5e+c/d1w==
Date: Wed, 24 Jun 2026 16:20:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: TJ Adams <tadamsjr@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Salomon Dushimirimana <salomondush@google.com>
Subject: Re: [PATCH] ata: libata-core: Allow capacity transition to zero for
 locked drives
Message-ID: <ajvny2mkowNmu81Z@ryzen>
References: <20260622182844.2795777-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622182844.2795777-1-tadamsjr@google.com>

On Mon, Jun 22, 2026 at 11:28:44AM -0700, TJ Adams wrote:
> Commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a
> security locked drive") introduced setting the device capacity (n_sectors)
> to zero in ata_dev_configure() if the drive is security locked.
> 
> However, during runtime revalidation, ata_dev_revalidate() compares the
> new capacity (now 0) with the old capacity (>0) and detects a mismatch.
> Since it does not consider the locked status, it returns -ENODEV.

When booting with a security locked drive (that is not the boot device):

ata_eh_revalidate_and_attach()
 -> ata_dev_read_id()
 -> ata_dev_configure() <- sets dev->n_sectors to 0
 sets ATA_EHI_SETMODE

ata_dev_set_mode()
 -> ata_dev_revalidate()

ata_dev_revalidate()
 sets local variable n_sectors to dev->n_sectors

 -> ata_dev_reread_id()
     -> ata_dev_read_id()
 -> ata_dev_configure() will one again set dev->n_sectors to 0

  /* verify n_sectors hasn't changed */
  if (dev->class != ATA_DEV_ATA || !n_sectors ||
      dev->n_sectors == n_sectors)
          return 0;


Please explain how you reproduce this.
As far as I can see the local n_sectors variable will be 0,
and the function call to ata_dev_configure() will set dev->n_sectors
to 0, so this should, AFAICT, never get a "n_sectors mismatch" print.


I even tried to reproduce with doing a suspend + resume (using QEMU),
such that ata_dev_revalidate() will be called again:

$ sudo dmesg | grep -E "locked|suspend|disable device|ata_dev_revalidate"
[    0.988248] ata2.00: Security locked, setting capacity to zero
[    0.993442] ata1.00: debug print: ata_dev_revalidate
[    0.994729] ata2.00: debug print: ata_dev_revalidate
[    0.995918] ata2.00: Security locked, setting capacity to zero
[   40.239682] PM: suspend entry (deep)
[   40.300128] PM: suspend devices took 0.020 seconds
[   45.738412] PM: suspend exit
[   45.985092] ata2.00: debug print: ata_dev_revalidate
[   45.986698] ata2.00: Security locked, setting capacity to zero
[   45.988530] ata1.00: debug print: ata_dev_revalidate
[   45.993331] ata1.00: debug print: ata_dev_revalidate
[   45.994525] ata2.00: debug print: ata_dev_revalidate
[   45.995194] ata2.00: Security locked, setting capacity to zero


Since you seem to state that the old capacity (local variable n_sectors)
is > 0, it seems like the device wasn't locked during the initial boot /
ata_dev_configure() call.


Are you perhaps unlocking the device in firmware, so it is unlocked at
boot, and then when you suspend, you lose power to the drive, so when
you resume, the drive is locked?


Kind regards,
Niklas
