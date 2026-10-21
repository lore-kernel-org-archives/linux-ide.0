Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624985;
	b=av+7bPt5yYnDcGtuZkdroMlHxBjMCBAQeiZjqLF14rdDZIo4mAWrV4mscas4rr0quoYA
	 /6un6cQmrX7WMFBRrLL/We62GohFjFvnJ8k+0/CSdnbUdIJaCcNuw3yX8qGtPhCa9fLqj
	 TTpstHeNJGf/427ijlwXRlSoKhK3GHUPRB8rCYybhsu0WOM6Ft4m52doZ3yHrPlhtHCKG
	 OxE/mt7OQ7VtFkY8EiLqu3T6/zuirwWQmeB5dFcaxY1IT6hhJ63n/T6XzzYlqjtdkXSsR
	 Qb4Pqz6r0Ck5V0tw2/eavvuC8NitX4NY2gNXRgJrsCg+rpFfhvDkyokhtpGMaQqtfzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
	b=xhHhH5B17pcqmorccYsXOm6HCDatm8jbhJuLZyTNntu9JoKc317GSCmGR8nSbEs+e3Fg
	 BOuGieNENOTR2aETbMtpm2PFmL2tothYuAjruloYTxb4tfwzxxJ2GozJJOT4BQoSnyWDp
	 RgEXDPxyOtF2ZY5CN/65JJHarvPpZPtxKOrbDW4YKyGcr9OYkwuD9ObtcbU9xdv+NsVL8
	 +uMcy992GnZgp1NOkikUiFoFc/bv2YOtLh9Wl9j64VYjnLUEzamUXfuAfWkDdky4jyu8d
	 vRQH0+gY1JklJ5aM5GfhgizATfElhKIVEueTfMGjFQgn7Mg+hD/uFxk4xuv1ilO85cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bswUs7Ka;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C676606A31A
	for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 23:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C676606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bswUs7Ka
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843b6f8e2c7so987676a34.1
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 16:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792624984; cv=none;
        d=google.com; s=arc-20260327;
        b=qN7G8JF93MJLKhez29TPdMyTcPnXjivob7Kd64ZPw2TAkR2D2ZOSc9+w/rc5IwwXF7
         EshRPRP12E2l+BiV2j44tPbhCNza3+sbZsPVERnds6Bb2t1hSZpxh4fHQUkyeCBqbUmW
         bkLquRfT+paWWKqRgrt3EBjjJIlPWonfeU9x6TSt2KFSeYXPHjg9jIo0Aq91iAAox+/A
         V7icFLBNyAVGD2y54RPf28E6MzQ2uP94xu97SpyPSC6CkYEp+TItvqn6mB59JWnoZHjW
         LZk2VC7OvFvurjbUvT9DSLusFcUZ76b0urJlAFQxmh9oeIqe1lg2bZf2Qvc/DRAJGNxd
         kb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        fh=/2shEDTZk7Ylwf/KRExmgjEU0YyRAxz2q06LgV7LAkQ=;
        b=axD40Y67rcyFy5EbA7IUVTSIyRT+tJMM2pAKtK6jld5OEXtCN05xscq91pILicZiJi
         P0ei/FYlPiQXHRqOKLNnLYP6Js682KQTGMuQU3p3Asr51FHWagjuNfQC+dS2uVaeEaf9
         qnIWLLKR55MN0uCSg900Pc3LkbvVad59e/SSkHVSGoBvdpX9ZkJxWmyxDaOd53ZlObWw
         dD86x7kXQ0Xe/JBwyNy5gyPUgLauzUw/fxZA+xQ68yjk6fMIaZyYvUbD5g09Sl8tAmKO
         tGElJvfEOuqvF6ycqBJ9+gEI5uHdusszeZwzKhD+FsvKM5B6qkxMPmQjn9Ma8kom6fif
         7SIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792624984; x=1793229784; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        b=bswUs7KaQtVDzZeWu+MWiyJboN7ZZsa0rJoQF+iOWuESEO3rl3FcBVgfPYnaN5YGfF
         EjV/Wtawl0coq/Pg0/i3QcsLxYidjtA1LO/2PqcSVzx53rhAN2x/zpMefR+C6/XCMG4G
         N4DQB9V1zjgirP6GQA4xpSSF7D323JQnLliMu4oWg538jz8kCe4Q0j97wkFF0VGG3IZE
         3lJIg4tcXBe1AepcbuLJY+nmSgyZS2Nue5zWy1LFWsKTNrMjhI/4aumhI9ks1qH7swUy
         ZgbY23Nf4w5fpAPVIe1SutVFZyWYhVHgCFu95eR1kXAvAukvnC/ekv1jGMGoZSsbkbbp
         JNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624984; x=1793229784;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWTtYfkUlWyv+2UbtfIcf2fvliDHTQ0Yu20KCZoeOOA=;
        b=wtIiUwPSfOhn4zaoPv5vswRNp0JAe7F/IpAqWgwoAWQXS6rt07GU1TCySbO7REpBX8
         0MWLJjhlRG2shO5JDHZNLuE8zfWTJFgghLKPGuXcYGs1Ka8+CAtNdw1gAihBmazfMrDY
         I5qz2672WVEfrdDKvOBjA2VL74hr3E1smvW9H533rb5hU8jjfq6VMcEcIakoG+HoTmxD
         KmV9Jn7dbQnmFU2O7GxmqXsGR0KzmOcULr6ogo5oBtn0jNVgbZ33OxqgUGr/6h5ViLUJ
         jHyv/dYSVlViLw7cFbCwZZqWpthGJlhcdiFh1GhQyxOn6LBcZo26sd8R8BHLUqcQ1df3
         lzcA==
