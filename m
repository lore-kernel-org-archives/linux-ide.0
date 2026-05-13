Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AF3DBD77
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660075; cv=pass; b=PIis3IF/uLE6eljUoOEnC0fThbexsuiKIophGrYNvzz4V7JrijQnGevcQCQtOm93PfhtONurjA89enHzx0Oc3Q1QspLRjBcI7ZTqR8uwFGUqC1k57fbro6sQoyWA5ad2+n6P6lRL9uMnJ1xZ6Rpbifeiwr5zoiZJW5Rc570Joz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660075; c=relaxed/simple;
	bh=QBu1KzxWLIy8y0OH+PFug6W3a2NOnzvT2ZhYdeQjlx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYDZrRkaEN09QhiQZCtTGQOxXrVZ/SkP/1m0AXAIWuL5BEB0H6fHIjbkof1nQf8JhSS47fxzAjWjwuxizddarvf189WMSssLFaHokiF8wBysUVNeRqXtuPi79jL2uusWpkcha4B/H6WLV1FSPRA7Gu24KlKOMy68+9kClBK028g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UjVEhVNu; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UjVEhVNu"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso6412879e87.1
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 01:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778660070; cv=none;
        d=google.com; s=arc-20240605;
        b=c/MSDaAcyuzVgIlPbBAtDrPyM/sWPSiUzq8aBc7KX5Oi8Yuxt4Un9zFeV1gQtFm/qI
         BVpl+EE3uYJy6pvH9IHPGSRGqPK2GUZxrumjSlbRa9z71vUYsEeUssHP77gsz9gE5bZ7
         w+A/Suwj03jhxCpbH2GYEkA4ghmsvLIVSAh0YG2joqFyHyHyd3b7nvhfnB6oF3wBJbdt
         4NPINB5GNMb52QHmsOhSti1+YzX0zzdMaSe0vB4n6ix7rborrMEf0MJmYGyW/qJOJy3q
         Un4cKq0umrJ5iAVRu8lJUk5AIXYtRrpKW6v58J6+2k4OKWvgnvIT+8vDlowoxWQUUR7L
         e1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xeyRwVBQ8CXB/UL9xuw1LlngIuEVoxSB7uulrvRHfsE=;
        fh=J5AVt5OkFaL1JJVEyYTWLcfRrrbhzAweIzQhY7jS2+8=;
        b=YTxa2FKHgYw/3eCHCikRS+EUFtUPt2Cwd5yDDCNe0wja5504fWpiWXPlHKL6RihgkC
         1M7qBPND0gQIAs5qeANBAK5T4EyDezAdjMC/LG7WlgFr5NxcNBC41FHodgkb8lEwrjjx
         Xg26qPnpJM1JRraCbPCzC0YXBhyzaW3VagJ4fN9Zvj+y3G6xhCY00zGVzY6c6LLOg65/
         NEDkyxV2dXRj4gxXTf7asjZ1UD2msk1Wb9G6tnY8IsJgBeD1eJDGIMNwFHxcVr4VVHGO
         KEptsIevWQGBAhwR7ZsSz5M80k0yp9CYOBfOYxwC2ohJctQd88rHSrXkDMNCfXuUztCA
         uIuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778660070; x=1779264870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeyRwVBQ8CXB/UL9xuw1LlngIuEVoxSB7uulrvRHfsE=;
        b=UjVEhVNuGemu9vrZdSeyJUUne5hAflSQnaTH0XRwGpk+pLNo7NtbSmzhuk4/jyWY1p
         gcS88XCX6b29jfjgMrVPePk3UfysmUIohnVQ9Aw42O93wc2gvsvQrnPmdzqhAY51ywjN
         +1Mgq2WiWWpB3o/lmPibirCVdb3tJkBrGcRbbCAP+Y9AO7zUJn8Yj6f4WZ13EmeaL30+
         PNQSz+9A+/FVwNyk4kz2UX3IpPXiqaDSNYQDhRmykU3mEuM8S0GCRYk2342+aGpS0gym
         7BYTXaYdzOc4fRpoUoQIKYlfjsSBpc2aw4L0CA354LTKMzvJflNOkH+KLB04NqoiLEpF
         qKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660070; x=1779264870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xeyRwVBQ8CXB/UL9xuw1LlngIuEVoxSB7uulrvRHfsE=;
        b=AnC4VYExVpGQzPm5Sf0UFjgA6gp+ZwZpoC5pJb1nZOnqsqgiC01PxRZA63WqBIrAie
         BaUdzmpsmk0CcuuPy8JHKu0DY4Lk0qD+PJlafzNwep09+/AzlQ4BbZuLqa71CEKle5Pl
         KvYF/fzpqUWlaH57/EWRcqi7my5kLxDjsKtUifSWSbtiinGGhwg2bSM2dc9dnPcVl8Z9
         OV+arCYPfxo38MHagvy9IKzr2arElj8AVPeXVEQ//3YP3DphaEtwRt3AxkFXmqCJfleO
         OG6UMMFQ5hHSmjUGYQkvGSnAbP+NH3LdD0xrtASPpPDKm9TAGFyWbnvVf1yCf9GOngA3
         6v5A==
