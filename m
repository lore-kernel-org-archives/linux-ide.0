Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793191579;
	b=tWmW3Ii71/EHhf0f5lOXhyB8TtAtH9rO8/616B1S88w6JB0mS2i2UYACRtZ3prLGaDuc
	 8bDVO3YD7AVomk6WTeY97mxa9XV06Q5RtaMcv+9+9Gd0VMiQx1WSNgY9Z9vF1YVtITxbE
	 q9W4JwNTAsfjMLD7YEoGYTKOXVw8DhHo0+1otdkGPaKIJGQOkgZEJrmBrWitDjI27r3tR
	 G+hlnjutJV4ukNnaJYA+gJYcQpSlCScC/gRYxkPrF9Jau93FxYxEvc68hZeE9ZAXAGchH
	 SSkGSp+CoIkgIygu0x3TkLG95+Jec+A+XyJi5vf3u4KTO1h3th9Z9Gtdfb1C6CKI9bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191579;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=uJRC1NhQSp7cfC3XbtMGkYR6V4Bu4mBJ6WhIW1YGa+8=;
	b=DcE+frdyMiNcbZ+i0rDU0EUnsTWs9XM2b356vDAJTra/xF6A/liF1B2kC9FC+y20vnO+
	 gB8qtzeWAmF5ga+Ks8Wev04OjL703MReFZMc8lm/pHMauFuzgkW6XBp1Dc5WN/BOTD3k/
	 /lpDyb1BpSzycPfW/xZRBmjuwIX6WOm3H65Zg3q2d9wtpRnjmQrgCNsL2ZYWpliSh+ElU
	 Sv7urxQQAtaKthi2ZnFY14dU3GgWKiYNNZVb5Bzt+dnsR8p+7bm2nO1q5VIZ+P4TbBGrN
	 YjoRs4yblBo7pkbbsbpMDjxEgaP+cuPBGCDvrcxEHLlgzxZn2+0h7pKQi2mRS3SgZAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQR3uHdQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dwUbXn46;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E6606A31E
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 12:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQR3uHdQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dwUbXn46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793191578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJRC1NhQSp7cfC3XbtMGkYR6V4Bu4mBJ6WhIW1YGa+8=;
	b=jQR3uHdQRlqgkm4Gw7mbrak/rkTyBmQgiEL+E8R3HLO/p3JlWfPtkXO+Npgeta3etjYCwJ
	2Tmmw41z3+x4QtNhmU3kbtXzAhKXAP31wChIF0RnapaUMJxI9ayrZbwsyByF5osvKC8UMT
	yWbDdVhK7PK+KcqqPmXpejCqK+XiA3I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-wiKH9qgpOBif-SNr-QVNUA-1; Wed, 28 Oct 2026 08:46:16 -0400
