Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E137B036
	for <linux-ide@vger.kernel.org>; Mon, 11 May 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504081; cv=pass; b=t5Is0v3futBg/t1V4h752/D/lzFMpfNYmSbJOIrtlPPT3xI1y1ZJsOwTxPnddTFL9+toZbwEFmieYW+rtiIv1xZ5fZ15sKGBEj4GG2zWmpiEVL3uOGn49OoUuJDrFSvRINvcEr5ASsARHiY5+CQ2kTCiitGRqhq5S07rOSjEjqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504081; c=relaxed/simple;
	bh=p6LRIWgKTWdO3BtCUcZjD0d0okqc5q7fLq1zYTDDp2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7Jx83tbCpFifxaao2WfDkoHbqqBXlx1Io9Ps9BSIgwqLZGyuPZ9Axe21AInL/skmDHk7YLdXhfnlUmlBDYSKNLISx+z38J2r08miIvTybtudecRLSScCLcOEbHI5Q5XBqIVqT+MHgvgz6QvcaXmw8C9hyICLqM86FuEtLqc5lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BQngp3P7; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BQngp3P7"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dea72099eso4262279e87.0
        for <linux-ide@vger.kernel.org>; Mon, 11 May 2026 05:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504078; cv=none;
        d=google.com; s=arc-20240605;
        b=WqejhYxlPbDRoGVHd/zRQlWBBs+dwwVaaAqZwuWsFmFXevFG8WsntpOJRtpG+zLbhw
         Nnn3ze1sNmT0xT/ypNAAUYzWQR+hFMacwfdF7kwI2c0Rs9oAmdXkQ/YAzmiPez0gA7KH
         fIq2GCaczHgPMXVGEXfudpzpCswkWOAm1m5N+yg/7JJHSp0xcXS20QwRPOg0Q/a80kHC
         l2Qu/f4TU1c4h/cbb98pqg/ZtwA1d7UOeQBftW8UZbJN89a69NFOjYyASnWDNFdjQrSZ
         XQIVgiS1tDEg3ugDg9p8atjRihM8PiIPG4433l0vaC9hqWo8Qzo1BUKzpVmy3gLapdCZ
         Q1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p6LRIWgKTWdO3BtCUcZjD0d0okqc5q7fLq1zYTDDp2Q=;
        fh=//QK2MhIjhsUmk4F5pl26SWIs1Z5mzTMAdDyry9WcZU=;
        b=MLlB7H6F3HW1iLE6qPI4yHMipLrhyHzVn3FSmjBmTZOjU8heqo9GT78PcoXXxlqRDu
         uOjMekdJeMYsTzD12ArwYCIyu/ydu2ZZxHdB9CColBwHMS8UX3L+39gywKNKn/wbirRU
         kFamkMnI8EPJSno5HgqC3FYwa7VoO/+fIZVlThXi0tv3qyRJ7q8UwcxtTSvxGs0E+q7E
         NuIfE35pfpGom6QoSM3ICUY0hSHhaGQXOLz4Afr2Gcb+bin3dMlTcKNJkS2wfIZvSl0I
         CCw/lf33JvI/5Hcp3Eu6kRfbQoZMgv1msdhpbA+xwSEx3gGHfGA8JntlQHLugnWSfxik
         o39Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778504078; x=1779108878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6LRIWgKTWdO3BtCUcZjD0d0okqc5q7fLq1zYTDDp2Q=;
        b=BQngp3P72ns+y7VtXO6roWrH+BdszQ0u3OR38+b8zyW0uYPsz0KEIbWi1UFl1M3oHu
         JgnHb9E0SLu2zqscPdYjXNadnrHu3mAkw/QMcHsW8l26aHrm1K6fiSHdoI8/Gma3LP4M
         jCr03wG71Jpo5OuA4hPeR1PhZT+tcENbXJ7a9c4lvU8kLHbwanOz0WDFOeP7ZsaH49TX
         KX7I7UZxWjTUjdB9Qr1k0VHEtCSxOlVjRjtWdHsFrUfv3f7VqszY1J2nvF7OF8V4PZA+
         /hPsn0k3k61sVVeYQeAsOxdBJE/j3iBwOd20FyF6B9zt6NCnkg6cR6MV2eujkY7Lgkt9
         FzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504078; x=1779108878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p6LRIWgKTWdO3BtCUcZjD0d0okqc5q7fLq1zYTDDp2Q=;
        b=XrCDSedgFnP6i5/xsjSWyHySq/Zo0+wITXBElmMX2uLtqZ7HDB/Ef3S6JH4DNZ9iT0
         8/TduqG8RA8hZAIQfbwlhMNunwhdpto3T83yePBgC8iiJ9W4240jsf2KCxaH9Hjd/6Ib
         tOyK0sBL7UxPWKAZeoLc7jLB1Pr93rQx6kTYrt2G13A7dr987QbzueTd8Z1X9CdC/tB1
         gI7FbpF611YD8VzzhfcmfqX0Q7J+r75TeIlL4+QjSoR0PDA1reNUtzXRmVlqPPK+G4CW
         KSXJLMDql3NbH8SAbLRT+1EBgVZ8dHhYmKKyvpFyk15laGhiPvlkwp2d5/UkYKXMmVK3
         4YDA==
