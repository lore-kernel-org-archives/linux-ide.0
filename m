Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5571EBFEF
	for <linux-ide@vger.kernel.org>; Mon, 20 Jan 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391666; cv=none; b=OHTiNtxVHUvTp/4VqxEWFfIJs7vnV1GCppOWbF2ooqlBy112W8tpR7hOmcF0gvbKlogEXXZcrbnjYw1k2eRE+T/uwI8U+EcbYIoFiqiLSGoD1YrprWANy8eCLPw/8gFYpeGhj81+C1rQv0PJAhc2G6lUXcaXHZLQjuuID9sfhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391666; c=relaxed/simple;
	bh=mlciOgUmX6lk6RFYA2l4cI1V9mfLjH4+arGySEC34Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR+5i/2yV12384Ju+uto9DmWFiX8OlKEu80IYkmvD5TBXKCplFdQxNL7jIbNXEE82iR7nl1aTf32+dB+Gwi455L8437ed/qOYzg8oe5wUU8AZorKVhxqjwAaYau83sSJlLE6xfcVRHlKhxXPnfIzQZj3BjUjVvwZxxv1UMguC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns7jMm2f; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns7jMm2f"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso42660026d6.0
        for <linux-ide@vger.kernel.org>; Mon, 20 Jan 2025 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737391663; x=1737996463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLAJcZQ3CCQYzY1g01gGZet/96yxfikaefwx7SLoijI=;
        b=Ns7jMm2f73Y018OysNGVs197UrwXhPdncgkMjdsGZ2UOl+mOGv9T7lntSqsjNdtkaQ
         lhtIc/NZZRXqUn95jdDjhxkGxabf3PK1yUEkDFmRYEhRJlGRgDLbjvAp80cRNUdRD0fc
         FjU4nhVm16gq8ZewhxwXoeldkXF60tQnyVoZLbo6mPcPY89ZQ9PWSIXhZN6rMsu1cPP9
         PuaXHk8xnc4a55KB+2TdXbmyNR0HOPlF1iqbKpvkvLlij/NaUfIwgb2WCsNXVWGiWsBc
         JjDj2RPrtEObYWXjufYTkdNNZ/q+rYkI9Gmy25caH/x0np2EeDT5rM2a9gAgykmBR50/
         lKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391663; x=1737996463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLAJcZQ3CCQYzY1g01gGZet/96yxfikaefwx7SLoijI=;
        b=u3PQw1oWMuftqaV4QgD1DkkMnrQqtjfAWraCC3O8ZM1p5OvzSplIja98bPfRc9uAbQ
         2RBy/IZSG02MPwDLvhXpZiUDX4f6rcJ30c5R426ExiLSNIwiMe5LMiLp/dPOt6hn39yX
         3J8cTUeMAjIfLbdSRBWd/adVkOueeqbLC1x+p70oSct6b7CyzRSlwigL3cvbaVGBLw6G
         EqzH6/gXS0x5x7TZEXXX0yknobs6j3MtTJxVfzOmB4x7vV7f0bEQQDv6FJfGSKhJQUUY
         MnHX7Jv/9/pAfd2XIvCGq1GL4EQ0LcfDbLFjrlC52kt7JQlCaPbUUVJ499QoobI+cYh+
         vx3w==
X-Forwarded-Encrypted: i=1; AJvYcCWZUHAVoGO3Ae2gahZUDRii3SY9Mv9o3+KjQ8KWGefdZ8kmFcf/8mKC3nJiYd2dFl+sAUjQ9Gt/Rs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKm8LDQhK1Mr+EJUTzQRXxOx6HQY3IJgP+/gMdWdRjbEeyQAT
	r1AIPPEwdf2bUGxc38w/BngbAnGX2MtGMABt8fPIQX//Qahvd+EUcBmFkBGLU6Uj3Xy6SZRNRFv
	E4USwScigp4PuEZUeOMPu8ojudfwaZscf
X-Gm-Gg: ASbGncv0pKjSrVY+9ZfSwTpv2XC4X8XzKKayvmZDWxdr83aSWtdyxz9jJBt6fyZ7t+y
	1BeOsS1WSIfrwrtXvPeSof3Gr2l4COXK7oqoTXE97wrniwoYZkx7JsA==
