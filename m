Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA26E56A;
	Mon, 17 Feb 2025 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799016; cv=none; b=rZldUIdUuERWK9lizEvPMGKM6HIC8OHdPDzA7R4xhD37ecGQlJ24THQEbN2uIXmwo9CTjcYn8HLO58ENCzm428Sbp4IV6tAXPZfrO5kAPMIP/b1pbtwjs9r9B5IMkouXsAUbF6ZTaFf4HNg5kx0X3yUnPtFufboe0o4R/B/qRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799016; c=relaxed/simple;
	bh=XXa7AUUG+cGtasNDMbljkjjyV26PgkSjBCpEcoVphE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJZoytEgzqO/4boLX89WPl20kOG9lwfvqx0kwnkM1kyL45gH9V51/jY87PUfNShbefoCxe/BnZadTcu+33XoU34NRgonHra0+TFoGRIv86Amlr/17OzG/3RF2v+iaQMZmuPGfOP3jdFl11R7+69kzzQ/Vd6nsCqUAZjVPGNI2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3O/hCav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3O/hCav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D44C4AF0B;
	Mon, 17 Feb 2025 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799015;
	bh=XXa7AUUG+cGtasNDMbljkjjyV26PgkSjBCpEcoVphE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P3O/hCav6DFZYfmmK1JShf6kGShnVOLPqBmeSQcj2+lIyZHr/WtpOi58PAx99baTF
	 MtFoLiFExOvQwiSuQ+L4ALk+QF1cyDPSQWUnrk9vIDQgZeTEjqjxozbpX2xuEAicvY
	 u3RDWoSf6N4Nr/zy/P/Ig5HDJ6A2NWYrq+3ERzE6OTeTu0pf6oK0mjjMrwFEXtcDnG
	 4v/COUPes3JFNpSut1SsJfDnMtESW1DFGt4vZX7HfeOzpxR4ZShQge+M7SveWJBF39
	 tytixFfQ664FR5mVjgHQuN4i6EyahV2TpZgqXhjVvN+gM2JK7awCVifj7Y2mw+P4mb
	 KFrrzkNnOLQRw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb90c20baeso174060566b.1;
        Mon, 17 Feb 2025 05:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7GchMbFNS66BlwIMDcCTzn71FGLcGhNlvAKsnalsJSH/BurdqonEzvGHhanNAr7Wm0yCMT9cW59c=@vger.kernel.org, AJvYcCVFLYpNlI0O2CekhHB/HuXsEQqYtU9Hfdma+mG+9hnCk/hZHbFUCex1FDFbO1x9ueH1Apzztxd7AgJ2mU7Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vcQDWGoxfeINVEpaevTS4jLrAm9LHjauV5DClYLRFG8mEW8/
	k9gs//5d+5gG4YfJVRyJD5AGSVFlZDPs6p5Rs/5SF6wUcsy9O4WVbrAbJC0x5zaGezRMPzwpaK7
	mPTGLypVipkQcK0OgvxeKuksu+80=
X-Google-Smtp-Source: AGHT+IExGxNayX+m0YzrWvqhyVbO7x3K/DWzjOIq1ZwgmykqnbHYztqt4Tfh7roiNWV1TcIihG279p1i2GCFbYSezI0=
X-Received: by 2002:a17:907:7752:b0:aa6:79fa:b47d with SMTP id
 a640c23a62f3a-abb7091cedcmr805613866b.1.1739799014337; Mon, 17 Feb 2025
 05:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zt6l6DVeDGzb5W7N@ryzen.lan> <36B40EDC960C005C+20250217070120.666907-1-wangyuli@uniontech.com>
 <Z7MdiTptmxgiRXML@ryzen>
In-Reply-To: <Z7MdiTptmxgiRXML@ryzen>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Feb 2025 21:30:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5PKf4VAt8SrAf+cwxbgMz4Zuv4XeyK269KHkCKu7F4Bw@mail.gmail.com>
X-Gm-Features: AWEUYZkA9QwD70vDYGw0krv0S-QePZsOvQR7rENzif5Xtsk0AbuyVLWDiaonp1E
Message-ID: <CAAhV-H5PKf4VAt8SrAf+cwxbgMz4Zuv4XeyK269KHkCKu7F4Bw@mail.gmail.com>
Subject: Re: Re: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
To: Niklas Cassel <cassel@kernel.org>
Cc: WangYuli <wangyuli@uniontech.com>, chenhuacai@loongson.cn, dlemoal@kernel.org, 
	jiaxun.yang@flygoat.com, kernel@xen0n.name, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Fan <fanjie@uniontech.com>, 
	Erpeng Xu <xuerpeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Niklas,

On Mon, Feb 17, 2025 at 7:29=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello WangYuli,
>
> On Mon, Feb 17, 2025 at 03:01:20PM +0800, WangYuli wrote:
>
> [...]
>
> > Tested-by: Jie Fan <fanjie@uniontech.com>
> > Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
> > Tested-by: WangYuli <wangyuli@uniontech.com>
>
> It is a bit weird to see Tested-by tags here, since your email does not
> contain an actual patch.
I think Yuli means I can add these names to the V2 patch, because I
only tested Loongson, others are tested by them.

>
>
> >
> > Currently, due to the limited hardware I have access to, I'm unsure if =
this is a Marvell
> > 88SE9215's specific issue or a general Marvell SATA controller problem.
> >
> > So, I think it's reasonable to add a quirk to handle this for the Marve=
ll 88SE9215 now.
>
> I agree.
>
> Feel free to submit a patch that adds a quirks for Marvell 88SE9215.
OK, I will send V2 as soon as possible, sorry for the long delay.

Huacai

>
>
> Kind regards,
> Niklas
