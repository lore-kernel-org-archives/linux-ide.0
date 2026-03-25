Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05B39658E
	for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481370; cv=pass; b=BFA9anEI9lVtokc6Ql+e9uRabZt04EwOe4PKB6PYzcRxv4d7Q4brkjzWWjTrDMMVBW5KDqs6DEvIPnQsySk8k+FSPiS9dysr/8ZTlCzMYDGJd2QqtLLKWB2JcsWYzn4d0tSL0iRyeaj/AeUIQyR5zKgrovRM+M9RiPNXo/h2+kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481370; c=relaxed/simple;
	bh=9PfOuH8Ct/5D7RdkrZwZ/TjP2xXwetK52YTBgVhbvFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/KvlLTRSFt95MraP7mWQXBrL8cV0FxtU1X9ZsOLjv2X+LXZvDcuHJy4wvuIA9EZ/8hUxhYOAxuaCgyKzAQ2ROhL1eoK18aM/2fR7xu7fPl53vO+WE08K1VPhMXgf5/Qj02L5IdXdFS0S9iTyxvSpaK1uX83tTXz4XGZXQurTco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH6YqjaF; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH6YqjaF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so530259a12.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2026 16:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774481367; cv=none;
        d=google.com; s=arc-20240605;
        b=M+E+yXziTK6o+5YyzcBgi8onE9Q9iGI6WlStGr1apUvfvMJ+1LtRjwX8bdyOJuWY9k
         m4IKqnlm0vM3aijIDWZdrWMUfvx0esuj4yuI37WTo7DWAWBcSNKVj4D//XyFQUtiszDF
         4D7ui+OEblTckGZqZ6kBQi6Rq2Zot1+TOjmVgXIAZVC1j6YAEOYgg1YnJxjPDOGccb7t
         E6RKjuCzAyMc4ZuRxU3/oUi68ra//w6iZJ5/VrrxcNlentuUf7KszPylYXsEbQhjnsYc
         zYr6fFoZ7rss2YQbpftssRfSqsT7xlo0fkA6uV09YEX0BpdRb4VBF6v9CK4LHHPpJ+Ef
         cRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CE1+v6tpKBUDw5Z0AisbXwa5/W6ogM5hGnxRKw1Lv10=;
        fh=8g2deR20AAXPhjegk+UdLyMknNQuP3R3JVY5+Wa/0xQ=;
        b=ZU3Su3a3mY/SNSV4D1/qutj40y1kAuOhqi4b6fmTN3cmaEFcqBhVdTEGuv57ZGuheZ
         y2rpthK1t+PY4cc8JdtuW+edePguu5CjkDufYHQ2p2hpHoJB8oOTVLGcsqgoT506RdVT
         7c3GYAQQrdz4VdIEyMl3sqhGUULOqg2UqwN6K4qH2vNLdwElEGg/ziBUXZXha6lIBN9/
         d2QUoQ3UbGJKNuw+hK8LaBzhnggWSw2wEVpdC2aOxAM5Rh4svyzairKuSxbOzf+PSQYy
         zkjCHy9VeW1RY7qmW1xzYFGDCF8NeQZvdEI1YqoidWs+YqWiuYFXRdfBFDc2ZZXr1Pkb
         xmSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774481367; x=1775086167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE1+v6tpKBUDw5Z0AisbXwa5/W6ogM5hGnxRKw1Lv10=;
        b=GH6YqjaFoP4jsE6Ea1HY70lAv8IM3YFTlETNh38noswH6+APU8mWczpNu0lIc2tYRP
         GE9cJGlmvX397OXsvHK5UzogrClYinJbimYeMUUxDRIddFuNnj/KKPG7wp5udezlhEAX
         cv+F9iyLPOfhFhY5qJiUPmQ6c+0KwN2H8aIyHKsp5Xp1PofysHzQkm8Pvh9nIzRVD8UA
         Yz6H/0Ok4h6+4llYbPd8z03kGBVzM7CriYRp1m/qpq9bqKD2ZlFiMUuh0NBnw4zce56i
         GunSPkS9vo3gObySEfh9OQWrZ/YntK0v9HEPUfGxn/y+pP6s4Dev7cwRzio8BJaX9Mdj
         Fw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774481367; x=1775086167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CE1+v6tpKBUDw5Z0AisbXwa5/W6ogM5hGnxRKw1Lv10=;
        b=AKRApQV++w/jbtgQF1OuBpHAL12t4jTCSK0XAsE+bHq9CSrU4cNzvOH/tV2cyUxzVK
         0OUF2hnxciXFcxfeRfsYK6D8h4XselXNJR7+Qf1V0+nxR+Lse7C+r2T1TYGbXGVY8cbM
         cOgKz69saPUsjUG9TDNiMZ5u0KsTQj3uIt5sfOqQNN51NKk8JdSq1khruD4DX1xkVtUL
         g4bx5cOUww30bjphrxg1mtAChHeewbBU62ZKj2mL/UNZhRKFiMQvyz8PHnaAXKqtM5mb
         BDhcIgYwrix5R0NDENzWD6KvDWwq+SzHBvdETEvuMpL5zjvOOyIP0gcIYRDzG+l0dQ45
         ENMg==
