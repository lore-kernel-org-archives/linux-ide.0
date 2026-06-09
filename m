Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE914048BE
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005184; cv=pass; b=DB5wv5sVTYx8M+KUDZWZuMX17IRQDe2OCtbe3izMfuQwkNlecd2fcSwZfdb/j6A4ft/4w7qstnQgmzeC72C6p/7hK6T6EQGn4ShDy6lG3nIHo6q1jfGL+g2xPoTi7zU1Xemc5U/HTSRJDUidJ6hQh5eauqrLdMN2jl5sNGQPndc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005184; c=relaxed/simple;
	bh=W0Xsv2To57Htp8ZdHDmyyYQMboQK2sS8scSEue+iEM4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=chcOjlksmSdh0otpGDElR0K7P8U9T93tAMO/xkxTW8oXmi2vIRrCSqFNZwd+8supC+NA54i9MsnHGxZa+RWwRRIkQLJ0thR8BVPdZrZhYFzTWn7lcM6YNKYwwPz7YwMSxRqcrD7L7WNmygpxLyJOHm0fUuKxo+frYCbDUtrXFgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFwFsotL; arc=pass smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFwFsotL"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5174a3d9598so47090291cf.3
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 04:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781005182; cv=none;
        d=google.com; s=arc-20240605;
        b=fpbhDbl2qVTI73U4Ck5rD3zDJ49QgkySvkRKwDe4kCOJS/Nml7LoyVT9O1Rz7ANHZB
         QgmuGvQmvKdMD4lbCXHt5mfYVvMaRS3t21AbLyrb58/oXgSdTSlV5uujbGN+1oQ0ipP6
         HIBNA6baRHmiq4lIbX3fhQ367hYweqyVeSoC7W4Upycuz4zl1EpFKKaGNjd8MSGbnu0s
         A2SZQx9r1u9cEdk2zdTwstx/E747ubFy1F2Vz74dPj9xQISQJwpapnSKQNZ59y+Sx58V
         kLbsO/SaLqQmOvYvkr583Vy0C4DO46dnSixTj8nr7YueIQuvvT1asZohhFlJjoiyXC/j
         JBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XjLYVhPEMOO4yixg00+xV35fwcIYUgQhJK163nVpN4Q=;
        fh=EJbv+WmbEfpI+tYc1ah3WaUE6f/yRj6mTAdunEcZfpc=;
        b=Nm6brJvF2llwCb+OBLIwUIdLkjfgogYs3OUf0XSvXwWItXzMIvKyY1tLmtIzN8ld4/
         YMrud43CRk7hBFSW7AVuJt5wm9BeXLZS11GxRtQHqTm/nT3/nwCkPHou+kIQKACnZRpQ
         4s6GbcOwKPraJDG2YUxEfKvs9Sd4KtbB2bz59lka04LWmH8gvOX8bQULE/+nGpv0oxOj
         tAKsXoA7Tg0AEgooqDkBz5EH1f9CrKMyVzzJoCxH0D3PgCXVA65WvFLfopUbn3gnjuid
         SHvzez3YPQ4gD3PjfrAvM8roP+s2HqlDaW7P2li+7/biLv90zK4vvPRTjYiRZuifzG9j
         SQrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005182; x=1781609982; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XjLYVhPEMOO4yixg00+xV35fwcIYUgQhJK163nVpN4Q=;
        b=SFwFsotL9YuWFLZwi4lkr7wjkuR0IAtBoiEHXVWygSxsNaGtp7igBGWwd9aCF3Chrf
         FaEMI23weNgKirpi4SbkoRtOYEN2wBYxAm1uD/zasO4eeliPNFzMOyIlEAWtfuBsGfvq
         yAqlrn4fVed6SK+fVuagUzvPQkH+t273Wg/olN4yKENaIQ55YSSuMZNwBL/szCPDDoL0
         ppodcQUS6elLv5T4Ukb6cpTQ96d1mPKcJBfKicqnr1ig9jFz153L3Uo8XKII9TIhaviJ
         FjnaWVNkf/C1EsDY1tr/MdgcA8TWb7dp0rIwn1p0Q1rylC05CCrAJVdsy1sP61pOGrCs
         fx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005182; x=1781609982;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjLYVhPEMOO4yixg00+xV35fwcIYUgQhJK163nVpN4Q=;
        b=hGT1BUioAiOSyMulEe5RBgrH46AewPmxCqJaTElTDs+KAVOqESno0BTSyBIdjilRCS
         TZUn+SngLzZ9TGcIzIs6sZEJy4+z00yOC5YMNy1A5gPxnlFRxjzYVBNZnTqkL8hiBZqJ
         DnDGt87rP4pYqdBi7Ocygk4XY9/LgAudNK8Z37ZzDIVvh1SJBd31EUc6SJjTbtk9T4lx
         JA2d8PiwtreO1stuUFXiSN822zAc2RFw2r9F5Gix4p+UwXENHJi9ABnopwUW7qfLhdgI
         cGRgU+lWArhq1MO7jdpG6ex1NGu+ZdXDIe9oOEDD9Ai5rjWwlkcwpD96CADMdaL4mLhM
         R/JA==
X-Forwarded-Encrypted: i=1; AFNElJ9FjanKQn2PtM8zm8I2nHQKDnHauauln9hGbR9cV5mkRc9PbKgjCGi3zEGjfaQJxjR+Ux98PVfmrrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNIUkm3Z5+qcTPjKbkJqvgBy24xYwkvVCRcQM8aDx700DbnoF
	qw1uhncoXlM26r9eYUOW8XtQhHpbADp1qaLS145sR7aLiOVuOK+U71kuLjTY7pznBbmxdIbbfdf
	pGjqJQkyjvEnaZtsvWQNzGFyTtc+sZUQ=
X-Gm-Gg: Acq92OF+xQEnYn5RlCQ+lx6Yuiucrs6ivN3ae0SVBVwa0nPAe09wkr+DDgrenJNmVA/
	nf6VVHwL0i8mTR8CuvoDN+oA961yaEQzqyeKv0Y9rVN8YX7ZPb6nnbufX1RYAE6PsoufG81qWEs
	hYy2g1TZigLJLYuTsMTKlUnwqmihPtzr/c3P5u8jSrMsYHyGIFDqZTow3HajjsgaNhPlHn6iokx
	3zYnZqUV8Yp10d1eOwf+5cTB9j2SqdJcrnjafv1rDVa4g3BHqV/lXOzZCabS44/4Q5WVCnYtRDX
	3YeWkZmsNljq903AsA==
X-Received: by 2002:a05:622a:480d:b0:517:8da1:4d5 with SMTP id
 d75a77b69052e-51795a256c5mr278826391cf.27.1781005182068; Tue, 09 Jun 2026
 04:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:39:30 +0800
X-Gm-Features: AVVi8Cecixgp2t41fDZnbqGK_CTIPSWKSrBfVonYDY7zkN_hqWEyDzF_F_D1gmM
Message-ID: <CAHPqNmx0LUYXWW1n_Su0BEOGqF20qDHj3CNvXBLuR3E7LLBOBg@mail.gmail.com>
Subject: [Kernel Bug] possible deadlock in ata_bmdma_interrupt
To: syzkaller@googlegroups.com, dlemoal@kernel.org, cassel@kernel.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. possible
deadlock in ata_bmdma_interrupt. Details are as follows.

Kernel commit: v7.0.6
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

report:
https://drive.google.com/file/d/1krb648PgTy0zRrwtf-cV7ahPwvaT9mv_/view?usp=drive_link
