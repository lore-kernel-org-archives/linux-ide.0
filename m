Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793041613;
	b=XOQYt6I5Hdk55OAu1od3bUBKJEW3jm0b9s7N412Q8JMVVBaAJu+VhLU4TOMufRVus/yW
	 3WJxoy8IK8utD12xoYbQoCoXIU90AIlp0oaI0wxvVQjFVExb59OcZswxzlgy80TybTMpU
	 XLd3vRmg7sus+qfMOyTfDAxlunmALA7dCwvW4KVFRX+skz0JvzzoE69wEVVJkyCw+Taq0
	 GcF9nGfrhwNwAZp+ssUKF2s9JRDMYQmAdPHwfPBamlIVsuFl9T37clpMxuB6cBIWebDOb
	 QMU8h5Mvwfp5mcgN3JLRMRloMTK6xmhVwrP0ECjmTLpqHm+P2/nKzE1bYLxLi8IFHiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041613;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=5gkih5/wx3vmYI40ak3/gwEdZY900NhtCv0bh3FcnbY=;
	b=et0dbvqpmgcqRUzHMUIndsBO+rEWxeuiFGZROOF2u872P5iBGj0BkGOBnaXAq4sj7X7s
	 wBAZqYa87wQLMUqlAML2zuhQo3lqmKPXZN6cY7V6QIHs18N47x9fjUJXHn2Fxr10xlZO9
	 BhKkv5LS4OBRWGHK0z9JvHej41RBHuwEb1vVHaIJuF7InkL2Z4/NNqsRGvc7rlz4Ug8ig
	 LO1j30Gy17Ci6E6QBdOaT+vSZgC9kkCbOQwrxN71abCeN+4Zf2mU1YbrjPtvvkkDLkCUq
	 0TK81Uu0bAi2+RRckS54LrQh1n7zd3NrUV4ucjkGJtgmAq0+h4BECKuXswfkCagfzHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XqdOnRiu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bP6EFq8q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00762606A31F
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 19:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00762606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XqdOnRiu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bP6EFq8q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793041611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gkih5/wx3vmYI40ak3/gwEdZY900NhtCv0bh3FcnbY=;
	b=XqdOnRiuXdJ2HHDylesoLIC+Vjy1Vpp1kv3hBDN8s0mWsSUAzvHgndhc+ybe5X/O5RCfOQ
	5wuzN7w2XIdt35aJGApQ9cU8tVlQEJ3ul8o5maVbQnyHfPC4fVLtgKJI/YuPpfSbxwf9MU
	X/9Zpsb8O9tEVW5QTa+f/q44CT5mI28=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-rM5R9sg3Oy2YJ_93eI09ZA-1; Mon, 26 Oct 2026 15:06:50 -0400