X-Forwarded-Encrypted: i=1; AJvYcCWt5Qr/y6zEH/xQeoCg7h3GZFKsop5KCACzkJ23j/Edq6Asr42ug+7cU5TzYAUzujJOx/irHWrF094=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dhZ10ObkEgDW0D18hihSDpJeph9Na7l+6MEut9m3zSycIEHY
	3qyiz0XHrjqzWNiv525S6GisZqCHY/vtKZN1qC7qFMPkix4b7Wr4gItJ86ZTrrbqzaHRF9Km3qL
	A8CZGD0P7BVVDjBbHyhTOYGYgQzw3nGY=
X-Gm-Gg: ATEYQzyUH8ULgHpEyQRIQLxlumGeO9toBZ/mZjnuFtGsgFJsor+geXF84sM5U5JNrGo
	IgpN7teqjiozA757YT0iZR+lCQv5OXXGDD/dlNYejUO8N7uGFbxG0u5IiBHA+w0Pnsso68F1bQ2
	gUQ7UPAVL864Z/jkV0m0cPjI2zOIej8Iu9bAMu3HeKaSD9ZyIn1TxfK3i2ng/xSUpiDS+p/A2p1
	RspGDWsrx86Gi1r1JUE+ep6Qzu5w3D+SEPq6nYzS9+mm0TeyLjjMo3L0ufMpLiRFRQH23/PRNA4
	V+SfFzWMDBHlpByZxWrtTt2yw1IhDYEbPxlI8xehoS496aYTF8I7g2oIU08/JIT80K8XxLaP9/6
	L+V96rQ==
X-Received: by 2002:a17:907:1b21:b0:b98:5b2:77f7 with SMTP id
 a640c23a62f3a-b9a3f15dabfmr338827766b.12.1774481366307; Wed, 25 Mar 2026
 16:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324211629.26924-1-rosenp@gmail.com> <acOPMJVsxpBltqGX@ryzen> <63d71f4c-97c0-4c2f-ac92-0a643fcdf75f@nvidia.com>
In-Reply-To: <63d71f4c-97c0-4c2f-ac92-0a643fcdf75f@nvidia.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 25 Mar 2026 16:29:15 -0700
X-Gm-Features: AQROBzARloAI-Ejm7HMIY4aVogCSDARNAJeQ6vsUaeQqP-i5QcBTlQ1inxF_Po0
Message-ID: <CAKxU2N-Yxir-XcH4QB__nwmyyFy02ZC2L7vKUNCNmJvwQwc2gg@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci_tegra: remove kcalloc
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 3:17=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 25/03/2026 07:30, Niklas Cassel wrote:
> > Hello Rosen,
> >
> > subject is a bit misleading:
> > "remove kcalloc"
> > you are removing devm_kcalloc(), so device managed.
> >
> >
> > On Tue, Mar 24, 2026 at 02:16:29PM -0700, Rosen Penev wrote:
> >> Combine allocations into one by using a flexible array member.
> >>
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> ---
> >>   drivers/ata/ahci_tegra.c | 15 ++++++---------
> >>   1 file changed, 6 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> >> index 44584eed6374..5972fe04ff3f 100644
> >> --- a/drivers/ata/ahci_tegra.c
> >> +++ b/drivers/ata/ahci_tegra.c
> >> @@ -175,8 +175,9 @@ struct tegra_ahci_priv {
> >>      struct reset_control       *sata_cold_rst;
> >>      /* Needs special handling, cannot use ahci_platform */
> >>      struct clk                 *sata_clk;
> >> -    struct regulator_bulk_data *supplies;
> >>      const struct tegra_ahci_soc *soc;
> >> +
> >> +    struct regulator_bulk_data supplies[];
> >
> > Personally I'm not a big fan of flexible array members, as there can be
> > only one. And if you use it you want to use counted_by().
> >
> > Yes, there are two device managed allocations. But is that so bad?
> >
> > Since it is device managed, it will get freed on device removal anyway.
>
> FWIW I am not a big fan of this either. It is not an obvious bang for
> the buck for me. The one downside I see is that it does leave the door
> open for someone accidentally putting another variable after the
> flexible array member. Yes we should catch this in review, but there
> really should be at least a comment saying this must be the final member
> of the struct.
That will eventually become a compile time error. Currently there are
a bunch of those cases that need to get fixed before that happens.
Hardening people are working on it.
>
> Jon
>
> --
> nvpublic
>
