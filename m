Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6741D0946
	for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705569; cv=none; b=Ui5CwMRcJd3ARgl2ZATEzlrfW5iRqR2grTmoUm1cm0/XyaFCLssesJxxUfAllswGRCqFw7eFTsZbPX+klIxwU6IIRdHx/Q643MiYz2NzFeQSbu1bhYL9y7pVBAsY8FVZ7WckVZ5drmsGxfBnFhrugH8bBXEefx5XOT06WwcLJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705569; c=relaxed/simple;
	bh=HhCRM8LXsD648EezB/Ag71ruZTVUBPWIrjPd9FGl4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrp10mIt7e7MTcWAxnSuFa0i1HwdKqnss6/PBjjFMuQReziJxk+dA478p745KK7e3vCz1lGoPbj8r4q23E77yrmR/mjwzedbRyFODTQY2oZHTE5a7cPlALAYlgV8dMCrCPiz9533eilO2+8VVPf+Gu4sr3Efr72mR5ZK6jahoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZU2ovevV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZU2ovevV"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so31552a12.3
        for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729705565; x=1730310365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=ZU2ovevVAkpUpPNCNaZLd9knhxmHGnnW2er/zHUhMbhaXTalgW+K7RZflR6ARoY2yf
         CHxbOc6LCnDXwlqQeAE6vKJ9qg38XnuNHAzjqe7AJcKOwOft5ANLNPApjpHQ6lGgy3UH
         24MMPzTDltwJHhQqNy2qUf16O3liOUTWRoVds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705565; x=1730310365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=Zh91XxvizZi+MvR/88WVxnlNe9h43cJoeNlpWInlXkDKWno1Uw5cVsyq5Yvb0ThIki
         +uFDibuVngH2Xx5B0VcUJnkQ2uMcH/IVHWbIXKV9uWTC/mw5R9jQovD9bh9dcgG3LA+s
         NuDiVNbXFrUlAUi8k+CsJhk2GJfRKKUiLmjGOGtlwmsjWo9UC5ifq3qkFD7L9K0oiqJE
         rwk1NH7WXqFyI78zoUX4LKScApFWZYQt9UXv+yFHFeqt73vstQFglbEVl+gqPN0YSqLG
         qYYi+ouLpHQpc/qnCyn2xinOG80C6EXU7PwVDi/Fr2YhoPs/bMgkMbYI9rH3iBlZOBFR
         2lSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAZN5QTQHUrsdD4uZOus9xKpWjmuwsjJxvNZof3TXssKU+l1hCaZTGtKD9GcpYIB/+xh/Q7pE2ICM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpWpZhz1mqvQicg2hC6KGzhkA6PAbafeF4+3aHBOJCuD/t45R
	xEoD0d5mXeGrmz9oYqvkwuBeyD4V8S+nmjNy1+2qQKELDAMDSvSm8A6VHRtnldB6inewMiZNU6h
	zpaI=
X-Google-Smtp-Source: AGHT+IE+s2I1OPwAoKlcbHhPInQKk8ECaQ0nBRzOREXWyuxwOUN74pgsH9TXHsslP4jWTXeZXinOWw==
X-Received: by 2002:a17:907:9624:b0:a99:4f40:3e82 with SMTP id a640c23a62f3a-a9abf84cf8cmr366076866b.7.1729705565469;
        Wed, 23 Oct 2024 10:46:05 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6333sm512227866b.10.2024.10.23.10.46.04
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0f198d38so983210666b.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuH5lYnp9hB27PY8JXRcD4y/I0FSGXB3B380ghwsxAviA3CoJ3JzwueBP6FRGCFj0kKPwAt34eIbo=@vger.kernel.org
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9abf94d4b2mr369489566b.47.1729705563762; Wed, 23 Oct 2024
 10:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
In-Reply-To: <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 10:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, gregkh@linuxfoundation.org, 
	wangyuli@uniontech.com, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

Ok, lots of Russian trolls out and about.

It's entirely clear why the change was done, it's not getting
reverted, and using multiple random anonymous accounts to try to
"grass root" it by Russian troll factories isn't going to change
anything.

And FYI for the actual innocent bystanders who aren't troll farm
accounts - the "various compliance requirements" are not just a US
thing.

If you haven't heard of Russian sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Russian
state-sponsored spam.

As to sending me a revert patch - please use whatever mush you call
brains. I'm Finnish. Did you think I'd be *supporting* Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too.

                      Linus