X-MC-Unique: rM5R9sg3Oy2YJ_93eI09ZA-1
X-Mimecast-MFC-AGG-ID: rM5R9sg3Oy2YJ_93eI09ZA_1793041610
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso707515785a.0
        for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 12:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793041610; cv=none;
        d=google.com; s=arc-20260327;
        b=VTnRdpkWso3Tu4glP3NPp79s/aovYbuy1k5nvBNSBzg7hxUB7bqPkXEgLwS9lL9Enn
         qq0yG60A2jHyYCRVwxYZMBR7hDlPp81zTWKXgR9zO5dphb2Yy5WpgEfy2oJulFY899qt
         5ukurnF6MWMIo+ypdEjTTa0HUmIxShUkMnmld+npfsOYyZLokul3wx+gcuxthqk3V8WU
         /gGVND+8037x/UPmhIK+B+pLtSdylt/Adkn14qlrGYZPRHAhH0k9o3SMZQniiRc00Z/s
         ZysnxK41P7LaggLVQtG/feGSIEfZBVrwbiMTr6soAx2C5knNYk5RiwTlVoP7OYMBQ4uI
         Y68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5gkih5/wx3vmYI40ak3/gwEdZY900NhtCv0bh3FcnbY=;
        fh=BhKX8lMe7ozHrnbBGI1KoAeHqFc3M23pReZT3Yb8PGY=;
        b=nG7YRDSdB2ZIshYIYZPZfRQuR+XbDGlzWV5am0sfD+frpfnpLhv+h0i6jy5DsMPPCL
         YYvOmr0AWeGh9aEefbzB+LSDtqPip+ts7ltfAgVpQ2ih9DMki311AQtfq7vP19sJLo3l
         Y53ZZRPN+o8wy4+dJEmxAsg0wNsPa/+c2PDu6kdQ1LEyRUV/OyXKs+kT7fHZr/QkF4dE
         lbXNOBp6njVKYAEa2/PUsK8oIBHqW9uGHzjTvpAMdaAcc6QKCT1nYpa01ypDO1J0Ik0/
         j/JrFAolP42c4Tade/2Pe2OM2P5kIMvuX1ugXMKsonP2ASzZ9DpQQmIZo0wyI3GnR4/I
         Uv+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793041610; x=1793646410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5gkih5/wx3vmYI40ak3/gwEdZY900NhtCv0bh3FcnbY=;
        b=bP6EFq8qgYdrsA3ZL95Bf1KROGGD+OFjQYirUQrIhlMPPnq166o3/uI0Oh2JYm6Yil
         lSkJqcMQbzS+kR5k+pxCq4Qk8S3wgUZ3aT39IfgyoeYP5djH/wwlCV8Yqr224UUD3IQB
         DVzg5U88esyOup+OLupcnIClctTeueYkvpTr9uuYg2uBBTDE1Xx7amjquMpPo4TELuKT
         lmOoX31pYczQa23BRJacNui0cebtMiH4ncUk/x9/7e8wdQ4jSaiEw/P2REEbe5G8iPcD
         u9/8z8a4IO9J7QfPQeJAU6y0GJ0Lx2cF4te8GUc6Yp/NfB8Dv9FGt77z9kIsfO8tKfas
         J5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041610; x=1793646410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gkih5/wx3vmYI40ak3/gwEdZY900NhtCv0bh3FcnbY=;
        b=z6ldQHLoIEvajZZhZFbwUkjrHTI6uIi0bC3EDDtVAI2uEcvkD3gAr6mVw6k6caLPKO
         JvJaWQETZdEqOgvMHWdYmZzT7o3CItEtC+lUUxyH/8k8rPmT6JrNwX0Q2h4AG/A+j+OH
         TwQluw7AgqyJEHS0RJNChCJl678hD+fkeq9N/92GOnXB+sVuBxJxm3QtMEBW+mg4RNqI
         LrneD81GOhMn4+WaqfVlJGlTvMUzd0Uj+ob2tq1D2zqKwvI60gSldea7PLoxUSOXwRRQ
         JaVCjjho/Lg+huOk2GxEERLWirW0R4CbnDDiZDcMm5wbZU+AOr1qX0QXXLJJjEVfhvqL
         jhYg==
X-Forwarded-Encrypted: i=1; AKwUvBzen4ojTkJIJHe6qtQ2Ons5ob5GGUOD1+2CWBnyX0unoC58X7GxoI/gKRHyj2vG8J/Yz/i4tu9bxnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYItO6sLa20BDWU5mD/3jrNe+kcXU+R7SKtig7BYtWOaK8Ug/InD
	/n8tZHW3LgkenhfO+TttOQQP77qi+ueJ+xIzXRS2grJmCFEhjJdknLENTWoXG5h7jSewXRoqR8H
	izE8BM+eFft+tSvkjt3XoUSze10QRndo7nloV0YGrhRAiC5J9HqMLzgBy9weV+zweokYN3bOkoz
	RYPQSiQaHt+S6Fgf5PWV2+ajJ6BSXMNXSnUpEdf2OebmBI
X-Gm-Gg: AYBFou3EoyaSYcd72+CvPDZXU9F/LdZ93evpDqHujj4UOEyY+/ceQzILLvC6OIxsFCY
	KTDtpaU7esYoDMEf66SlOiEBAQxlcT/nznr8SriCLhM6vGc9RUKm1whrcCtMOvHKX/1UM8zSqXx
	VtzjlCcUMS0NVS4LDb7aMqZtV20rCyZn1PizkxtE0bgfm31g6G8aUNGq1Syx9OipGj6WkivpP/t
	ff65Q7I3nR1QZbb8Q==
X-Received: by 2002:a05:620a:17a0:b0:93f:3646:7a57 with SMTP id af79cd13be357-940ef9844b3mr1191490085a.57.1793041609775;
        Mon, 26 Oct 2026 12:06:49 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93f:3646:7a57 with SMTP id
 af79cd13be357-940ef9844b3mr1191485185a.57.1793041609242; Mon, 26 Oct 2026
 12:06:49 -0700 (PDT)
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
 <at-CrMH85_pI7QYn@ryzen>