X-Forwarded-Encrypted: i=1; AKwUvBzFtiYhsyPNV0PXbzombpaBaCAccjEoOhzRQ3ztT886s6apuQgwQODTTHwjzI8b5TlIii09qVFr7HY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVg4rC3Qa3NAxR46vW4zqkFyQ9z70ufV1OY4OW4b+0R0e1oEgm
	gK2b19IYb4y88inWfKHAtuoXsg7LoIBxDevqzJ0wSU/JDkFKt+Fk30jB5CNYgfBPGlqYH+/e5xe
	mew2VXxtLNwtGcWB2X6pa52tgN3is8xs=
X-Gm-Gg: AYBFou1KqjY7mdkm3xR08NaUaogeJqSoEB06zU9r1YxOWbPMO6tmrCHTuhTHw9fWRRT
	nlt8kxBaIHSkUQHp74Uy86xdPdPIeL6zGE+gTn+oGqfxv5jDSN0iRitD72esuWNgv2+42isx0O2
	EBHvuSNuR/S4tjcMQKXIWmdf3QxtcsmD3PRj4XOi8V4dFf56O+ErvHJ+NZ5mvVx6pe7yFUYDDIW
	9uUeFVomp08ldVEO8Plmyjh5YbRa/lSUMfnrEhyLewCBTjVnWAqdSz458AlbIDLaMMOulQ06MRm
	TbVLRIbkvdkK6nCvXFSD8f3aMdees/DTbSAIQPoR/V3FLJox9dOitOeuSsuTYun5VIDd+GlYZmk
	N9+85WbH2t1Q+A55NCEanlDkokoI/c3C5mSheC0tvnq+pivNDYYY=
X-Received: by 2002:a05:6808:1686:b0:4f3:e98f:fa27 with SMTP id
 5614622812f47-55359701a33mr2377377b6e.16.1792624984257; Wed, 21 Oct 2026
 16:23:04 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
 <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
In-Reply-To: <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
From: Colton Pawielski <colton.pawielski@gmail.com>
Date: Wed, 21 Oct 2026 18:22:52 -0500
X-Gm-Features: AclHuK-WfMKMCFvlwQ93fHdyuPOEefr5IORMgFLa-KSGZEsFjPpcPlLkY8bAXbc
Message-ID: <CAJpaz4ZJ-zgcudHS705HSdcM-wiB5hmX=gg00wqzS18NF6fm1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Wed, 21 Oct 2026 at 05:55, Daniel Palmer <daniel@0x0f.com> wrote:
> There seems to be two issues: One it interrupts for every packet when
> the 8139cp can hold off and not storm the processor, and there is some
> issue with the chip refusing to send small skbs so the network layer
> starts locking up/timing out. I was planning to send fixes this
> weekend but if your fix is one of those, send your version, cc me and
> I'll test it out.

My fix turned out to be neither of those, so please go ahead and send
yours. It's a race in cp_rx_poll(): napi_complete_done() runs before
cp->lock is taken, so an interrupt in between can leave Rx unmasked
while NAPI is still scheduled, and the level-triggered IRQ then storms
until the board hard-hangs. I've sent it to netdev with you on cc:

https://lore.kernel.org/all/20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com/

It should be independent of your two fixes. Please cc me when you
send yours and I'll test them on my boards.

Thanks,
Colton