X-Google-Smtp-Source: AGHT+IHzt6SQk+wuEGROdf11SHco2Bp2DVmdOQgKbgL3st5A3fuyA6WkoAm6+HGWlWWvcMMONN7m1h2NptTEntdTfrs=
X-Received: by 2002:a05:6214:d87:b0:6d3:f6bd:ca04 with SMTP id
 6a1803df08f44-6e1b2230b55mr191613676d6.40.1737391663336; Mon, 20 Jan 2025
 08:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z3ZtFDgs61oDMMB9@ryzen> <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>
 <Z4popNqD1GZriXh3@ryzen> <CA+-ZZ_gtsDShKeZSupbrwCLtpCvW=p1=citKVXRrSDi3LoZ_9Q@mail.gmail.com>
 <Z45VmuS-j0bEMf89@ryzen>
In-Reply-To: <Z45VmuS-j0bEMf89@ryzen>
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Mon, 20 Jan 2025 11:47:32 -0500
X-Gm-Features: AbW1kvYEtdDFWl-rfDYL4bk8fwQhAGXCF5Y0SIQ1pUexLbhtcX5fnOgiwiUxmL8
Message-ID: <CA+-ZZ_i6FKRMG8Fi=PfGpcnVDo=hp3J0Bz+tw6Y9+raMovP3Mw@mail.gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 8:54=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Fri, Jan 17, 2025 at 11:42:45AM -0500, reveliofuzzing wrote:
> > >
> > > However, the .config you provided does not match the bzImage.
> > > E.g. the e1000/e1000e driver is not built-in in your .config,
> > > so I get no networking, while it is enabled in your bzImage.
> > > This makes me worried that you have other changes in your .config.
> > > If you still have the exact config for this bzImage, could you please=
 add
> > > it as an attachment?
> > Hi, we double-checked it but found the config shared above is the one w=
e used.
> > CONFIG_E1000XXX is enabled in this config.
>
> You are right.
>
> For some reason it got compiled as a module when I did "make olddefconfig=
",
> with your config as base. Sorry about the confusion!
>
>
> >
> > >
> > > I've been using the syz-executor binary that you attached, since the =
C code
> > > pasted below does not compile, it seems like it has some unintended n=
ewlines.
> > > Perhaps you could add it as an attachment instead?
> > Here is the C program:
> > https://drive.google.com/file/d/1Uvhqrn-ntEYQT2PBiQjp0xaor-32WYHO/view?=
usp=3Dsharing
> > Please let us know if you still can't compile it. We can take a look
> > at how Syzkaller
> > generates this C program and compiles it into the syz-executor binary.
>
> Still does not compile for me.
>
> It still appears to have some uninteded newlines.
>
> You probably copy pasted it from an editor instead of uploading it/sendin=
g
> it directly.
>
>
> One example is:
> line380:                if (write(1, "executing program\n", sizeof("execu=
ting
> line381:        program\n") - 1)) {}
>
> Strings in C are not allowed to span multiple lines without a backslash
> immediately before the newline, or by using string concatenation.
Hi, we have updated the c program here:
https://drive.google.com/file/d/1Uvhqrn-ntEYQT2PBiQjp0xaor-32WYHO/view?usp=
=3Dsharing

This was the command used for compiling it:
gcc -o /tmp/syz-executor -DGOOS_linux=3D1 -DGOARCH_amd64=3D1
-DHOSTGOOS_linux=3D1 -x c - -m64 -O2 -pthread -Wall -Werror -Wparentheses
-Wunused-const-variable -Wframe-larger-than=3D16384 -Wno-stringop-overflow
-Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable
-Wno-unused-command-line-argument -static-pie < ./reproducer.c

>
>
> >
> > >
> > > Also, you only talk about 6.12 kernel. Out of curiosity, have you man=
aged to
> > > reproduce this bug on v6.13-rc kernels? Have you tried?
> > We haven't tried it yet, but we can do that in the next few days. Will =
keep you
> > posted.
>
> I got an off-list email that mentioned that you could reproduce on 6.13-r=
c7,
> thank you!
>
> Hopefully I will have some time to try to debug this sometime this week.
>
>
> Kind regards,
> Niklas