In-Reply-To: <at-CrMH85_pI7QYn@ryzen>
From: Thierry Vignaud <tvignaud@redhat.com>
Date: Mon, 26 Oct 2026 20:06:38 +0100
X-Gm-Features: AclHuK-wB_ryRKZBnL2ko4KVJjqB31xBm84GCCJeHRUx_v4APc3-4y2c5RHBnUU
Message-ID: <CAHSMvrFSfE9NLo8BfCXq3C9EycosnCPhJF5dxeM3KSsu2uqt8g@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD 916a
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:41=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> > This patch survived heavy I/O such as compiling a kernel multiple times=
.
> > However I hit the NCQ issue after trying suspending (which I remember w=
as
> > an issue too).
> > On resume, I hit
> > I've attached dmesg to https://bugzilla.kernel.org/show_bug.cgi?id=3D22=
2187
> > See https://bugzilla.kernel.org/attachment.cgi?id=3D311297
> >
> > Note the following (one hour before suspending?):
> > [12014.334779] sd 0:0:0:0: [sda] tag#25 timing out command, waited 7s
> > [12612.911419] sd 0:0:0:0: [sda] tag#16 timing out command, waited 7s
> >
> > Then when suspending/resuming:
> >
> > [16199.520287] PM: suspend entry (deep)
> > [16199.525373] Filesystems sync: 0.005 seconds
> > [16199.532331] Freezing user space processes
> > [16199.533685] Freezing user space processes completed (elapsed 0.001
> > seconds)
> > [16199.533689] OOM killer disabled.
> > [16199.533690] Freezing remaining freezable tasks
> > [16199.534837] Freezing remaining freezable tasks completed (elapsed 0.=
001
> > seconds)
> > [16199.534881] printk: Suspending console(s) (use no_console_suspend to
> > debug)
> > [16199.553767] e1000e: EEE TX LPI TIMER: 00000011
> > [16199.578187] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
> > [16199.578249] serial 00:02: disabled
> > [16199.578307] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
> > [16199.578315] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > [16199.579852] ata1.00: Entering standby power mode
> > =E2=80=A6
> > Resuming:
> > [16200.017987] PM: suspend exit
> > [16200.101972] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [16200.101995] ata6: SATA link down (SStatus 4 SControl 300)
> > [16200.102060] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [16200.102076] ata3: SATA link down (SStatus 4 SControl 300)
> > [16200.102590] sd 0:0:0:0: [sda] Starting disk
> > [16200.103016] ata1.00: configured for UDMA/133
> > [16200.118929] ata2.00: configured for UDMA/100
> > [16200.240742] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f=
04:
> > bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> > [16203.543281] e1000e 0000:00:1f.6 eno2: NIC Link is Up 1000 Mbps Full
> > Duplex, Flow Control: Rx/Tx
> > [16205.102517] ata4: link is slow to respond, please be patient (ready=
=3D0)
> > [16205.103508] ata5: link is slow to respond, please be patient (ready=
=3D0)
> > [16215.160283] ata5: link is slow to respond, please be patient (ready=
=3D0)
> > [16215.160305] ata4: link is slow to respond, please be patient (ready=
=3D0)
> > [16217.967230] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [16218.011741] sd 4:0:0:0: [sdc] Starting disk
> > [16218.045035] ata5.00: configured for UDMA/133
> > [16218.274151] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [16218.310512] sd 3:0:0:0: [sdb] Starting disk
> > [16218.343817] ata4.00: configured for UDMA/133
> > [16306.847985] ata1.00: exception Emask 0x0 SAct 0x7fc00000 SErr 0x0 ac=
tion
> > 0x6 frozen
> > [16306.848009] ata1.00: failed command: WRITE FPDMA QUEUED
> > [16306.848015] ata1.00: cmd 61/40:b0:18:70:44/05:00:39:00:00/40 tag 22 =
ncq
> > dma 688128 out
> >                         res 40/00:01:00:00:00/00:00:00:00:00/40 Emask 0=
x4
> > (timeout)
> > [16306.848034] ata1.00: status: { DRDY }
> >
> > ata1 being the SSD:
> > [    0.654757] ata1.00: ATA-11: PNY 1TB SATA SSD, H220916a, max UDMA/13=
3
> >
> > Any idea what I could try  (besides disabling suspending)?
>
> I'm guessing it is a drive firmware bug.
>
> Have you checked if there is any more recent firmware version for your SS=
D?

Sadly this vendor doesn't appear to offer any firmware update.