X-Forwarded-Encrypted: i=1; AFNElJ/dVTCNCNc3or9InZfCS5Pp8pmaAuhZgKS+z36KZQ2dxNwrzIFg0MxyU4NTe1k81AcNy0AwdCJtjYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ESN3ZRTn0VCa4GjXEdLW8ZX93TNPh7PMt8i8UVOWY9meQ2TD
	uLIB/CCp5kfvyToPoSdT2S0ii/wiEgwb0R7whpQ0V2YvA8mjVqZxYpYY5jkKorupgHYRfx6dqUB
	ywGNPT0sd/Xu6VCitlddZlAYFVyayisIw985EfpwXug==
X-Gm-Gg: Acq92OENgugYMxdk6NFaHSs8r1TB3yE+cSk6478moj7mV8bsptpH9lmbI0PxTsrrEHK
	eTZDJTJE5qolHxE/wBkH8BFU7ZN+gk0G0R9cJjQC/v1+LoMSJTcu43d43qDhanSRHXpChPoI+ru
	erTTJYKG3JLA0oqhrfimzPmdDV8M6JWKf7Xwcst9WDux0b4Q0kmwydJLkzVzeFDrY2MZG5sohG4
	ewaI0PcWJvU+r75Lnfza9hZJuowMdbpfN41iYeZv0Ftq5VYf5JYT0dN65b0gWh+kISdSMvdLXqc
	1RNiyg84ovGc9sqPnLfYrwihHb9WLehp9TeD3UpJ2d4G2G6kBWkIFmWW7ISVZg==
X-Received: by 2002:a05:6512:3c93:b0:5a8:9135:127f with SMTP id
 2adb3069b0e04-5a891351c26mr6251326e87.17.1778504078281; Mon, 11 May 2026
 05:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430092947.128647-1-marco.crivellari@suse.com> <agHQBzVdIIPSTBah@ryzen>
In-Reply-To: <agHQBzVdIIPSTBah@ryzen>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 11 May 2026 14:54:26 +0200
X-Gm-Features: AVHnY4J0nMa1IiCiEFwYM95DwRepj9ld6dpXwlp82B29OdABFe9YcldvhMHQaFY
Message-ID: <CAAofZF7NhFUHKhp-HdvSx2doFRc4XFERCL22V+BZXrQVjmxugw@mail.gmail.com>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on system_dfl_long_wq
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:48=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
> [...]
> Looks good to me.
>
> Any particular reason that you sent this as an RFC?
>
> I can see similar patches queued up in linux-next already.

I just wanted to be sure I didn't miss any other reason for being
per-cpu, and in case
receive comments on it.

> Do you want us to pick this one up?

Yes please.

Many thanks!

--=20

Marco Crivellari

SUSE Labs
