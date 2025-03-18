Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216442AB4;
	Tue, 18 Mar 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288503; cv=none; b=JHbP3qfcRuKF8E7vI/X55C5OcpQuMvVL4LiAcXM1GJMFW0kBGfKwUXEBy6aThmnGUQH+prIY3JXLOoT7K+L13lT4ScFZltguIb/I08AxN5LEFz1ZjkRHEriOOUBVqnjmt1Wn3YBHryuKkw0/IHvlyOOxbh/EbTR0WKOphbzQedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288503; c=relaxed/simple;
	bh=C2+M5veEyZV9MTOuODLI0U5TuuyRSNZ9tvlDBTASTzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAHgU7s45/cKP/4MqpD5tugbCscVce7Lfz9MHT395d/KVcIZvw0EsTIZeH2ye3QGFGNAXL8klr6L+5RkUiDguvc4yLf4jbMFudUHAa7cpk2zxDPyi/HENQF4x2QVGePd7yz2G5w14rQIE/WyVdTvtYxNUjVKXWwDxSzxRAk1O6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6Xn37c9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6Xn37c9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A175C4CEEF;
	Tue, 18 Mar 2025 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742288502;
	bh=C2+M5veEyZV9MTOuODLI0U5TuuyRSNZ9tvlDBTASTzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O6Xn37c9YChD6fjdOKjDnR4BhlBzMI7v2qAQAt1BsSip+oS4gZq3OqvGyTCkSLeRZ
	 OHKszQvtuRPRKzhKMM8Tzbk4KP2IOsdWp9PJZkD7Xy1UL6wUrK5W4ws817igwVlOcF
	 5pPcFrXcQvGTS1yXO/A+yFFS2q7gVcWznZywKDyaANofz4vGj/fYEVQElpw0qykktF
	 FLKtsE1krKwj8muSHOfOTqTXLCgW1LuIO5SUte3HLJfCNJSXKIqdqUP7Fa3XQ+Px5o
	 4jWTHhIAcu1SDjqdj+66p66Fn38pfxMeAsCfQZyqmNHgPQOc5/k1yvFK9QBbk5xhPV
	 ng9xS8SuO10Kg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaecf50578eso987877466b.2;
        Tue, 18 Mar 2025 02:01:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY6eR0+3LxR2xc8lQ1gszxaofgYqH+9owQZ6356vmbXi0u9A5LtXU68mn5jn7NHAkMShiXsfPF2r8S0Ed4@vger.kernel.org, AJvYcCXYmsdxv5jd/hAJPqGUW7C+F2ZSde2U7/XV7C5PngwWifqjvIj0wyj77GFxNJzjKxlQPx08ybdkKKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmy7ohU8pJcEuEa7YdfkLrZbCUJCxzwmuijS0L2uCcH3Y1/wV
	P9odPer82U9yFHrMtAONe4QFqdiZYGtSHEJpyEaUJKgIf2nh/qjWPYnzKqqBc9VZ3HVjSZrJXbU
	FmbV2NsLG4YBJ3Eyfw20TFDZdtjM=
X-Google-Smtp-Source: AGHT+IEuUXf2+sUNkOFpmiuq4nz0aWaZFm5xNxgnL8CvPNPRsULoqEPFybTgXtrR1PNhBtoi5yFjiAHOlH9+RnPTtnU=
X-Received: by 2002:a17:907:d9f:b0:abf:749f:f719 with SMTP id
 a640c23a62f3a-ac38d3894afmr254215066b.7.1742288501023; Tue, 18 Mar 2025
 02:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312134654.6699-1-chenhuacai@loongson.cn> <Z9Gsq9Yz7nDQ_fOx@ryzen>
 <Z9koefNibN99tslN@ryzen>
In-Reply-To: <Z9koefNibN99tslN@ryzen>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Mar 2025 17:01:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4f_ypLDceRe4KwscJGCKE6OLuRrtnwhCC5MJSAFQSS8A@mail.gmail.com>
X-Gm-Features: AQ5f1JqhPtZZ6NlO_jpLuvn1sKPW-MavzmrfvRXQrzAbvpYLFLfmANJyJWZhI3k
Message-ID: <CAAhV-H4f_ypLDceRe4KwscJGCKE6OLuRrtnwhCC5MJSAFQSS8A@mail.gmail.com>
Subject: Re: [PATCH V3] ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI
To: Niklas Cassel <cassel@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Damien Le Moal <dlemoal@kernel.org>, 
	linux-ide@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Daniel Kral <d.kral@proxmox.com>, linux-kernel@vger.kernel.org, 
	Yuli Wang <wangyuli@uniontech.com>, Jie Fan <fanjie@uniontech.com>, 
	Erpeng Xu <xuerpeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:02=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello Huacai,
>
> On Wed, Mar 12, 2025 at 04:47:55PM +0100, Niklas Cassel wrote:
> > On Wed, Mar 12, 2025 at 09:46:54PM +0800, Huacai Chen wrote:
> > > We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
> > > Loongson-based machines. We found its PIO doesn't work well, and on t=
he
> > > opposite its DMA seems work very well. We don't know the detail of th=
e
> > > 88SE9215 SATA controller, but we have tested different CD/DVD drives
> > > and they all have problems under 88SE9215 (but they all work well und=
er
> > > an Intel SATA controller). So we can define a new dedicated AHCI boar=
d
> > > id named board_ahci_yes_fbs_atapi_dma for 88SE9215, and for this id w=
e
> > > set the AHCI_HFLAG_ATAPI_DMA_QUIRK and ATA_QUIRK_ATAPI_MOD16_DMA flag=
s
> > > on the SATA controller to prefer ATAPI DMA.
> >
> > This is a wall of text.
> >
> > Could you please use paragraphs? (with an empty line between paragraphs=
).
> >
> > (There can be multiple sentences in one paragraph.)
> >
> > This is a good example:
> >
> > commit 6bdbb73dc8d99fbb77f5db79dbb6f108708090b4
> > Author: Bibo Mao <maobibo@loongson.cn>
> > Date:   Sat Mar 8 13:52:04 2025 +0800
> >
> >     LoongArch: KVM: Fix GPA size issue about VM
> >
> >     Physical address space is 48 bit on Loongson-3A5000 physical machin=
e,
> >     however it is 47 bit for VM on Loongson-3A5000 system. Size of phys=
ical
> >     address space of VM is the same with the size of virtual user space=
 (a
> >     half) of physical machine.
> >
> >     Variable cpu_vabits represents user address space, kernel address s=
pace
> >     is not included (user space and kernel space are both a half of tot=
al).
> >     Here cpu_vabits, rather than cpu_vabits - 1, is to represent the si=
ze of
> >     guest physical address space.
> >
> >     Also there is strict checking about page fault GPA address, inject =
error
> >     if it is larger than maximum GPA address of VM.
> >
> >     Cc: stable@vger.kernel.org
> >     Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >     Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> >
> >
> > Otherwise, this looks good to me.
>
>
> If you want this patch to be queued up for 6.15, please send a new versio=
n
> this week, because after this week, it will instead be queued up for 6.16=
.
OK, I will send V4 today, sorry for the delay.

Huacai
>
>
> Kind regards,
> Niklas
