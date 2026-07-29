Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919B445AE3
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324370; cv=none; b=umuCLVKa3nHBtwvAIBGmo+a6TsQiLdiObYsolYn7uGzGQeBISZn0skjtojx0Z/iGsk1zfGPDQ+uANOKDpk5sNrpwpM3KdMkk6DZw4ukb/5hmnrwRv2y3MFbNGW8XPulA4y7mzpOtOhv+xq9PSYRK8Am/U6/g0UtTqdDRSNYWWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324370; c=relaxed/simple;
	bh=QXxZ0vLKEzjzwJe89ceMw9QXF1fSap+f8aGnrT7NMF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oogP6kCVM1Inh5jTrlTvFRjsIAh8AiYZhQzQoFwb694tK2DLeJfZ24g1eFEdVfO0w5I2MB1CP5ar2elHIPTNKAKtiB42uzjDbipvDkZX4Z7oo7EwvBLkMkbz8qYuA67f3z1yzkx9SrODRadm90Z213f7VRjZBGu92yAxhf6v0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwHe/IOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwHe/IOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD3A1F000E9;
	Wed, 29 Jul 2026 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785324369;
	bh=z4U+XZHu+3p0XkbxjbJHise8vl1BsZBMeb/FfHAJn10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cwHe/IOCKCheycSe5FZwJkoru0GsWsNVZf95/wxPSMpKNpNy3Jm9IPNMDmNxHQnRI
	 7GNk2ayoJI71fEmQ10hzH1IboQAMr1T6SOLuMKAJIenstvMy3mCZVDmVl4nkL+bSs9
	 70PodN7snym/G6/VmSVtR4ApN945ArX0kXXOGZTsAf4+aTUpwfhvsyqXm6ixsS5zXJ
	 VZxgwreuz6xMZ+SdN9j+M5YQNXqJW04fTu0RLVJpc4RPmoTA5V3vNdNxTZCs1pbB4F
	 mubtu4mpLDFSJ7mrJl/Mgq8FP1VbZ4wSorxefRX6k8cJ7UDcbLQcXMGpFXRzrtVesi
	 D8Q1nmytrOwSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] test: ata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <170fe5b11ca8bffc32b4ec6588c289b29da11896.1785323372.git.xiaopei01@kylinos.cn>
References: <69B390E9-F5AA-4B22-AF50-070612603F51@gmail.com>
 <170fe5b11ca8bffc32b4ec6588c289b29da11896.1785323372.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:26:08 +0000
Message-Id: <20260729112609.3CD3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message is completely devoid of technical details, fa=
iling to describe the changes, their purpose, or the problem being solved.

Pre-existing issues:
- [High] pata_parport_unregister_driver() does not unregister the devices a=
ssociated with the unloaded protocol, leaving dangling devices on the bus t=
hat hold freed pointers.
--

--- Patch [1]: [PATCH] test: ata ---
commit 787e1d65e64282ddc25d6c43593b6cd3674b9345
Author: Pei Xiao <xiaopei01@kylinos.cn>

test: ata

This commit modifies locking in pata_parport by adopting guard(mutex) for
pi_mutex in new_device_store() and extending the mutex_unlock call in
pata_parport_unregister_driver() to also cover driver_unregister().

> test: ata
>=20
> hi maintainer and shuangpeng,
>=20
> I tested this patch passed.

[Severity: Medium]
Could this commit message be expanded with more technical details?

The message only mentions that the patch was tested, but it does not descri=
be
the functional changes being introduced, such as expanding the lock scope to
protect driver_find() and changing the lock ordering in the unregister path.

Describing the problem and the rationale for the changes would greatly assi=
st
with review and future maintenance.

> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_p=
arport/pata_parport.c
> index 40baeac594a9f..34f09192a4190 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c

[ ... ]

> @@ -618,8 +619,9 @@ void pata_parport_unregister_driver(struct pi_protoco=
l *pr)
>  			break;
>  	}
>  	idr_remove(&protocols, id);
> -	mutex_unlock(&pi_mutex);
>  	driver_unregister(&pr->driver);
> +	mutex_unlock(&pi_mutex);
> +
>  }

[Severity: High]
This is a pre-existing issue, but does pata_parport_unregister_driver() leak
devices?

When a protocol module's init function registers multiple protocols (like
kbic_init registering k951 and k971) and a subsequent registration fails, it
will call pata_parport_unregister_driver() on the already-registered protoc=
ol.

While the protocol is removed from the IDR and the driver is unregistered, =
the
dynamically created pi_adapter devices are not cleaned up. Since the module
init returns an error, the module loader frees the module memory, bypassing
the reference held by the devices.

If these dangling devices are later removed (for example, via sysfs
delete_device), pi_remove_one() calls pi_disconnect(pi), which dereferences
the freed pi->proto->disconnect pointer, leading to a kernel crash.

Should the associated devices be unregistered here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/170fe5b11ca8bffc32b=
4ec6588c289b29da11896.1785323372.git.xiaopei01@kylinos.cn?part=3D1
