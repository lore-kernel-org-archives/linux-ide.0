Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EC283FF4
	for <linux-ide@vger.kernel.org>; Fri,  7 Nov 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505253; cv=none; b=Mmefjv3qzBce8aAwqLBNg9uiJ4gRHmxlpr3JDlXUrmTztO5Rfj/P5aa2PlQ/aBexn5/5tGzeL/Bj8Yys5VdKp2wZXTgbbNo4Dty2AdhiRyoe8KnHaJPmgIEP/aTDXD1Y5gTDB6hlD5o3HCjdtiaLqT+I0arS3+IPShSBqU3QgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505253; c=relaxed/simple;
	bh=ublKY7ieyOw41ofqwSkgdz7bMYK56Ys0iSJ2bpALiV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1HFoEdjGb0adwZd0yQ9aupFvm4/JyKseOaG3ilB5wajEcs4gk9hhan7cjJEIkPrJuJPyOLMegzDVASKJqer7Re/z7gIinz8JKydRG5vaGKgLwRn5eM9NwxfBkH9mETs+BFjWNTnaunyMr1XIfxRLJZF4LW9JID5SEJJAyVkIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RNVk9hII; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RNVk9hII"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5943f39bf9dso464364e87.1
        for <linux-ide@vger.kernel.org>; Fri, 07 Nov 2025 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762505250; x=1763110050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7vrmwe4LSTSS8GlaryaFh4epBJZEr6110KU+wNfXpU=;
        b=RNVk9hIIimV2G7neK5BHU/2xr9KigcpHOA616k1wImAQdyyyde0eZOmrvFgLzZlyPL
         FtNnQEJGvolKU0K122Z2+zGje8OZqQlZvGXlewKOrj+Tt5lQ5kkao17gjJ/YgJ3qlXQv
         p5LsIPGQKj+HUlCY/0RoehICsnl7aY8+RgWX5kcBUzNEmm5hp06STS55NUuHE5aUnfYV
         etIHWjQ4i4vvAVvcKkVeO1cYDLeSH7sWOSKu5PxX7cBqIFlgiEj35/TwJNDxxSMfFKD8
         N5I6DmepjgssRS/HcqEQmw2dwSftDN7339FxB/2Y3VsaHWTNiJq2OwJXFu/DApQw4kGt
         aBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505250; x=1763110050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7vrmwe4LSTSS8GlaryaFh4epBJZEr6110KU+wNfXpU=;
        b=WosDUmDYsuwJIDDARNt+gQZo6HmlbdQjL1dIkRTwcVeBaUXb7Q4Ep63vPwedHLc8Xm
         6PcQGCwkEQhLNqVEnU5SC4MtckU8Cfwz57RwhCvHuMRTxukPuyOdPei1rf/Q66JODHXn
         WCwMCSC8ESH7OmSBQaMErsyvFVxLlZe86DDFpBMuejY8IwKP+TK4Ux0YZPaPAw2YmwJJ
         567FnRnbjZKY/iBRtRcg55vwiDr/xg8p4KhWLhtWqNW+Xys3pdr+LFhTCdXOIpLdFPpp
         HnvZuksgE+bVzDN/SIXJHp5x3vHGA4xOWAb7nlg44CfTXhnGHLZ3JfbU+hsBrVQcFKrl
         bwbg==
X-Forwarded-Encrypted: i=1; AJvYcCWOtbixZpJYN6B0+qU9zHzThPvLJYY8eIR9C4ZgwScJ2n7K7KWPYhg/JEG/T1E+CpizHzxhsdBkrgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0vZCKtyoZI7Iix6hBX2VkeQnNdYVX5pdvj1H7NsxGHOXIFOG
	ODq6fIfNEDM21/TzV1T+lIWGEScyNwhbyDF3ZYZjxXvuD244lqhWaLE/kFcdvL62sAdM0vltN8V
	rhkea82oT5hBncivs60zfS1gLyPSP6sKG+LY7vF4Tqw==
X-Gm-Gg: ASbGnctcmgecsa0uOhfpke0zSFUX5WR3ZzqCiPd8qbm0+PFDzBTygVtSa1sCNvFWL/M
	F9GfiXPpUUjowIYHtLPWd2UloUkHXEaoidy/59H/UEIJoJYsVHcdkrb5gcUOYL8FMLNjL3o32iT
	PYRYmecJC+R6G+bP+7LSQoy6al8YDDkqNsoMJGJE1NrGUw1jpVVp9q5736iX4ywhfAwBU+qHynT
	AUXHrFMHmziqCEDYdCI811axbe54/6h44r7EgJOtfSV/Ra8Kn2tOMMAqNhxSOQ9EXNBpacEwtdA
	hfVgEPncFPCGq8UaGw==
X-Google-Smtp-Source: AGHT+IGHcW6D12RuQkvVlZ93mZKEL74Ac/7abeDYsY20QsLXLzM0cSDomTyS9S7QNoeKgyYaLzMREB159O5aLkokPbA=
X-Received: by 2002:a05:6512:a8e:b0:594:524d:d966 with SMTP id
 2adb3069b0e04-594599dd8d7mr322059e87.21.1762505249622; Fri, 07 Nov 2025
 00:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106160813.314932-1-marco.crivellari@suse.com> <176250512811.632228.18184423075799177449.b4-ty@kernel.org>
In-Reply-To: <176250512811.632228.18184423075799177449.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 09:47:18 +0100
X-Gm-Features: AWmQ_bnPlBAxmTBQR01L88565Agut7H1xshN4PnnoPQNpt7aCKHFwxk5YJksC90
Message-ID: <CAAofZF5FWCgWmC+B+Z-1CbRchn1LS3evP880O8AYEF2L4_P9xw@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:45=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
>[...]
> Applied to libata/linux.git (for-6.19), thanks!
>
> [1/1] ata: libata-sff: add WQ_PERCPU to alloc_workqueue users
>       https://git.kernel.org/libata/linux/c/13f4d995
>
> Kind regards,
> Niklas
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
