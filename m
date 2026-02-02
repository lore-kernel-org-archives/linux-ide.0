Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618418B0F
	for <linux-ide@vger.kernel.org>; Mon,  2 Feb 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770009811; cv=pass; b=V8qZPmdC93QpqgyJ09ftWKgboa8yBQLo6LtlhfzbE49CEXVcZYuuz37ReA3k8oXJUFaUwRNttj1utIK5F2cpxr65TYlwqIvuGXLRrYRT3DAn9OTa5RAnXsv+09GuCM85z1VBURbxsItdegaR8tzs95E68z7x7UsJlM+gHVDwG3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770009811; c=relaxed/simple;
	bh=+uoqMUiluehh1Du7DNImx3fYVDLFeZ8xbIT23w4TV5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvJ7wcL3fnZcuNZ1QEhjSpXbgyonXNeoBj9RyXN3gA30UOW3aU8Bm5+sjFKqaWdUXnpMDDN9gMWmsDuwlsqvd3K31TzfVpfwF05CMTqcbfl59FEzy7Nu9/eBWBovUYdFr5dP/ryNWYCO1BepHgVzE7vUXJQJA8FPDxALPOWL7kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjepeUy+; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjepeUy+"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946e32e534so48554036d6.3
        for <linux-ide@vger.kernel.org>; Sun, 01 Feb 2026 21:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770009809; cv=none;
        d=google.com; s=arc-20240605;
        b=BBmudLprEfARiQNByuL69a8/g0eRaTTHBTcYKaQQKBmEDOvfk3I2q0P9hDeSyuP0Pw
         /EJQZMA1XH/WichnxjwpeKIsKjbTbNXVrlM7k/VfNOnegXB92AOkcXFVtEhqwMEKn3wW
         nae+R5xsiQeJeQumFOzuLP561sd6m+n1f3rM9xBjcZLLjdu2TQSduQQxHMBl9Ugj4/pE
         EraQv2okXCdXNsx9K3X7zNW4AG2tuQLiS2LEjgu6Ko+tnMyyjDak4+7yAGeZFKHqjv0J
         h5ru8QRugl0eIK+sRk920qhhUPMZ8F66maFLuLaMyNottSNYAdYUF7e+uFATZtuq7hv1
         c3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uoqMUiluehh1Du7DNImx3fYVDLFeZ8xbIT23w4TV5Y=;
        fh=xwbopahXrHvZHA0C/4BG1IIz1hyQ2x5swPUXWsXNVZg=;
        b=L7vceDtgidj/9PZYzIthWvRyY80lwuW+9YaIhalKrYt50E+JyskJNWK/OW8ApAuXnm
         gFK5zWyawss9Jy2YrGeTGqvdd2W6KX3hxMu0Y52xvDXB1F9+lAPIil5tLoICDSZjdAKq
         clqpJZ5RDA5ti29p7zCfS01q5oX26fqy/+kRjmIHdF/jgyODBWQKe3z1PoTUHpdqCJ34
         ut+laOqn97K/P5k7GHcc6KRqcfuZoWGFfhy1Td9JFqigHd8cXbuhZlZVPPknu2RzZTUU
         +iXIaVZL7W7CM3JNQD1bUMGuYTx2jksNwQanj9EeLUlXDnTKOEZ4Zi/6S9monI/2G0sR
         vrZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770009809; x=1770614609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uoqMUiluehh1Du7DNImx3fYVDLFeZ8xbIT23w4TV5Y=;
        b=QjepeUy+2qsHP9P5KA7hGgj5C5NN9u9qCs2Iejs/71G/D98oGg65qUAr7eKVUf5iKe
         eui3bmqjejy4mU3DCMSgiShdeqvQKooy2fZNbiQ/vrnRti7nNIHssAVEgtQOuNVYKOxm
         umB/CjD6fuaYNfQs8V8urUZsDMWga3WAf72jI0sawMoqHv9ipqqF/PTjYNlL/5yETzQD
         VCZx+a3YGmNLPlv04xdCI/8LYzQ+vorIoHw1YxO4oeDF5kmhWu5hdPoIkOfEAWo2KSWb
         eC970nnNiTeq/ihhd7nn3iDxbCoF+UuUf4jA7Gp03kvq1d++fijP5awesAOzgRq3ysLG
         GtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770009809; x=1770614609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+uoqMUiluehh1Du7DNImx3fYVDLFeZ8xbIT23w4TV5Y=;
        b=Wlcdqk8ZmZzgOm+gkUIQvbslu9QsJqTmswpwV7oD1STbSQ+0VtKGD+kExbi2dKxcmj
         4Q/jfRcgtxWEjSI6THQQWi8Kf1HI3s5Q/Qc1K0OZSekmblDjfjDO1cpQyMSxPguSvLJH
         l1X2KjJRjm+N+aNyOhhxCyb56Yl+mH7/vAV3kCU04jxJH/LtWYSXaIb17lmB7h1msV/z
         SJ82R+zEfp1LdLzEJbU56JI8ISRvK8UUBsTCiCKYHXAaZ/ZKeCl5WeziotgtiXIeJU4h
         Xh0m4dUZReshIAbeyWDiLmMolZY7ANlZeKoTpOlDnID8dO06f0QvhvEpdLJiiuw7uqcy
         SG3A==
X-Gm-Message-State: AOJu0Yx357PxIg83D4sGZosDKgh6FjzJe7UHkKJIkMKr6TT9SFRusBwz
	Ep0146gA1mLIxD1DF4Qs0ii9gU/SrB92UbOiM3yzqVxbBmNgOlq8O/UyvcKcvkekll90wBf/iEo
	Jeb49Qm5qWtk7UZLS+GvH1b4sGUFkt12iRd8R
X-Gm-Gg: AZuq6aKIHd7o72LXoHzTbgl0ZHmeCPa4UxKopJit+E5LGwuvtRIt7bYiUD0XiZcV9QQ
	ihvS5F1oW5kkV/mX2t28qccAoBy/eMfyQJor0t+EDwRasPeZ07C7ynYhzziWEKjzCwTQS92NXMB
	RtqClUkKnQPRYUA1JjqUeXw7Z3vFaKcMgHC4S1fbzkdn9LaQgvf7uVC9nUAobxXCQN7Acr8Som8
	ZSjRaNtQtfs64Xq32eHELh/YATEYTqZO3bdcTjHnTw+WNZIEVj+JnemCc/+ImWXWG3+JjzsXeHt
	AYIPDLtIl39jGwgbAmjtcWsoYGTcb/Ld6i24nR/t1A6m+2v6vOnwNbUn
X-Received: by 2002:a05:6214:5087:b0:894:76e9:1bf8 with SMTP id
 6a1803df08f44-894ea115770mr152645356d6.49.1770009808798; Sun, 01 Feb 2026
 21:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131032812.12451-1-enelsonmoore@gmail.com> <65f91808-67d1-4893-9fb0-d8a8bb03841e@kernel.org>
In-Reply-To: <65f91808-67d1-4893-9fb0-d8a8bb03841e@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 1 Feb 2026 21:23:18 -0800
X-Gm-Features: AZwV_QjukZsLOieT91iL1kk1e8Lmr0BhWNXJKCh7oKVQu5th-IeYSUsGQ6Y5olg
Message-ID: <CADkSEUj1-xioyN-xWiUK92Rg7wDg9ErA9CUUbMLqXJfC6+Tv9Q@mail.gmail.com>
Subject: Re: [PATCH v2] ata: pata_cypress: fix typo in error message
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 8:57=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
> Applied to for-6.20. Thanks !
You're welcome!

Ethan
