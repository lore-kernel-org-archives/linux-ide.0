Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826735959;
	Thu,  2 Jan 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847177; cv=none; b=PzWg30wIU7hCzSWFzQ4+BXgr5l2i2l8wAMA5LCS2JvaBbH44sC2zjGGGylh6Dael/Cr/p7kRhYhhX4OIWoqxd243LnEQMa/CyyczHktq8bb8JsOR6bngGfmz2GaKy+LmH+dMJNjjZg7aT/O++Jr/Zi/Ukw3thT/oUu8DBEKoEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847177; c=relaxed/simple;
	bh=amp1CEFhaVmmxuo6v/x5I4IWHqW3oWzKuDQMVOnB5O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHMLO6A68N4/75qbeX3CWjo1CEkn82+rtFjGWL6b5MnqwaevN9DUZlHEMrVhRbr1ZlSYouRmGN8ED28eVQRbW75zjyncbCC6ml0Z1AYDiYsv7Ys63MTOR7DtgHokad76KKqOWhYU/M5ZN6HwHcLXpxJ5ur/nC2oWGG2z+vlu7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jASbJtqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jASbJtqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D06C4AF09;
	Thu,  2 Jan 2025 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735847177;
	bh=amp1CEFhaVmmxuo6v/x5I4IWHqW3oWzKuDQMVOnB5O8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jASbJtqrpq3wZ39VleyGGB7kavwD/fJMhO2UQBKowrcFBIS38Tj/5JiU9RIele05c
	 d5mt1Rmz1tMKB2lZiF5jADE895m7Ql3uSGs02ql6T5Vuvcadkon9hOCOloIVpmkJ/u
	 7VscVQSb0FEhNdSd75bzrxxvnErsPeycHQ2P02vEDGHBFAqt6uMzuzm2karMIqd5XJ
	 suHxf4xdzQ9vIOedy9FzTHXm0bquKKs5h/ozgYH1XcPFW7ICqA3TKACaajBQRJJ9YN
	 l6148IdBYsqUMU2dUOA0lZgR9r3t9fuau2LhPPKPNS2wiFrBNvXGLu589/6nCd4Ymq
	 sxHHkKTzkW55g==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5447fae695so5302959276.2;
        Thu, 02 Jan 2025 11:46:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5QPjyct2odN39oy8d6z+0TqYzJScWi7ALx7szQPQxjXg7GCCDdZdPaVdQlq++/h7JR0XXYjPkbdv7@vger.kernel.org, AJvYcCWMKsmSo6KKyw7UKVasCo2GdeTkSgT72Y4pt5VjUnfIqKRCVTalLcn2Ewdf8tVdjmfpNn2BU6MUVC3pZ9Oq@vger.kernel.org, AJvYcCXWo2WAUfLZZFxO8FI3AuzW8Faj/NG8mYMFnTRtS2toY4UMbgU2hz8iGLqeMAACkfZh5rdtDDYXrcnv@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxaBwCtEqu3PZ2JYopTRfDHEgeTjRM3xvrN3JXRbuk9do6+Zn
	QlFxd/gz25RwzTWsUPpF+FPVLDrgOTfiWCwZ5L8YvJYr0G92kDt3VjBNliyrgcekSbAZoQeb5BN
	w+0FQK2EmPuOSdh/Z6EY/EMBoKw==
X-Google-Smtp-Source: AGHT+IHJkV6/Tz0b+/BQUDZk6POaQoSuO0IHC+p3oeSsJZMQ51uLdt7IApHJfEWtHbNKSAJno7pQz5oonaXJyVTLq/M=
X-Received: by 2002:a05:690c:d88:b0:6ef:5c57:931 with SMTP id
 00721157ae682-6f3f81029femr273206797b3.10.1735847176306; Thu, 02 Jan 2025
 11:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org> <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
 <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
In-Reply-To: <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
From: Rob Herring <robh@kernel.org>
Date: Thu, 2 Jan 2025 13:46:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+PEdH1b-aoN2nFJMRz--abXPqZ=sftPnhYKWpj0VjroQ@mail.gmail.com>
Message-ID: <CAL_Jsq+PEdH1b-aoN2nFJMRz--abXPqZ=sftPnhYKWpj0VjroQ@mail.gmail.com>
Subject: Re: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional failed
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk, hdegoede@redhat.com, 
	axboe@kernel.dk, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 12:44=E2=80=AFPM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> is there any new state here? got no answer for my last 2 Messages
>
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2024110909462=
3.37518-2-linux@fw-web.de/
>
> sorry for the html-entities...they came from my gmx webmailer, it is repo=
rted multiple times, but i cannot do more here :(

As a maintainer, when I see any discussion or comments, I drop the
patch from my queue. That may have happened here. It is best to resend
if it's been more than 2 weeks. Though Marvell maintainer response
times are often longer than that sadly.

You haven't addressed my comment either. The subject needs work. If
you don't like my suggestion, then come up with your own.

Rob
