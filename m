Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792580159;
	b=RfzUUbx6Z8etA/d9eaLn2RpCwCIjy2RrznjqqF3Ptj6huCQwk83bVmvQtoPmrDE/uRZT
	 ISUUZzfYTfXZwkAWSUVbB23kV8D7u6mty2WsbjZjnKZlJJMc+0mK0PS6/n0LRzGKR5gzy
	 1WVCzif6G52sBMVwH/DXplSy16dQojlGdoGFnZxFR1e7OpOYsDmRtxBQTzN43ut6aAPbm
	 I5grQQATh4+6CY4KUkWPZaHYdQqkp7eCi4njxoPwnFXVqaAiI3JM+kL0xSp36V0XdeueO
	 h2sTKCWsyAwh+Y1qAJaYs90Qe41rF+jXofEwewFtQMNesOCk2kq7Vgak5M0QUmBwVpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
	b=j/KMWALgxlMWLdMezkkD/hAr9dn+N4lw1aaNX55D+5vSPguv5igbyJ2/SEYPDE2I67Ub
	 vGtEJ232ELEtGvlmigVVh2YpRMJwshOjNDp4xxEorl1iOf4JpR2X8spLfx3AsYuE7LM10
	 7BriqnFwzOOb9MHauo+RQ3Awgzu7rjOL3h0SF373xlYN+AY0/Rot2J2SB0hTuwSH6Yo9N
	 5BhBbvidcTmc62T/4qJlxq6JfKWjL/favdGMDHlG1YwWcuStFSuL/YINB9NZ9S1F2EmNj
	 H/HyrEwNzoyckvXsUY6sJsEL31UIUKCXjM4AZZtCrAA7IOSxyAodpPlCauAu1+gmjzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LStKsrBA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCD606A31B
	for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DBCD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LStKsrBA
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0dba37a7fso4957397b3.0
        for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 03:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792580157; cv=none;
        d=google.com; s=arc-20260327;
        b=BQUrQSweJcy6837Ll6BXFVKUtZPZvUWpIwynbbXj4AXZPISFsZSX96AyhSBbXKiTNr
         4rh0Fs0y/Ja0eQC0QAK+O8rSgCvcNfBee4Nmzqfb7PFGF3AnHF+vyCoKsSyItiNadUqe
         jdNP9Zyvr/QFAOWuWhQKAUv1Vw0PnhQUsykPnU4A86TQLqXvmPPgqqxKYEZLb/JrhZvB
         eNK6T58mOS5HwkmQX2POEzsCT8ssl2FSszy/7ZvFWJXhMQkFf/Rr7C1Q6LLU0ZsXevzP
         X/ENfSxQNjrzAKaMGgPbvFNqrx1ltaTK1yCL5cMDrOgjvKtyIe7heV75Z1w4h6oNQqZ6
         macw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        fh=BEktfKrBlED9kuemBuq+VUcHI1J/NUyVVBWoOdXkyBg=;
        b=NnJHPnm2XICB4F0VsbPl+qDuZw/B/uStdIbuWDXDkSm83A2/bPxAVv+Fc0uUBTzKmr
         9ji8HwqqQYBlkdqL8wiTUzdS/v/Wb1xs/7BoWCReSAS/lO7SpAapjMpguwZGoUeqrhzf
         Bbvpmdl64KqN5MX+gdSCgYsG/QSy0WIu9lXnY5wnrWSf7AhSCbM7yBYyBjJkbEXEPEGV
         5prakpaOGO5u0HfAv6grn751YrbgtGN9cBzwTZRG+KUxRHZodPLRgeghd9MMCLDJwWca
         UbOu3b7CzQE0plXJsrpnjP8qRkHwHCdvnrwMG/yZqI0jn3CUm2ZqlpLbFnsCT/nknuUG
         sqIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792580157; x=1793184957; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        b=LStKsrBAmkLyaIDo7eVvgJ/m9vUfRWLRIyJ6OihLsx6GHpMB7F8VmhEb9hY54nkHT+
         XAsvZTrvDT3kC7e7pHIkkp1p0svg27WFaKT5upHJaufLe0yv7syM14crajjJrwyX9cB9
         RXQCO8tRKSb7PW0WqE9heGNj6QsK/hQ7AT/K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580157; x=1793184957;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        b=wD895c4W6y6rxP8Qoz8VsQurP3xGr+vbk7PJPkxyjBBcoHoglloN9YDlkmzNJnE3P8
         0M44t+WsGhVseSvmbJxP0qevREIlZmiou2jG/yGiyX5KDF615nP0Vai6vgWtsaNYyEMR
         MjoVu2B3r9HRA0IVx6vLev49FQ3V5JF094WVlzCN67SZGAIP6UM+fptGzvRKIIorFQpJ
         j0yiEVuk1n9+qFciCvnmBvIvTWWJyb2lFm3t6igEiZ3xIMCnBMsVFYN5t9x/adMBpq9P
         5yNmDO0Oh/wH7/ls392K2YWO/1TPKkcd7R/jJacyZ88vlXF0KDOUQv+hyoHTce2MLKuB
         bwcA==
