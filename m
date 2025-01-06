Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4913AD20;
	Mon,  6 Jan 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178782; cv=none; b=lhqKWB8qUHO4eb8xG+rEjSXrwuR5GIfj5ShGQcEcnEx28xHld7jGfNlDu0KnbuldKL7yj037YmxT9XjvYtwP0HOPDuueH86xCe1D8bEnK6QkrLjXf5GrEgtAjxZtsk94faw8PIl8cXGqnv5NLmOd3gWcSqjPtSPwwbuHPPOo9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178782; c=relaxed/simple;
	bh=27zSPfsDIasiQLrztxpd6KsLCVSNZmztVN6Xdb041vg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ovg9XhbbBZkzI0ciTdF7PlIZMBs1NbFLBjyV0jQpQMjRTMJnL4rUoHkziUMQJAltGHfdGVWTZUGYNTs6+KBdw5599crRZkZ3N6Mabf1Y/vAN4/NM+Yo7iZ4daEI91uWpjz48puS9vRgBIFMbo2fmz18ApyfuPah124s/hnwW52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=L3ynFVIo; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="L3ynFVIo"
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout4.routing.net (Postfix) with ESMTP id 714D010092F;
	Mon,  6 Jan 2025 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1736178346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27zSPfsDIasiQLrztxpd6KsLCVSNZmztVN6Xdb041vg=;
	b=L3ynFVIoB5wGNLo4IbBxboWIntP5qzxtwKEvdDJ7T/QuH7PvKQcGmnTVOktde6ZkhFTPDt
	6c+abdE4Vb3HNZH3NG9gq3dfW+vMEP7Wzs+yQ6+1NZZaD9bqCOkKi28MpFKwC9YJAqJ/Sx
	cNpUqqpsrhHLxyW3JRxS7CFiAdtLuwQ=
Received: from [127.0.0.1] (fttx-pool-80.245.79.38.bambit.de [80.245.79.38])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 4C9E480155;
	Mon,  6 Jan 2025 15:45:45 +0000 (UTC)
Date: Mon, 06 Jan 2025 16:45:45 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Frank Wunderlich <frank-w@public-files.de>, frank-w@public-files.de,
 robh@kernel.org
CC: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
 linux@armlinux.org.uk, hdegoede@redhat.com, axboe@kernel.dk,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_Aw=3A_Aw=3A_Re=3A_=5BPATCH_v1_1/3=5D_arm64=3A_dt?=
 =?US-ASCII?Q?s=3A_marvell=3A_Fix_anyOf_conditional_failed?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87wmf8x8p2.fsf@BLaptop.bootlin.com>
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-2-linux@fw-web.de> <20241111203611.GB1887580-robh@kernel.org> <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005> <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9> <87wmf8x8p2.fsf@BLaptop.bootlin.com>
Message-ID: <B9E245AC-1487-41B5-A30D-41F03FAA0A2C@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 8e3ec3fd-240f-4d2b-8e17-bdd50b875e02

Am 6=2E Januar 2025 16:28:57 MEZ schrieb Gregory CLEMENT <gregory=2Eclement=
@bootlin=2Ecom>:
>Hello Frank,
>
>> is there any new state here? got no answer for my last 2 Messages
>
>Actually I waited for a new version following the review and I didn't
>saw it=2E Maybe I missed it=2E

No,sent v2 last days as the suggestion from rob was imho not matching what=
 the patch does (i do not add phys property)=2E So i wrote back, but there =
it hangs=2E

I hope new title is better=2E

<https://patchwork=2Ekernel=2Eorg/project/linux-arm-kernel/patch/202501031=
03724=2E6223-2-linux@fw-web=2Ede/>

Anyone with marvell boards have tested it?

>Gr=C3=A9gory


regards Frank