X-MC-Unique: wiKH9qgpOBif-SNr-QVNUA-1
X-Mimecast-MFC-AGG-ID: wiKH9qgpOBif-SNr-QVNUA_1793191576
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337b591609so14920581cf.3
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 05:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793191576; cv=none;
        d=google.com; s=arc-20260327;
        b=ny9yebWe6Dns75jkfMCR+nPPZxJq6E+21aodxqGYMdyLxhjcctll8WVJ4z/jJqqkmh
         NLSd5QV4ZN/yf2yhMpD8+iJ4w2X3Ng+XPjTE6q0LA/+ZUaS3TwWHpz9TEiXRZQPWZ2zc
         R5DMugiAtmdlSh9NM1/XCX/TMhUfFFIbq8PP7OBaeH+Yt9lcG7erRa04kVbxZyJO4IWs
         CI3ysyP4rJynKIqEDWgvRWXRmIxU1ihh0LjY/fTGeCM24jukAwHEKKrajWAn0dRJlPvh
         yamxQqS/+ow8piKz0gqV1EWvid8MO/G1mb6RuovJKa/xsejbQ8h2J62KQItrcPyMsEik
         k74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJRC1NhQSp7cfC3XbtMGkYR6V4Bu4mBJ6WhIW1YGa+8=;
        fh=DoZbfTXRxEoKQZECct6DJuTN/T/ujpOA3a21b1DQhEQ=;
        b=hdDTscgoYIiiBEd2Yd3dz8CUEBQ/rTc+hYIULqRihIP/BhCIpyCyl1ZQfwaKYliG5k
         jmrSGVlTkWerPmT694wrkjEkUfCj4m70lnpAqlqgK3AweUaoJWuq8sHpPgMeoehbXCKf
         69t41aXHDeb3BtfD3AaVQsDDJXEMROl3qpqhgOT2h8QsF+tNSw1SEBN4K1yeV/c/5/98
         Fr6WFN+NrTEkBHPkn1nwGlOTjb1sBtG6hnM5kSZ18R1pJzUnaZgCOgLzWI86U7hqoCTT
         7pBFz9zzHrQVvpn0FxuozhEg5bQ7eW+gfcras7t0pQnGLU7gzFQWKissMUQcS+XgToyB
         Zlhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793191576; x=1793796376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJRC1NhQSp7cfC3XbtMGkYR6V4Bu4mBJ6WhIW1YGa+8=;
        b=dwUbXn46Wh2SkLTTVjI+ys3zvcfbsUS4ghvpyBbJMn1R1WHaYlnkKN6zhxDaq1QnoF
         kmBmiwVnITlk0qWxR1gD3NExCnKbsjoopDULQdyrMfgOPhr7pxWhpkJrXaCNlruR9/K9
         +KTsv+03CGf46RC3uq3OiHwb4cnuVs20Dwu9rkdrTmE07urv9bmb5guEcW8BZsXyruui
         o+I3RUgs+9EQX41WDtRXKc54bsyqomh+1E9F44qaKTeKvzsIcIzKfsqiZ5/08At6j5BV
         zIxrj6UpOV+Eejopc+z7Xb2hf2Cyq/OoG8fBmqbvVD7rcdYAEYCC6vwoGCXwf8LQWPO5
         qMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191576; x=1793796376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJRC1NhQSp7cfC3XbtMGkYR6V4Bu4mBJ6WhIW1YGa+8=;
        b=VXt/iEKVpC87ON1/eBlFJYj1gQunJvotjJSc2poRtVsRjkDC2Bts42bC+XC/Bh2tB/
         dDDYNq+NoYS9lojLhBJrEXhV4ePL6lJRTGXqTNmmFs5fYSJ67wddMm54Mg2FsoiFcQyD
         J/iH0NnejJLWAiIzmK8Wk1Hjidy2L3V59yL5Y71hcDuOi5Hsn1KlS+GTNiVuZyIPmKhm
         S/+CHcoUDE8owu+ayh36zGXPUUOXsXhdKnEInp2/MPjWVjWCQbSou3u4iKkUXJ0OR7qw
         jyMz7XC0ot/JKcSdPK7x0tXxg3uFuoQU2mqRu/LXIYIOKYZRBbpHpckH+YHoy1BgAoPF
         J4Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwWu/aA82v0OuQUPclb2YsSV1B3p0BwULCOo6K2aM9190qRK/jo8HbuktwemLQi8TSzwphwWmcN4EM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0P/Qas3Hjl/8je44+hc2eSYZiqYhs8uh1O63zlijEqgCHovpW
	RH701WbXsRWbRtOvmXAblJpPNN8gXff85CDQaBmdh/Kv982Ed/0Wl5cCXaE9hTpETJ/hXBvofR8
	Ha41v2IJQkOJMzhTjsJa3myBG6UYMi2oSo474hgpXkdPvA1ih8N0id/LUogx1UcFBQ9qEUsQLMS
	HbapffQD9hXmxAxm/9FrSSAv7iti1+av6smLLsM4ztw8Br
X-Gm-Gg: AYBFou1rgoD9yV1vktlyfFlcP+F3xgnoTbEMYEY3xY3ku7fTcosWISHoZvaOOs8j161
	6pGQQHdSsQspQw029PF2CxcgCKzerq2/lgniec8Ns6nM8gXLLQsK3t3A84YgLFAi5xnsmTxh5HF
	HziIuA+mDyOmB/pQSYghQTvJE4R3bP1rSLriX8SrnxZ91ddzBr98EOKa4KHHwQVsgCYdVM50m/Y
	YWSqugnGeTFwpjUBA==
X-Received: by 2002:a05:620a:6493:b0:93a:2611:270f with SMTP id af79cd13be357-94408a728afmr267714685a.13.1793191575947;
        Wed, 28 Oct 2026 05:46:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:93a:2611:270f with SMTP id
 af79cd13be357-94408a728afmr267711285a.13.1793191575412; Wed, 28 Oct 2026
 05:46:15 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHSMvrH4YRmNaw3+FnKv9-Dwf9PS6R_kNMPGEoOe2=pKwewgBA@mail.gmail.com>
 <CAHSMvrFn+gvgsfM9WPJgPCWFUy2cjR+A7-fqFtDJc=JOD9L7Jg@mail.gmail.com>
 <at9wk18uhg-H18ge@ryzen> <CAHSMvrHur59qCpyVk_qd_epVGrntWMeKhogKtutTpJaA_V3VLg@mail.gmail.com>
 <at-CrMH85_pI7QYn@ryzen> <CAHSMvrFSfE9NLo8BfCXq3C9EycosnCPhJF5dxeM3KSsu2uqt8g@mail.gmail.com>
