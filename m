Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563317597;
	Wed,  9 Jul 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067021; cv=none; b=K2S85TE7QhHZBEEulXAgRjVBUMMT5/GqGQTuNIjzitLM1F5XfzryQVXWw24J+i/gKUq6MZF+vChed4S6dtzmpdo4g48iZVMAkW6LwpJqupPegQp5+2Z/BJvnbhgEpmrtNbyuXDU9ngS3wyW2dGGFpp1JZs333CVNIacc39eo2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067021; c=relaxed/simple;
	bh=x3fpg8Dy0RVxmKLMGgruVGhPxehPiWOmCjuuXiZBKcs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jYqiO97zZtknrCrpzlp3AR8FaSMdujvCpkdP5rdZBcQIQc/NdzVu4Mlkc0KIHd7hERW0nMa9Z5UrG8npraK4or5BwF8j/g32rGgnOzEmlbhOxbTZ2AbDTYzScMJzzad/T7qaPtkWkklSgU16Bn/Rg+tpQVAUB8W13KJ+r885NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHFhTYuI; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHFhTYuI"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-611a7c617b4so1563266eaf.3;
        Wed, 09 Jul 2025 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752067019; x=1752671819; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3fpg8Dy0RVxmKLMGgruVGhPxehPiWOmCjuuXiZBKcs=;
        b=nHFhTYuIk9kuUIzIJd61GvsohBJ/dQogCzSny4iosn658r8EKwDLQ3dqOu9wwQhq6A
         BUeJoPexejs+oVRRDTeVjniO4D0nuVwT/YNLOAlMzzl4WjJ4ASY6At/rYdZP/1pOAEAF
         0EzIHFaMNCqOXGLnqLFnc9yNfadwVjLPktjrDiXdRamHBOso7zEL3TBQueyAA504Dqg4
         FvWzn37Rk6FTkMvo9qqvbHkLBgO9rNdMnh4qkzuReW1dKkn6a9anCwbJpOyaUifih6Uw
         iFYf4NcNcGuSXLnt1iwdoNL+CYIYjoaT8MPVSXS0XyApImNyF80i+JZLIQaM3K1arG9q
         Dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067019; x=1752671819;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3fpg8Dy0RVxmKLMGgruVGhPxehPiWOmCjuuXiZBKcs=;
        b=JHzMWqdV1uqJyj/h9tTX0jHM2fBQnZUBdhZSH0RvbCmbEkH2qB9ki7vZ+QsCz/7PVQ
         3JoQf4mqYoCHJRInF/PkfOjiorwiwRFG+V/K94ukUbaGn8uh/Iqm6lxtYI9ThWXebbnL
         1apy7EJfJGSOrk5UD1AT5yehJRKB+V1bkUetgQd4ke4Ul4u1ykkctluz2ZxW1dvcyqbL
         IA4TX9pFj43Ncw28VTCj02HrHrEP3s0S0Yq4h46jQHijQvXLZufh9/MNrh9lSp3Di73l
         g4vMhm4PLARci3NngPS8quJX3hIWxS6LggcIyk5y7fddGNsP5mnFPdFp1Ye+0OeVIzDs
         l4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUTSSoW0EV2dBDUB45DLSbNhhawT6wGcISeebAGjPfryULIqIeyeAMI1EyfOmU1uc+xus4ZSAFhgKk=@vger.kernel.org, AJvYcCV7FAPe9Qp/eTRRIwxAH04FoLYzg9lnX5GCMrqI3Xvkprjd5hYy/oln+6OTf/LK6XntYWxQ8gSqntXr45JO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc97X+Jg0NUOotBaXlTZ+J/JonHftPU8nVxlN6c6qUOKtvRf7d
	qln4LhIxVOqgWcQJ6V+PHdEGj6lc6dc0DNQAWrGqr1o28RICyQqar0qcj6+IupLs
X-Gm-Gg: ASbGncttLKnoCqMBDKsFmeOWKu/g5aqTfm+dHqgzfxs+LGpqyFc0FKEeGRCWs90zWek
	/FPEqUdJOkRAxqPgzlxmXgWIoBfQ5NC7mT4HwU4T0BZ/qTGSZwRpWtsEao5cXbgCJ0loWABAgvE
	1ibpqslZjswBptdwHFOyVmGcJIEQJiZ1LCXGr872TQVgKwAAjnde+OTbWnqIxZjMu4Av7VfA3pb
	K4bQDXDhoQVN9gT2pVn2ZC6XtKm2lI/rZViBrIEHrMQJzwdOxRlVWegYKlpy2rOtH/kfpJdtjQz
	/5+VmsYOnGJsUUWLst8AYGtkbMVgKTDrRDOh8GMkf/RW2VSYfKtzbvfUj25ogOb8KwLZ+JcsYLL
	ZLkuSCdwXx1QDOmOhB7bdOJMxlB8ZuQxWpHtuu5AfjkqALBYN9sUftXAD6MNmdmpr2OtAFsTYlf
	an4RWs3Gom0sjxd3Q=
X-Google-Smtp-Source: AGHT+IH/RpYL3SC5w8Weg0tSS5V8y5e2CZRdslX6oLO4e/F9GZ6xWFR9aq84ebIrVHVBKdU4GLZ12Q==
X-Received: by 2002:a05:6870:e08f:b0:2c1:4146:c556 with SMTP id 586e51a60fabf-2fef87a8124mr1865603fac.31.1752067018597;
        Wed, 09 Jul 2025 06:16:58 -0700 (PDT)
Received: from smtpclient.apple (2603-9000-d600-0325-1c69-8e34-714e-4b84.inf6.spectrum.com. [2603:9000:d600:325:1c69:8e34:714e:4b84])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53478ebcfcdsm2091515e0c.19.2025.07.09.06.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2025 06:16:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH] ata: libata-transport: replace scnprintf with sysfs_emit
 for simple attributes
From: Jonathan Velez <jonvelez12345@gmail.com>
In-Reply-To: <5331758a-528b-42bc-b57a-5735a8b6e4f8@kernel.org>
Date: Wed, 9 Jul 2025 09:16:56 -0400
Cc: cassel@kernel.org,
 linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 shuah@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E579B6D-4398-479F-8E18-31E8AEFBFB2A@gmail.com>
References: <20250707122004.224770-1-jonvelez12345@gmail.com>
 <5331758a-528b-42bc-b57a-5735a8b6e4f8@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.10)



> On Jul 7, 2025, at 9:15 PM, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> On 7/7/25 9:20 PM, Jonathan Velez wrote:
>> sprintf, snprintf, and scnprintf do not consider the PAGE_SIZE =
maximum
>> of the temporary buffer used for outputting sysfs content and they =
may
>> overrun the PAGE_SIZE buffer length.
>>=20
>> To avoid output defects with the ATA transport class simple =
attributes,
>> scnprintf() was converted to sysfs_emit(). This aligns with the sysfs
>> guidance provided in Documentation/filesystems/sysfs.rst.
>=20
> Nit: please use assertive style (no past tense/passive form)
>=20
> To avoid output defects with the ATA transport class simple =
attributes,
> use sysfs_emit instead of scnprintf().
I will amend the commit message and submit V2 of the patch.
>=20
>>=20
>> Signed-off-by: Jonathan Velez <jonvelez12345@gmail.com>
>=20
> Otherwise, looks good.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Thank you, I=E2=80=99m considering reviewing the rest of the =
libata-transport.c module for similar updates. Thoughts?
> --=20
> Damien Le Moal
> Western Digital Research

