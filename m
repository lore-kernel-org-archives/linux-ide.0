Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA938F929
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741336; cv=none; b=DhdxjczJnbRFe2bld0pAmfiMMeWSd+tegnD8ZS9RkPIerVJQUYITgIngYPptfPRfmxtEGBNEMLegdiX6P7jLGubwPuwB9cPAar3RvsJ1c/CIq8/ELjbhTHdSsHLIz7tu/UdiruAzskQRkgvgP4kcUCFbECBrK2DXUCik6eHs7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741336; c=relaxed/simple;
	bh=r9+tSoim0AmSAbwtz89rVdIHthTxWxaHZ5tFw7ygpLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQbsTlisSJAa1tKgbG5cKOeFpDytQFYpyMcaAybHn6Ir60y+Olhl0Xz9Z+4zxMMMN8COgEeaeky0HC5HGevD9UAWNJsowWZ+Wiw5JSnXlipR5IdCbyUzemd0UiZ3MUP/LIoqvGVBRDUWSyIICidGhbgwympDl0Vo+DR+c/nkz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=X1Mun/Fa; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="X1Mun/Fa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778741333; bh=r9+tSoim0AmSAbwtz89rVdIHthTxWxaHZ5tFw7ygpLo=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=X1Mun/Fa3PSlenKz0EJcA0XvMF6blUgrpHbEotWdwoD7KPkwqdWOjvSrBIrIjggaD
	 83ACwKmBPsmOcO7noMZJzhKaboZhbZTilxmSfHNH5dH2NloRv5Alz85vznYpTVvyoo
	 FpqqNY42VWHYI1at7Uy8nvvqWjtGwXnvn5l9pPsNqBJi39HXuvl6wM5UpRrh70HjUX
	 qLGzVnfdN+b8aBIHDbWcsRizV5UJKrtykjDv+L0G95Kk+ccAZe/CfLUsJSOgcmE+9d
	 bCGcMow9V+Ct5g3ty3VVhlCvzhoG+of52i/Gx9c26sNbJ6IbuqaoFqeC7zohvOb2u6
	 UxZRri1Jjyv7w==
Message-ID: <8947edc4-85f7-45fe-b8db-3266ea2fcdba@tkel.ly>
Date: Wed, 13 May 2026 23:48:51 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513151359.1075403-6-cassel@kernel.org>
 <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
 <4b37d9a7-0083-4bb6-ba38-cc243afe0305@tkel.ly> <agVuwX1I1CX5EBMP@fedora>
Content-Language: en-US
From: Tommy Kelly <linux@tkel.ly>
In-Reply-To: <agVuwX1I1CX5EBMP@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 23:42, Niklas Cassel wrote:
> Hello Tommy,
> 
> On Wed, May 13, 2026 at 09:42:35PM -0700, Tommy Kelly wrote:
>>
>>> U-Boot 2026.07-rc2-dirty
>>> kernel: Linux version 7.1.0-0.rc3.1d5dcaa3bd65.25.test.fc44.aarch64
>>> [ 1539.481926] BTRFS error (device nvme0n1p4 state EA): run_delalloc_nocow failed, root=5 inode=103820306 start=274432 len=4096 cur_offset=274432 oe_cleanup=274432 oe_cleanup_len=0 untouched_start=274432 untouched_len=4096: -5
>>> [ 1539.483785] BTRFS error (device nvme0n1p4 state EA): failed to run delalloc range, root=5 ino=103820306 folio=274432 submit_bitmap=0 start=274432 len=4096: -5
>>> [ 1596.136409] systemd-journald[800]: Failed to rotate /var/log/journal/c5b05402ed674946a0b721d8b2c649d1/system.journal: Read-only file system (Dropped 122276 similar message(s))
>>
>> Those 2 `BTRFS error` lines repeated over and over every couple seconds.
>>
>> This one seems to happen randomly, unable to reproduce consistently.
>> No idea why its happening.
>> But it has happened with both patched and un-patched u-boot devicetree.
> 
> Thanks a lot for testing!
> 
> The problem with PMP CBS is my fault, I made a mistake when creating V4.
> 
> The btrfs bug seems to be unrelated, even though it seems very bad.
> 
> It is good that you have UART so you could see what was going on.
> 
> Perhaps you could test on v7.0 (hopefully btrfs is more stable here) +
> v5 of this patch series (once I've sent it out).
> 
> I'm sorry for my mistake... hopefully it will not go beyond v5.
> 
> 
> Kind regards,
> Niklas

Hi Niklas,

I'll test v5 with CBS + FBS, no problem.

I just discovered SysRq + R (Replay the kernel log messages).
I will try that over serial next time it happens.

Thanks,
Tommy
