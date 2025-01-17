Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2133062
	for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132188; cv=none; b=BuDZpvSBcetekCc4Danj73W7j169E7RCj+ctONCZ2clLGiz6J1zHFfoUMZ66q7K9IV7gTrBg8kB3frn3rI9khYN5aEhYkaXmOym+vC8E72SlpG9ugJNwXnbaSGOsEldaT+kwhbpQ+4RkCqaR2/YphctrHaqGFRaa6IRWntNGum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132188; c=relaxed/simple;
	bh=wteSOjM4VXqoNxFI/zp2H3GaoNE+esD+QZVJer/wJzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noil3fdw5oJoW9lPlBuza5uqckVsYmTvDcfKmC2CJxxFV4igkpa6wAUNdemNVBOvAcMhc0o87ezLGf+4BbuMEFtE6VkqnwFp/G8B5216hkoQYwkx47V5cz4LKU7Th/e+W8ON6PBUgOib+tWAZxFp9wlAn4HCyq/yS0SLGTvcGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLBgfPCz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLBgfPCz"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1962a75bso21014016d6.3
        for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 08:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737132186; x=1737736986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wteSOjM4VXqoNxFI/zp2H3GaoNE+esD+QZVJer/wJzE=;
        b=MLBgfPCzGlx9xoHPJuNo3hdzrNK6lEMKPHdlhs2d2ppTOcjKQIeRV8GPNyZ+LbwvNF
         unEf9xYTFE18dNYIPiShT06YqDLawkdO0iXNEzO1742xmCxk6E+XLWOBK8xaUlT235m6
         6Td+gLOsz4wBeLAGlhcJv6nav5jdfy3RQhpCYFRBvxbBQfIIfVmbStx8KEousSTVnbRw
         WZC3sx8VdbxRUr9+hJbFD87UVlE/bkSg5005kTbRyZncTv1+zbFiDMT4qKip9COJB3aM
         530YD6bKxpXGqVbxc8x63rgnoTQczH5ahbbU2ugBtj5fkXl6OYeKWDwkshdWuvSgMY+K
         gHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132186; x=1737736986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wteSOjM4VXqoNxFI/zp2H3GaoNE+esD+QZVJer/wJzE=;
        b=rs009PK2sfIeozfr7Eg1wqirE/eGpfZFRsqdrBgFdSFEYB+NG7CKu4s5piPDGJG8aP
         NZlCaY6oTL/GRE+V4KnTs81axsIr6JQlgg3o8sNFh7ZzLIKzZTDZOcgr21KkjcXVtPUG
         C/ewlOiTc6EtrRSWcgNzAWe2W918NYCqCy1RyD7P/MNDS7z4qynPoy9Bvax8PqyteJnu
         CdIri8HM/reQ6oNvxNqtB5cIG2LveczvHVeGZPYpbdppwgbe/9ssLlrntjYdvoPxYvwE
         lVSiOrhLZ70qSLWAIwHap47nALvpKhYF0778Y4dd9tbcu1gGpaorlw8eyMxGIYD3uE2o
         t/3A==
X-Forwarded-Encrypted: i=1; AJvYcCUfTNCC8UE/+x21lc8Juti2U/wxQ4GAdVCDmNY8WSJ/jObyAwuLr+rP6/E8DP2eSnR6zHMU53s+KiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7giHxxDFSr+jai0L20JP4CJ//WVFnh9drf/lpS/5pRmUMIHzC
	EF4obt+14K2GBKMDvu6/76kY2Y0p/oRBrz5XiJSolCasCKUznzCMl9OmzfNVeGT2zDYBM2qWWLF
	B8TkS/e3Etmc5RpGvswpW6uD35B29ArEk
X-Gm-Gg: ASbGncv0ffeWe04SM/SM3MjGOZR9MvT9jzw2jWHzzKHWNHjfwaXhhiWftzTefCyZz/t
	K8kHikzupQgAFpeaa+HM+jm4NJiUP0bf5kNOgiCi4
X-Google-Smtp-Source: AGHT+IFgx64Buda/3VllyFtQwtLfg/b3SPYmdHHrjEBrRXN4trOK9ZdO3fGYk/1gLE5bjNklhkv9yXyabsPyQrY4/5I=
X-Received: by 2002:a05:6214:765:b0:6e1:afcf:8710 with SMTP id
 6a1803df08f44-6e1b2167b8emr65182406d6.8.1737132185985; Fri, 17 Jan 2025
 08:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z3ZtFDgs61oDMMB9@ryzen> <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>
 <Z4popNqD1GZriXh3@ryzen>
