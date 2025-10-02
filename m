Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC82283C93
	for <linux-ide@vger.kernel.org>; Thu,  2 Oct 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410129; cv=none; b=YkM+td99HKksgH7ojz3ZTqm0ugfS0sM7tibsim8F/dKAyy7hOISjf79sXxpG80S+3xB9rec5UIbJzzFe5kXV2Jf5ls3CeSygUIf9kTpl7PsoeWD3z4lvaW83Afo99fCwuvLGy6lp3997t8ye1RDV3XmOakyZq/4lT0y85Kk5OaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410129; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVgJcJHzTAnHYuQFg3wCiRaraDDZwi9RPCdqsyQZ99yUlR5bpHn5O7C0YeqSFpkcmKgAykCnQPLxgco9vbXLB6AQNSTpmkkj2xCkNIZ43oaoEhlO4x/lAbV8h81jmWEMfu0OUlvCqgw3LhC5+0PXRvU13ANu0cpaGyImGW44EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856328df6e1so114602285a.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Oct 2025 06:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410127; x=1760014927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=RWFEMxNrJMMIqkDNe7gA1xgIFPLP5vnRw6yDfP5IY9ohnUWdaGsPuA1QqcIcDYV3Du
         CZLTfrXzqMsF+nbkXBoRexj/PFgnY0QmAXoIpB2swoz68zrxFTLATk1AJDHADX15OgK2
         v+ppFczTJMrIHR5HPIe9+eEnu0iOsfleHbF032ZJ4juQe4ftacYk7iM4um5mCAcBrv1x
         xDCJEyF1pVTOWywSSxlGCsmmSprEf5TwFKUeOd2D3QaMAkiWUIC9U7iYFocnj3LrbKMw
         3BCUIWiGRi/Jd5h0Z7DIHosvzUGaykDJ2gAbVNkdalqDpqKTAixMVLD1bYyTz0mMssGY
         uk8w==
X-Forwarded-Encrypted: i=1; AJvYcCWDl2tF3k/6phHJ7pu9NhAD1YPzkgBsoc4OXv8zx0CYCCHO956+JJmM/UntMfkvZiq0HUh8vWz13Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtTaJPX/Ldvc8HDd+9f123jobTajASaXOI78YI1aCedJxiPZM
	aAUMLVvYcnXHFKfMK4kXM6stI2yJ8/ln2sYNM6Vkk845hZDhMxDyJ6f9piBalTa2SL3M+A==
X-Gm-Gg: ASbGncs8boNPGCfWQUTwpgeUzQkqwKVk5i/n7Gkei7EVmvjo6Q9mcAXMZRUOCnlGGCp
	VhpCCeHMJMZzpX55oh+P56M+3Lb9sBKypJjKK/pIECRupmSrIQYi1QMV+lwZRIryM0zA3gR8O25
	SMl7nq9RVjPTH6zv363kBrcS0HCnBh9K8L/0eTT550BRzKLxpJKejuzOo8uS8EpBq0Na4EyqpAd
	JrSh4nu3ja7vSQh6UnRb6TlAQL5e8ud6W63l2JhAnSS56XdjGihfdKRQzv1iRI+EdJ09JKaJPXx
	59rpOYzIUIC+lMkcOFDCG+P+rsH5H1o2XUFziVT05xhnSTeJiaj5Nxkg/c2tahUOuFh8c1a0d2G
	fEfR15vVED+bD+9VGb+kjSfG6xVQaxKBiSMOtv21CW1lYQMKWlJeoe3OnZiHXvnwZkA/i5P5Drp
	ysur5aP3MoDm1x
X-Google-Smtp-Source: AGHT+IExzks8/EmHzaxwVqqdQiBU9q5BIkgCJdFa9E4LeHtoI3M8vu0Itj3L9K2SyqGtXxgv96xiQw==
X-Received: by 2002:a05:620a:31a6:b0:829:b669:c791 with SMTP id af79cd13be357-8737780bb2dmr847533585a.78.1759410126245;
        Thu, 02 Oct 2025 06:02:06 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87772460ac0sm208035185a.19.2025.10.02.06.02.05
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:02:05 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85e76e886a0so90986385a.1
        for <linux-ide@vger.kernel.org>; Thu, 02 Oct 2025 06:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRETdII5wDuxv7s077TodPLpdRew8o9rK1NN4tDSnIj1JLDf88dxoLoXRj16zFNVFugIDyeSvBgE0=@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