X-Forwarded-Encrypted: i=1; AFNElJ+p8giwA5kg9/5LTfXh9MUjDKJdwOj+Fbk2iREZ4LkwowqKZfDt0VQN2j+7qjoIYrOF3RbqbiKTP6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41AodhAByl/rvnl2xNyAZ9s7khrRasPCZTU530LSJYVGONRv1
	Oo9vqqb1zEti3qaE6D4zbeaIEGY/AjmX63OXmfwchXViBmG48uK66fGft+y/GSzqmZ3ONl+RezB
	m5L7CXy2CTmGyJlQLWLuKW1JBm3AgpMs0Z/n9k90teA==
X-Gm-Gg: Acq92OHgTLchsyEnUq+OY5NzSVR0NsRs5prdNZZLaEPLmH2rWdMfMpCMWG3qZwLUa2X
	UI8FO9Wv9SCjGSpjRm8QgNK/F8YfaDegSwtHvuHexVDQhN7SKJMoOy4R0Kzh04OSU71CD/6LwNj
	32FMhM3Sk7hP/lV97wr5YON1PBPe+qippMtxsD4JAxKTbAsQ4aDbECpCUU5KiemsepCP/x1KrHi
	oxRiacIsj9NDiBtylXjIx0nugwvfzSvZzTOcY4uP6x0ksLCe6oAWXQfSZu6EDYd6HmRUW0qgFp6
	xTfgcfMbqc2+0wx0QO+AUKMl60NzbiJLI4pRUVxI
X-Received: by 2002:a05:6512:31c9:b0:5a8:8eda:bed5 with SMTP id
 2adb3069b0e04-5a8ef9978c3mr925970e87.32.1778660069592; Wed, 13 May 2026
 01:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430092947.128647-1-marco.crivellari@suse.com> <177865818406.650802.13202534059090445731.b4-ty@b4>
In-Reply-To: <177865818406.650802.13202534059090445731.b4-ty@b4>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 13 May 2026 10:14:16 +0200
X-Gm-Features: AVHnY4K1z06dFd-hkTgMKtfytC4RG5tqC1YdABtGr5MoYvOk9osTdFDcgFdJN_8
Message-ID: <CAAofZF69w3FncXrQ6VMv8SsqhyS0+z47VgB9WpJFNUi27q13pA@mail.gmail.com>
Subject: Re: [RFC PATCH] ata: libata-scsi: Move long delayed work on system_dfl_long_wq
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:43=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
> [...]
> Applied to libata/linux.git (for-7.2), thanks!
>
> [1/1] ata: libata-scsi: Move long delayed work on system_dfl_long_wq
>       https://git.kernel.org/libata/linux/c/79b6e4dd

Many thanks!

--=20

Marco Crivellari

SUSE Labs