In-Reply-To: <Z4popNqD1GZriXh3@ryzen>
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Fri, 17 Jan 2025 11:42:45 -0500
X-Gm-Features: AbW1kvZxVI74y49LRzskKerqBGrod4bu5sb2CRaUMzOE5EekpvFzcBKsSvY45y4
Message-ID: <CA+-ZZ_gtsDShKeZSupbrwCLtpCvW=p1=citKVXRrSDi3LoZ_9Q@mail.gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
To: Niklas Cassel <cassel@kernel.org>
Cc: damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 9:26=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello reveliofuzzing,
>
> On Thu, Jan 02, 2025 at 11:23:49AM -0500, reveliofuzzing wrote:
> > On Thu, Jan 2, 2025 at 5:40=E2=80=AFAM Niklas Cassel <cassel@kernel.org=
> wrote:
> > > On Wed, Jan 01, 2025 at 09:17:02PM -0500, reveliofuzzing wrote:
> > > > Hi there,
> > > >
> > > > We found an out-of-bounds write in the function ata_pio_sector, whi=
ch can cause
> > > > the kernel to crash. We would like to report it for your reference.
> > > >
> > > > ## Problem in ata_pio_sector
> > > > ata_pio_sector uses the following code to decide which page to use =
for the I/O:
> > > > page =3D sg_page(qc->cursg);
> > > > offset =3D qc->cursg->offset + qc->cursg_ofs;
> > > >
> > > > /* get the current page and offset */
> > > > page =3D nth_page(page, (offset >> PAGE_SHIFT));
> > > > offset %=3D PAGE_SIZE;
> > > > but we found that `offset` could be as high as 0x5000---qc->cursg_o=
fs=3D=3D0x5000,
> > > > qc->cursg->offset =3D=3D 0x0, making `page` point to a higher-posit=
ion page that
> > > > belongs to other threads.
> > > >
> > > > ## Example crash
> > > > This out-of-bound write can cause the kernel to crash at arbitrary =
places,
> > > > depending on when the corrupted page is accessed by the other threa=
d.
> > > >
> > > > We found this problem can happen in Linux kernel 6.1~6.12. Here is =
one crash in
> > > > Linux kernel 6.1:
> > >
> > > Thank you for reporting!
> > >
> > > I assume that you haven't tested kernels earlier than 6.1?
> > Unfortunately, we haven't tested older kernels.
> >
> > >
> > > (Looking at the driver, there was no major change between 6.0 and 6.1=
,
> > > so this bug has probably been there for a long time.)
> > >
> > >
> > > Could you please share your reproducer and your kernel config as well=
?
> >
> > Below we report our setup for linux kernel 6.12:
> >
> > - General steps to reproduce the bug
> > 1. Launch the VM
> > 2. Copy the reproducer (compiled binary) into the VM
> > 3. Run it with the root user
> > 4. Wait for the bug to happen (generally takes less than 3 minutes)
>
> I managed to reproduce the bug using your bzImage and syz-executor binary=
.
>
> However, the .config you provided does not match the bzImage.
> E.g. the e1000/e1000e driver is not built-in in your .config,
> so I get no networking, while it is enabled in your bzImage.
> This makes me worried that you have other changes in your .config.
> If you still have the exact config for this bzImage, could you please add
> it as an attachment?
Hi, we double-checked it but found the config shared above is the one we us=
ed.
CONFIG_E1000XXX is enabled in this config.

>
> I've been using the syz-executor binary that you attached, since the C co=
de
> pasted below does not compile, it seems like it has some unintended newli=
nes.
> Perhaps you could add it as an attachment instead?
Here is the C program:
https://drive.google.com/file/d/1Uvhqrn-ntEYQT2PBiQjp0xaor-32WYHO/view?usp=
=3Dsharing
Please let us know if you still can't compile it. We can take a look
at how Syzkaller
generates this C program and compiles it into the syz-executor binary.

>
> Also, you only talk about 6.12 kernel. Out of curiosity, have you managed=
 to
> reproduce this bug on v6.13-rc kernels? Have you tried?
We haven't tried it yet, but we can do that in the next few days. Will keep=
 you
posted.

>
>
> Kind regards,
> Niklas