In-Reply-To: <CAHSMvrFSfE9NLo8BfCXq3C9EycosnCPhJF5dxeM3KSsu2uqt8g@mail.gmail.com>
From: Thierry Vignaud <tvignaud@redhat.com>
Date: Wed, 28 Oct 2026 13:46:03 +0100
X-Gm-Features: AclHuK8XKMxnafbO29E3hPVKrVRVh4WsIzqFNRnTaimdTb-6W5vJ5Fjt6Ffqt-k
Message-ID: <CAHSMvrE0G4hkMarBCegf=u4k5aoJQCENwJJWZBTwmhJZmrc5+A@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD 916a
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:06=E2=80=AFPM Thierry Vignaud <tvignaud@redhat.co=
m> wrote:
>
> On Mon, Oct 26, 2026 at 5:41=E2=80=AFPM Niklas Cassel <cassel@kernel.org>=
 wrote:
> >
> > > This patch survived heavy I/O such as compiling a kernel multiple tim=
es.
> > > However I hit the NCQ issue after trying suspending (which I remember=
 was
> > > an issue too).
> > > On resume, I hit
> > > I've attached dmesg to https://bugzilla.kernel.org/show_bug.cgi?id=3D=
222187
> > > See https://bugzilla.kernel.org/attachment.cgi?id=3D311297
> > >
> > > Note the following (one hour before suspending?):
> > > [12014.334779] sd 0:0:0:0: [sda] tag#25 timing out command, waited 7s
> > > [12612.911419] sd 0:0:0:0: [sda] tag#16 timing out command, waited 7s
> > >
> > > Then when suspending/resuming:
> > >
> > > [16199.520287] PM: suspend entry (deep)
> > > [16199.525373] Filesystems sync: 0.005 seconds
> > > [16199.532331] Freezing user space processes
> > > [16199.533685] Freezing user space processes completed (elapsed 0.001
> > > seconds)
> > > [16199.533689] OOM killer disabled.
> > > [16199.533690] Freezing remaining freezable tasks
> > > [16199.534837] Freezing remaining freezable tasks completed (elapsed =
0.001
> > > seconds)
> > > [16199.534881] printk: Suspending console(s) (use no_console_suspend =
to
> > > debug)
> > > [16199.553767] e1000e: EEE TX LPI TIMER: 00000011
> > > [16199.578187] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
> > > [16199.578249] serial 00:02: disabled
> > > [16199.578307] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
> > > [16199.578315] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > > [16199.579852] ata1.00: Entering standby power mode
> > > =E2=80=A6
> > > Resuming:
> > > [16200.017987] PM: suspend exit
> > > [16200.101972] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > > [16200.101995] ata6: SATA link down (SStatus 4 SControl 300)
> > > [16200.102060] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > [16200.102076] ata3: SATA link down (SStatus 4 SControl 300)
> > > [16200.102590] sd 0:0:0:0: [sda] Starting disk
> > > [16200.103016] ata1.00: configured for UDMA/133
> > > [16200.118929] ata2.00: configured for UDMA/100
> > > [16200.240742] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b62=
7f04:
> > > bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> > > [16203.543281] e1000e 0000:00:1f.6 eno2: NIC Link is Up 1000 Mbps Ful=
l
> > > Duplex, Flow Control: Rx/Tx
> > > [16205.102517] ata4: link is slow to respond, please be patient (read=
y=3D0)
> > > [16205.103508] ata5: link is slow to respond, please be patient (read=
y=3D0)
> > > [16215.160283] ata5: link is slow to respond, please be patient (read=
y=3D0)
> > > [16215.160305] ata4: link is slow to respond, please be patient (read=
y=3D0)
> > > [16217.967230] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > > [16218.011741] sd 4:0:0:0: [sdc] Starting disk
> > > [16218.045035] ata5.00: configured for UDMA/133
> > > [16218.274151] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > > [16218.310512] sd 3:0:0:0: [sdb] Starting disk
> > > [16218.343817] ata4.00: configured for UDMA/133
> > > [16306.847985] ata1.00: exception Emask 0x0 SAct 0x7fc00000 SErr 0x0 =
action
> > > 0x6 frozen
> > > [16306.848009] ata1.00: failed command: WRITE FPDMA QUEUED
> > > [16306.848015] ata1.00: cmd 61/40:b0:18:70:44/05:00:39:00:00/40 tag 2=
2 ncq
> > > dma 688128 out
> > >                         res 40/00:01:00:00:00/00:00:00:00:00/40 Emask=
 0x4
> > > (timeout)
> > > [16306.848034] ata1.00: status: { DRDY }
> > >
> > > ata1 being the SSD:
> > > [    0.654757] ata1.00: ATA-11: PNY 1TB SATA SSD, H220916a, max UDMA/=
133
> > >
> > > Any idea what I could try  (besides disabling suspending)?
> >
> > I'm guessing it is a drive firmware bug.
> >
> > Have you checked if there is any more recent firmware version for your =
SSD?
>
> Sadly this vendor doesn't appear to offer any firmware update.

I've send another version of the patch, using git send-email this time.
Sadly, I'd to add NONCQ and reduce the speed else I was still able to
reproduce the issue.
At least SSD is functionnal, though with reduced performances.

