Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA95480348
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2026 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329308; cv=none; b=Ld4NvKqqDR4XoaZdT18XHK4+bgRwDHzyTCgu/KiHrUPdWj6HRxbSEfjgcgKsV9wzJMMdLI/waxsvKgla+GR6zLLBBsut0g/Un4x9X+k9/uwunRVsjHuui39j08NF2xIdKRHl6hOJ0TzjWrBEK7BrmHIGQaoEX8yRYqvCzw/UA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329308; c=relaxed/simple;
	bh=cIRKFxdmYe8jBezHUK2JLyNueMoCSNJIsmPt2v2o0XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LNnwh3FE9eqke5kgU2ZidJZCmHEuqCAVXYrRUyOSVQ5kGfQ3tLZyiKFJ6Dyd5Cs5WbtLKEmL+ScI1L8lkq0Yu5Az6VzuLk2b8uNJ7VZ9W7VvfNnn4W/oyGyrv+7HYl4KeXjTy4ePZDr9zTCmk8zJBpeCZqx9+VmO7MRSBPGx03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBSqMBGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBSqMBGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5313E1F000E9;
	Wed, 29 Jul 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329306;
	bh=9qkDqQmE5sDHjCkNtwfVj0z3SZotFpPVsTtJZxigP7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBSqMBGq84eeQYhK0NsWWTyQDvp3Ek46PtU2S8067wDCC+QhxW6vtz7CXFLC1g9Yi
	 VexAUGP3C2USpZ44WF70AXp33Ymxy8qd9euVGS+C2As+ydie29iEDT2W2tllAJVk1S
	 onm+57KBpxZW/3pr5q1ZNrs9wUCCBUGOl47amlQUnrr4r84Fb/f3ij0h0SJCslTaFc
	 QvBtMCc6pRSyGoEtm9Ulkj3cgb+pvxEFWVTcmg6R/bBpulwUOusFDB58qMiB7FVTVn
	 OTJaEKXpdxtN6bghrYZb1gbEwS5+/jEHKvzlVE3eYhne07OAizkVTC9nvKeMiPC3lt
	 Xe0WNlL8iGTvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: pata_parport: Fix use-after-free in
 new_device_store
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: linux-ide@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
References: <7a9734be161cd051063ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:48:25 +0000
Message-Id: <20260729124826.5313E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array read due to lack of lower bound checking on us=
er-provided `mode`.
- [High] Kernel soft lockup (infinite busy-wait) due to negative `delay` va=
lues provided via sysfs.
--

--- Patch [1]: [PATCH] ata: pata_parport: Fix use-after-free in new_device_=
store ---
commit 8244d117e0d1faf887a5bd4b26650cebdd4ecedb
Author: Pei Xiao <xiaopei01@kylinos.cn>

ata: pata_parport: Fix use-after-free in new_device_store

This commit fixes a use-after-free vulnerability in new_device_store() by
expanding the critical section protected by pi_mutex. It uses guard(mutex) =
to
ensure the driver pointer remains valid during lookup and subsequent uses,
preventing races with concurrent unregistration.

Closes: https://lore.kernel.org/lkml/20260728024015.2014674-1-shuangpeng.ke=
rnel@gmail.com/

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 40baeac594a9f..34f09192a4190 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c

[ ... ]

> @@ -646,6 +648,7 @@ static ssize_t new_device_store(const struct bus_type=
 *bus, const char *buf, siz
>  		port_wanted =3D -1;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does this sysfs input parsing properly
validate negative values for the mode parameter?

When new_device_store() uses sscanf() to read user input earlier in this
function, mode is parsed as a signed integer. If a user provides a negative
mode (e.g., -2), it bypasses the bounds check in pi_probe_mode(), which
uses a signed comparison:

drivers/ata/pata_parport/pata_parport.c:pi_probe_mode() {
    ...
    if (pi->mode >=3D max)
        return false;
    ...
}

This negative mode can then be passed to protocol drivers and used as an ar=
ray
index, which could result in an out-of-bounds memory read. For example, in
bpck6_open():

drivers/ata/pata_parport/bpck6.c:bpck6_open() {
    ...
    i =3D mode_map[pi->mode] & 0x0C;
    ...
}

Could a lower bound check be added for the mode parameter?

[Severity: High]
This is also a pre-existing issue, but does this function properly handle
negative values for the delay parameter?

Similar to the mode parameter, delay is parsed via sscanf() as a signed
integer without lower bounds checking. The delay is heavily used in the
subsystem via the delay_p macro:

drivers/ata/pata_parport/pata_parport.h:
#define delay_p         (pi->delay ? udelay(pi->delay) : (void)0)

Since udelay() takes an unsigned long, passing a negative delay will
implicitly cast it to a massive positive number (e.g., ULONG_MAX - 1). This
will cause udelay() to busy-wait for an effectively infinite amount of time,
resulting in a CPU soft lockup.

Could the delay parameter be validated to prevent it from being negative?

> +	guard(mutex)(&pi_mutex);
>  	drv =3D driver_find(protocol, &pata_parport_bus_type);
>  	if (!drv) {
>  		if (strcmp(protocol, "auto")) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7a9734be161cd051063=
ccc3bdeb377c55a83c4bf.1785327915.git.xiaopei01@kylinos.cn?part=3D1