X-Forwarded-Encrypted: i=1; AKwUvBy8ejruNs0bgbPSH+qAw9Iew8yuV/5+72HHRvaKI+b+n4X//I1sEI0qTVpv70Uq4XtTuCfaXeU2hMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL07hjfPVda+eNRThJaHyKC/LaImu7SjpwrgFtXeU0TEM8FhOY9
	qvePkrFX3LTcne8GuUKZfahNcE6RxiCX1fXUZy1rUZdAJX+wgBpAWmd5qlJ9wgn2mr6Waw9n3WE
	Qf7rumel63A+yZXVqjwzkBcBen1U7lzVrE/9QsFRu5A==
X-Gm-Gg: AYBFou0YDgVLuq93OHpKzZZz3G7mYdjU8Vr8X2m2Fl6gm4/auv/t+v/sZxFhN1DhkaU
	4bScZILgc6dP3nMM5Q0Ok1bwbuslOwkpGW0VjawLmBheCbLmFNQLmHZbW59k4Ntpw3y82+/I/1D
	sQ9BuEq49Jx+w0Z+KNleV4sUk2hZ26A4uhOaGoGucjbkePMVR2PPORfzq+Db3OvLVo2PwGZoK59
	MPVOy77S+sRSgpa2+T+HIt78U/0uur3iQEGt7sxd7UYipoU8A5RHZEMoQFVoSvRnhUG+/tbMrkP
	5GbAVS+8oxHBQQjbM5O6Wf7V9LICV+AEFc43BrOXOQYSfpEYaFFrk96NNM47R4lSw/u5Tk10p0c
	XQwrQP/YLTXc6xaIejUhwoqu+0jU3qyJC2/SbrNQ=
X-Received: by 2002:a05:690c:e1d1:20b0:8b0:ad90:98c6 with SMTP id
 00721157ae682-8b134013d3cmr5679527b3.35.1792580157475; Wed, 21 Oct 2026
 03:55:57 -0700 (PDT)
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
In-Reply-To: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 21 Oct 2026 19:55:39 +0900
X-Gm-Features: AclHuK-tt_OVDrOG_j7NK25609Kp5bxH3a2aysFucE6vALWwnla60mO_ZldS66Y
Message-ID: <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Colton Pawielski <colton.pawielski@gmail.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Colton,

On Wed, 21 Oct 2026 at 10:05, Colton Pawielski
<colton.pawielski@gmail.com> wrote:
> In testing I could often lock up the board when transferring data over
> SSH. I don't believe it's related to this series and am fairly sure it's
> in the 8139cp driver. I have a candidate fix that I plan to send in
> a couple of days once I've tested it further and there's no more
> lockups on my hardware.

There seems to be two issues: One it interrupts for every packet when
the 8139cp can hold off and not storm the processor, and there is some
issue with the chip refusing to send small skbs so the network layer
starts locking up/timing out. I was planning to send fixes this
weekend but if your fix is one of those, send your version, cc me and
I'll test it out.

Thanks,

Daniel
