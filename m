Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B46481AF;
	Mon,  6 Jan 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177343; cv=none; b=WLpO57ocBChKt6pnJ4z7jy2tKVR/cQiJoOaTO7EYljVJi+4BT8Mn/KkCq8ac8Sj9kFlXasEGTk+6b4r1vheiTXC4BqUHZEqISE+h/4ORG40XWJ8H/KyfCPUnO2weOkgB0WhTlT2TjS/uCC7tdrVqY1SX3yIA8hSFt9IpZgrFoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177343; c=relaxed/simple;
	bh=r8skViHkHUdTzDUwE6oxnQAwKjn+7wyUOhiP2qZ6VJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDQAZOOmFCJvd6LMFPs5kpTB6NSJF0k60wyBWwAnjKdmnsR13Se2cySsUJgDi8HJpN50tlwi58PDJT8keqsaWxvdwCtWcVVMrOlXPQVXN3PeXpsFkIMVOqcwCM/O4qeDsOfcmFfV7GlnakJRWJeRmpnLAfPwRv1YNdsMXQ4UFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ezpS4D9h; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ezpS4D9h"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E11C9C0006;
	Mon,  6 Jan 2025 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736177339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8skViHkHUdTzDUwE6oxnQAwKjn+7wyUOhiP2qZ6VJs=;
	b=ezpS4D9hDotHMMLeCvK29RNsk/GClufpghlnuVKXrCNppd94dObGHEflvQPfEDo+xQjW4L
	7N+TCKDYGZYiMF5HY9NTDjEf7xz+X62oNAltUPPSx9T03FbJjWfbpssbXs0eXQTJGi06JN
	rex37pwWVJdlnzdtfKLSlhF4DiCSG3rkPzlBvHHu84h9Rn4u3agjF88BLPuO1d7JMSeSfy
	j9L9mIyNBU6pLe8gfy6i/SjrUwYMiJVOhHJ+/2i5KkYuLj1VhsAl+Q3cwVIBYov3IxH+QW
	SvlPcBC+AMeZCus+vTnKmawxpOnvV4hIHCkAZIBQWSD7TYWJXzRoKSZkd9g2uQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Frank Wunderlich <frank-w@public-files.de>, frank-w@public-files.de,
 robh@kernel.org, linux@fw-web.de
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
 linux@armlinux.org.uk, hdegoede@redhat.com, axboe@kernel.dk,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Aw: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf
 conditional failed
In-Reply-To: <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org>
 <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
 <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
Date: Mon, 06 Jan 2025 16:28:57 +0100
Message-ID: <87wmf8x8p2.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hello Frank,

> is there any new state here? got no answer for my last 2 Messages

Actually I waited for a new version following the review and I didn't
saw it. Maybe I missed it.

Gr=C3=A9gory

>
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2024110909462=
3.37518-2-linux@fw-web.de/
>
> sorry for the html-entities...they came from my gmx webmailer, it is repo=
rted multiple times, but i cannot do more here :(
>
> regards Frank
>
>
>> Gesendet: Montag, 2. Dezember 2024 um 12:19
>> Betreff: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf condition=
al failed
>>
>> Hi,
>>
>> just a gentle ping to have it finally merged
>>
>> regards Frank

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
