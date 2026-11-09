Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216236;
	b=byLGf7s6Rrj0HqfrECq+1zbcPig3nDxD+lC4Ej0uvjfcMU2rXNq+VGOA93NHcHX9Ua1j
	 zizDZYBAEZN3niyiN+gDv81HG77d+s7IlnkIKhc1Ra8jneia9lKNpRQWnWg76wm/0qoeL
	 QhvIE3eaPtCO0qmnZhrY8d0Szy48ENP1ws/G3bRY4/GyjuD+2CD4vnWcBaK1cR8cLSHed
	 5JgOHXVjqZTF/983C3YNl3AxAr8UyG+Mh1xWlz6lMSAiQwKhcJb+CpP1qWpQ4AQ4e9U0t
	 0+niviibRfjK1VvZX4MzOTL+lLft8BlbIqmQFFVOKCrbnGoSBv6nupWkehIoZb5532w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OTvFMNQV84+PGGt/swa2eJXI4g4fgVWhsgHMQzth6gY=;
	b=IWZHYAyjDV3nyt8EM02TAKJpBALTbYSuwj/lkwiq/3c9Qj8/AwL7+HjdHzQ6tRvhMkF3
	 xLg4m/nRlCW3NvJNQhkoINL9F6VLn2FufAbAc/HkLgouddQrPI7fA92nlbO6cY3DdciPX
	 P0Nxt/2LZHrEMVXOY/PhL4R0C85oJhMrX0MYIKr3GU7pU943nMfOgIk98UMSdWda1hVMo
	 NAiiIMLWpi1PpTn22hRvVcieyAA0KF21znspwTLWhn62fUK6mJLlEjsWvxTuspwCI0L7v
	 jQFEXZm0aJrJWWB7nT6iIT4XoN0wsYVIE89HoY64dzF4xMyj4AD8+IE6AM/s0bbP8rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALZ6ESuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994C606A32A
	for <linux-ide@vger.kernel.org>; Mon,  9 Nov 2026 09:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2994C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALZ6ESuA
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso999067eec.0
        for <linux-ide@vger.kernel.org>; Mon, 09 Nov 2026 01:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794216235; cv=none;
        d=google.com; s=arc-20260327;
        b=TJ0nFwUvBTyto7muSjmSwqOrM+/ohK6VHccnvn7x67k97tdMfmWdtGXXjVrIjhtkLg
         85sm7/iThIHHc5mSHcrIW7mtZ4tC3x7FOzNILeRjVcuKbgHHZw0vOTZQyJLPHuyElt4E
         s4ex+4AWsurVlcpbnoIzbYVXAxckDzv097QG0yQWuwEyqmtPRkDOlwMcWwHs1dUG637f
         QEErmu2dMniQRAMhG9oi6Zk0685DU87JUsxe1wmblY3SpRcnslpikFnVdalWg+aJEU8e
         ThbCx/Gfy96QJ5dMpPJCQDJ47qv/RZjgeP1f5gkmsC1+oacAsrG7pD1Ay/z7gEIiX8aa
         S+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OTvFMNQV84+PGGt/swa2eJXI4g4fgVWhsgHMQzth6gY=;
        fh=0smr3XV2mJX3Puo2YfxuPggct0nKzvjxBSrwAZZncVk=;
        b=Yj8XUe/oaTdLDrqAWQD5rw9AE0x+i2ChepJAjP9dp97AByQIUQpyKeQ/nVuoDNNbxn
         ewH6WM/F+bZB3l+RHs4PJRwpHqtfqg6tQEyF5B4owYmwLS28jY/DgZEGbU5jFwPcEDnz
         BsZ38K18qN+4ex4yPXM7p9MTvF6e7AKo+w4BKLcoUozcAS1yS4r/8PvZBXq+/E6AZdzL
         nJyVRm1TEOB1BWEmbLJz+0OK4gNibk9SByyXu7R5Ho8V2tLJ+2sD44O1AfFxaOnQvDux
         tbQNSfeduSqDwmXSPQLFINn4gM7ix3tXf2rPPZACIwwvffnNzlb0S/gMnyKi8hf6nW0w
         ElPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794216235; x=1794821035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTvFMNQV84+PGGt/swa2eJXI4g4fgVWhsgHMQzth6gY=;
        b=ALZ6ESuAKdAUvdhjOeWtpkAVCCr+q3jUU80hzdARnYtwIU+vhvHU84OsTV7eYUzZPm
         GII2UFlxmxLVEb3E/kuZg5+U+iih6zY8ADsdWSNCxrqsEsP679c2t8kjgSCoBwil6zsa
         C1ak+j7n+9H0cJ0nE70hyQZpcbGcXJBtmHi2f2SqUWSWN4VIZWo/AyXzQyNMhICDw9Ji
         +QGE0e4yXE82GxXw61auP0GJMcuH7XmCAp9gVvik0Ax4UYhUMvHlHqypJVcSOVJGH5uJ
         683xr5wuAf6IjEndJUno8FI+ly4hqcnB8T2lnzSwLgMB+6G31+9XUcPtAuDUVCZQF6/O
         Ctaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216235; x=1794821035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTvFMNQV84+PGGt/swa2eJXI4g4fgVWhsgHMQzth6gY=;
        b=WZCwSiwQoSqsrB3TOXpKVzZJY+3Yr5HdQ3cmCQ6VqXAS1y5mBoCq25+xI7377+5fyw
         G4sHsdga8Kl6Bvy967KfTgglJCvsnJ6wdPVz7GJ6tfEP+ZzLVSc+/iYmHs274YxwzBq9
         kClbO3N5D45t7tfq94dD24OGRAJG4L6EwpoAWsOyIP8V15XRAhBnn4LegSGlwBwSdiYo
         +eQud1eS6p0umzrJ/paGY6IJUE14J/uemcmWHx40eUTQaAw+f3Nc1bQOtQ15EVwhB00r
         JP7beeBX7VPaHU1KatPK1nBw2qLTASKpeHXUtHdntKL2BVYDlY3fHKNwoOOdfJS21xmQ
         plAA==
