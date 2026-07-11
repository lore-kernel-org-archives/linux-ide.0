Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813583A5421
	for <linux-ide@vger.kernel.org>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772001; cv=pass; b=g6qwfIUTTmQ8IFMBg3VvgQVZP4NBF5yptzbeKlnoPqcwzjJZzFP1Sn/b+Qf+IGZJYR60v2Z2NVXD/tqqi40DUqFxbGJqoy52u3x/hNDwtbYKESv3gItWzb8xiGLT6My+ad2+Is+ndBH2fY7NPxz33UuvTKeEI4BNicI78kVTJyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772001; c=relaxed/simple;
	bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7AeBtbrysa03RQO7Y3e3j90F0Oj8Y6kqi8oFT5O9O/KXnXblwMPAU2wVGM9GF2DN3xVD49rkliVk0YqmesNZWob/gxkt/tJ7cgaEUt7GlN9CTovTwp2udZGGVawJ9ZALJAQMa1RN/zPLSjf4gr0UTIWC1K5RR51PHCjG5q4Sss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHFB0fSe; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHFB0fSe"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38096590070so318985a91.3
        for <linux-ide@vger.kernel.org>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
        d=google.com; s=arc-20260327;
        b=VTUBVLssfNj8d1KNgxylk54ziRhj/5oB7yqLDAW5m5d1JKC5it+7HLUFwXY0U8z6pM
         r1i8MViHLnGtgHSEtPN6Rm8K29Y8vpPhMfT9uEdyVq4nF2oJnd7myfysH+eziu3HXoj6
         1Be5Zk6e4AO6sjSRNDJ0HAXN948vk3dm8bCHX9QFASPLmpzYarvoyBKWZqhfauJFebvx
         wa0WSLHF0L/BjPsANMYBPFy7UrGtpRUfdD/x6vx4YJAHVyuu15/qTd7I//PxV6utJme4
         vh7G5/OwfZM1BdwGLZKMFcBCRNV3NX30Y4DYYq+kVVuvz9WoCzPfqJYnSJKrteg6T7qS
         7Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        fh=V+fN+67GSy9sF/B8eNjzWz/umSonrjlhWaoU+cbpOjo=;
        b=k1huectdxLzecMhtmHrrncTHh5x4SKPM7s2/TbY8X6Yb+WVSUBW04be46hSfumdAgD
         E264SHsHeLotDw9KvMoWqgQI3eYY1/mQQRQWUhqKC5GZys+5rAR+zqUCQ7FUFh79mb3V
         rrlmSzE02Pfev4WnFeksU9iN3mvacQY7goBImXZD3ymz+r3cpj+yDfz3s2dqiy9Ak3RD
         F0VOzxbI3SVTEyYTIoDaMF/ZKpUUsz7e6F29n2Ct7cQ34+vEqOTVXOlPCXW6UpgVbU4H
         wN2bYBJdsiexY0+5YP/JWsoqUNDKx+6ypqxX1gWrjQfMFXYe5WJznO8lsiH9kATKHePq
         R19Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=gHFB0fSemSn6s4jVp/EuBtir/qlPGO8Vq2wg3sOO56WQSEm3m1wgLV+PH+YCzCwe4w
         40XUJ8N3llKffVv3KvwlpEx0PwjFhEP4ejwfKckXHhOrs4COlZYMuCDJVCD700HVWfby
         Wef44AYzEvkwlRh4pmvCSPrnSSb+EuoMS7xAp1fqanhd4vgQUbVFs9DMhr/aX2ve4EZi
         XKK9VbugY1ax8izR6ls1BpqL9Fr7yUJMtkts2rZtlWUvAdEs5tvYZoRcRU9pXB0Y6W76
         RQw5PmUpYS6rrCfKNmEtUvADgYNWM7gb8xCEbJGzjwstKv7ju7GWWD5f6bQVByQhgD9b
         Verg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771999; x=1784376799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
        b=CH6LdsiJvBBVxSHJ75hRogrvDwZauBOCaOb1m83YAByhcNLgeQRVmVP1e2PlpIjyg6
         PjOjx2G8B9KYxYpcwjYrAmUnmkscw7A4IHPqe/yNxdFEhyQNdpzSO/R5dftLE7SurZet
         sVTfdr+DzAIUjUQY6Lb8Va8mqvteMFHc6A/Lo6cGAI94mRUkMM9hOTQf7sGb9aAfxVF3
         ajiKtwDI6UDuswJikaK6/TxKf+Ell678qq0/LykNim9kuHBP/bkhmbVs2bBvYo5Y7WO1
         qvBjZsxaKdd6Yy8Stzkqki1e+b9TA/Rlj79pcQF1XU3FZ06BK/EuEJpwTKzhtpd3Cew+
         XVNQ==
X-Forwarded-Encrypted: i=1; AHgh+RppZNOOEGL4G2uI4XRZ+MOA6tbe7NWGkyevGfUfmL4PzT1w0248XOAy5wtw+XKNc9MJS1xX+Zzbidw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmuQASmOA5e+wkHAv3Pvyn/SBDJ7LfEje1IwvjGFK6dLX8c1Rm
	gU48liKJWjqpbb1WVZNwye9p1nhEoXYzX7teG9M+hWNwjIY+ZJXdGwY1KXQ/8I1Ay7w77M+FqB2
	cJ7qJoqC0nbb2KoidrZBeU4Fe5T4GggY=
X-Gm-Gg: AfdE7cm8LZBQDd9ShhTdt/gX3hneXoRfqlnSCOUd7rMl9XOYXKy8tyULWxC4Kuurlh1
	KxLRvunnTIwn8Q7Xj3Gpn/TBELrOvOj8hktmVTxHATf6wT/80kgSJljPPVF6YPJewGFEOrqnisv
	qTVaSQvYDcTnA7Ipip8vp8Q+wjox1HQTY0ibNOspggm7SnWky/l5F4VG0rgaib5Ne2rUbPz5Cy/
	HbG0wl4Rvlelki8HCz9YRknQR2y1N5MfNAAJ28zK76PQvwHlpcP+SL5XpwiAc+w+A/WhuC0JDOa
	x+GMavzcV4S0igOvSxh9tnEvEUlhIyWLAQLOIolnj4BqzRetlY6/K7q43IyjolHjJV2ax0QYc6L
	rGw7mOG6S5Eq8
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com> <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
	kernel_team@skhynix.com, torvalds@linux-foundation.org, 
	damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
	rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
	daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
	tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
	amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
	linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
	yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
	her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
	gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
	arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
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
	linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
	neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
	dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