X-Forwarded-Encrypted: i=1; AL+hErHFBkml+tQ5P4/d/2V/cqF7v7EwtIOxNO5VYng5CW5F9ZawJMynYirqO83yItPFHXq0jVgwyI6XrYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WsadDErgYPSxbzwHxLgqMSNhK5+Aj29zo5A5WGUVcd3wxBMmz
	pdVEsUFZeTvEN/C7vrrYOp2uvUZ7Mjgz+SoSvoydNMCFFYsdA+v42Ky33zO5yqCLat9bcOSlrm4
	4m618X4BXl1DEEmk8HAPALbsIfBEUaA2w6CFoGHk=
X-Gm-Gg: AYBFou2G57g9aCOfxVLQWXpnkqe6GgaAQwOryITqQkg0j+J0h8DarVRizX3mI4UQjOY
	71IhIpPN9hEzHsLYVkK6ZHqkTpcbwmoKXzHi3pjJLmCd+vL3kJJQNEdbPXO7IiBSklzRGGGTi/f
	0G0TRNMYpxMvs6j1s9pNPrmCQN4+cvQch+tjoFIjNLsR1O9OKKCHWAyqmpjZ0HLcr9aTK3i2QHq
	17xyz2Qlfn2if9ChI7PyluFW9DWcVbUKbaDVoVK/YHY/lL+H6wB+kU1cdZ13MdMzuhX9+Zt/gCu
	NIly1zS+infYTLvg+bkW53+G77rwCShypsfeBfnigbci4ws0I8vY8kVTJAQ1NXfGZw9FHYK2j5m
	7vXsQVPij2BZufCFCv1N/dZqJDWQsv5gMFG9+Fdt6dX0HJb00MUvcXhjJ0E2kYmAy8OQEbA==
X-Received: by 2002:a05:7300:d0a7:b0:36a:532e:4abe with SMTP id
 5a478bee46e88-372564223e4mr6572332eec.35.1794216235144; Mon, 09 Nov 2026
 01:23:55 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109060709.1231946-1-hj351016@gmail.com> <avGQQqWBRC-iWOGt@ryzen>
In-Reply-To: <avGQQqWBRC-iWOGt@ryzen>
From: khj <hj351016@gmail.com>
Date: Mon, 9 Nov 2026 18:23:43 +0900
X-Gm-Features: AclHuK-mhySit246Ims30yCzO3TUvyXN2N_3k23h-VBf9P1numkz6sZuZNzImrM
Message-ID: <CAGr5VtOT4V3A4AYzVy6gkXdurYMd4kE5vzwz0SEuY=Z-eRmhug@mail.gmail.com>
Subject: Re: [PATCH v2] ata: libahci: delete the SW activity blink timer on
 port stop
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I missed the changelog on v2 =E2=80=94 resent it just now with the
"Changes in v2" list below the ---.
Thanks! :)

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:20, N=
iklas Cassel <cassel@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hello Hyunjung,
>
> On Mon, Nov 09, 2026 at 03:07:09PM +0900, hyunjungg wrote:
> > From: Hyunjung Ko <hj351016@gmail.com>
> >
> > The software activity LED support arms a per-EM-port timer (emp->timer,
> > ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
> > callback re-arms itself while the LED is blinking. emp->timer lives in
> > struct ahci_em_priv inside the port's ahci_port_priv, which is allocate=
d
> > with devm_kzalloc() and freed when the port is torn down.
> >
> > ahci_port_stop() never deletes this timer, so when the SW activity LED =
is
> > in use and the port is stopped (driver unbind / module unload) while th=
e
> > blink timer is pending, ahci_sw_activity_blink() runs after
> > ahci_port_priv has been freed and dereferences the freed ahci_em_priv
> > (use-after-free).
> >
> > Shut the timer down in ahci_port_stop() before the port private data is
> > released; timer_shutdown_sync() also stops the self re-arm. The timers =
are
> > only set up (ahci_init_sw_activity()) when ATA_FLAG_SW_ACTIVITY is set,=
 so
> > gate on that flag and skip slots whose timer was never initialised --
> > timer_shutdown_sync() on an uninitialised timer trips the debug-object =
and
> > lockdep checks. Sweep all EM_MAX_SLOTS em_priv slots rather than the
> > current links, so a detached Port Multiplier's fan-out timer is not mis=
sed.
> >
> > Not tested on real hardware (needs an AHCI controller with SGPIO
> > enclosure management and the software activity LED enabled).
> >
> > Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> > ---
>
> Where is the changelog?
>
>
> Kind regards,
> Niklas
