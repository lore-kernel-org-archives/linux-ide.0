Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116B480954
	for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153229; cv=none; b=p+Wc6Wwc/IOn3FG1LNJFvfX4pfNOiTgqoAhFw0PLFe2BOlDt+RAoTyangjzQDh6NlBdY0Wb0gZcgCzODNuXSTIBQ06li6eh0ahtrxn4Oa9QhWV/KUfqw9cvFcKXW7eTpw2nYYnF0slXwBWIB2rCeDz3UVCf1VQfv9jiGcrsIRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153229; c=relaxed/simple;
	bh=j31alrGpjl2Yac4h6RWy7MF873v/kQg4gW61KgWAx7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ0rmoa+Rn3KUH+WLclWRXtNG/YOLh5DTj+gU3dDt1Kd6An1v+iUJc80Z09Mb8iuVljGBXHFaqKvPf0Oaga422Uau5j+YTxtjse/Md+sCqsdGEVhiojApHyrGdvbEgCoJzfcgc34ZxpV11yxDZOOfbdFNxVKNGOhZgz6L9yv3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AVnnbvWp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AVnnbvWp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso499680f8f.0
        for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2026 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787153224; x=1787758024; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j31alrGpjl2Yac4h6RWy7MF873v/kQg4gW61KgWAx7Y=;
        b=AVnnbvWpJIK7plgEwnG7FrIW25/n5PoFhFWcZO0VJTlRV0opoBF6C0IUKYWWAeHB5J
         We16jxyLCZ9gemIBpC1ujgN1fIEpDcwnQJv3KBUEj4BkAhl0EHRgjEGoU6d4QnBNLbW5
         1LbIzJ4m9V7RSkknDJDrHiDcl/Wmm3Tyr8Vr9AiAPUS/gcTWNK7zstTlIU4lOtAfIhCF
         X3ogFLydBKDcgAJBJP0jw3KsKHTDFUSQQFimG+d5qRq4jMqBl+x/Tz0zxjozlqfrR5dQ
         PJgvN9Fi0frPyQW1mTBa8JMQwsQsR+D4mHsHAQ9YU6qXwfDQPacQ/hjFWO1CrTDtrEDn
         JZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153224; x=1787758024;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j31alrGpjl2Yac4h6RWy7MF873v/kQg4gW61KgWAx7Y=;
        b=i7XoETN3pY+QM5vmavAYquv/mvqexq17q7bRc3YT/cuwSZ70BRm55/jDcMG/h7H8pk
         530nYpK6vb0CplyCeiGL8sflccq/JHD38vCtHHAvYNgUgsdM/V7rbiKe7ayfKwQnqXqy
         YfGycEMEuhb0JrY2OQjrH6Q1fv5G7zA0faeUHJexwXrKCHUOrVwgJZkDwg0vVVjxef/U
         ZaELImTT4tvq/9ggAkGSkIR48V5xL+IEWUSaa8PWRizzSdIRqLG1cro170MUY2PgfuGP
         ePq+n1wfhNY7yd1fRMWa7ZSwNGkhwjqq8NB5zryZ2by4fznMbp2P4cu0A6ehis90Bu6n
         ZtmA==
X-Forwarded-Encrypted: i=1; AHgh+RoohuiclKtxmdYq21jiQoyKQvcTGu5zQn1vLDRluU+YeUwurC7V9B5G7qLBUSH8FfLDLfQQSvLmPA0=@vger.kernel.org
X-Gm-Message-State: AFuF++kI7UMjqcDhUcxozlzJPhquwHupvibcYsP3t8HKqX0werBT57P+
	ye726jY+GZ7IccNBEIRr6/LNJr8unPJEIOrWoUYdoi6+PazC/78lvWByeFjaV5tOZnI=
X-Gm-Gg: AR+sD12mzClQFk5AOXGCuV93erDqhNdhm5SvkhhGMuKG6YraL2nBCuSLwWNfei6sC4D
	LmsGDbSs+cf/I0Dgtfzu1TJezcrdJENi4XmDK9vd1ugxqrb2jMsAHU3CgJ10pxap4+mFjcEG1dE
	OvNdQExuQFKrnygxMYiVGVd3hEMvxGCZDBiumhjlCOV95Ej/KkQrMusvjxrXQzPgIHGWizp4CZy
	OvMyXuv7dyWbZMzih/vX+iTXuCww5g+AZO1iTW/rBqIyoXurzoDXqIkChOFomZYCMIHuFICeTBA
	qO8tEIQQ6FaS/sRhBti6Ru3KpOYgHwrXeHk6BvjsDPfBuPpmJPMm7E2rERqDNMeIjDguod2xqvP
	lIl3cn6K+Z2TKG5XGgDVcl4QOuUPUllI24OIKO1D3CoTpU+YJNSYX4IGMVn7Ycvb/h1c5SOJH7O
	IMQLakN3MHJGSdpNRUAmk7qy2tcInKn2VGldxHbzNHH8v+ZU4Ru9tOtnQGxZVfLB9VFPBYfGb2J
	iiyxwT45P8kc4IdqQK+Tydya+aFRT0hR+lXOEAm+Rmles2AOFgPjfJ1NU4gs0CrBtzWQhpYxVqi
	u7mryypQlshsrQ==
X-Received: by 2002:a05:6000:41fd:b0:47f:8ac0:282 with SMTP id ffacd0b85a97d-482b1fef313mr10255301f8f.17.1787153224185;
        Wed, 19 Aug 2026 08:27:04 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c45d1sm5420317f8f.30.2026.08.19.08.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 08:27:03 -0700 (PDT)
Message-ID: <3e9b65b9-1855-4186-baef-218020f78dae@suse.com>
Date: Wed, 19 Aug 2026 17:27:02 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] drivers/ata: Stop using 32-bit MSR interfaces
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-5-jgross@suse.com> <20260819144024.7479a0a6@pumpkin>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260819144024.7479a0a6@pumpkin>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4wSdS5PMi69JTqYVBuLUcmQE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4wSdS5PMi69JTqYVBuLUcmQE
Content-Type: multipart/mixed; boundary="------------Ts5l70damiqQAQNi07LgMvW0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Message-ID: <3e9b65b9-1855-4186-baef-218020f78dae@suse.com>
Subject: Re: [PATCH v2 04/13] drivers/ata: Stop using 32-bit MSR interfaces
References: <20260819102314.1499258-1-jgross@suse.com>
 <20260819102314.1499258-5-jgross@suse.com> <20260819144024.7479a0a6@pumpkin>
In-Reply-To: <20260819144024.7479a0a6@pumpkin>

--------------Ts5l70damiqQAQNi07LgMvW0
Content-Type: multipart/mixed; boundary="------------bnaKAMlWqNMZ6AzZlyZerVgm"

--------------bnaKAMlWqNMZ6AzZlyZerVgm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTkuMDguMjYgMTU6NDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gT24gV2VkLCAxOSBB
dWcgMjAyNiAxMjoyMzowNSArMDIwMA0KPiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+IHdyb3RlOg0KPiANCj4+IFRoZSAzMi1iaXQgTVNSIGludGVyZmFjZXMgcmRtc3IoKSBh
bmQgd3Jtc3IoKSBhcmUgcGxhbm5lZCB0byBiZQ0KPj4gcmVtb3ZlZC4gVXNlIHRoZSByZWxh
dGVkIDY0LWJpdCB2YXJpYW50cyBpbnN0ZWFkLg0KPj4NCj4+IEluIGRyaXZlcnMvYXRhL3Bh
dGFfY3M1NTM2LmMgZG9uJ3QgcmVkZWZpbmUgcmRtc3IoKSBhbmQgd3Jtc3IoKSBhcw0KPj4g
ZW1wdHkgbWFjcm9zIGZvciBhdm9pZGluZyBtaXN1c2UsIGJ1dCBndWFyZCB0aGUgYWZmZWN0
ZWQgY29kZSB2aWENCj4+IGEgc2ltcGxlICNpZmRlZi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+IFYyOg0KPj4g
LSBhdm9pZCBzaWduIGV4dGVuc2lvbiB3aGVuIHVzaW5nIHdybXNycSgpIChTYXNoaWtvIGJv
dCkNCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2F0YS9wYXRhX2NzNTUzNS5jIHwgMjAgKysrKysr
KysrKy0tLS0tLS0tLS0NCj4+ICAgZHJpdmVycy9hdGEvcGF0YV9jczU1MzYuYyB8IDE3ICsr
KysrKysrLS0tLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL3Bh
dGFfY3M1NTM1LmMgYi9kcml2ZXJzL2F0YS9wYXRhX2NzNTUzNS5jDQo+PiBpbmRleCBkNzkz
ZmM0NDFiNDYuLmUxNmM3ZjRjN2MyNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYXRhL3Bh
dGFfY3M1NTM1LmMNCj4+ICsrKyBiL2RyaXZlcnMvYXRhL3BhdGFfY3M1NTM1LmMNCj4+IEBA
IC05MCw3ICs5MCw3IEBAIHN0YXRpYyB2b2lkIGNzNTUzNV9zZXRfcGlvbW9kZShzdHJ1Y3Qg
YXRhX3BvcnQgKmFwLCBzdHJ1Y3QgYXRhX2RldmljZSAqYWRldikNCj4+ICAgCXN0YXRpYyBj
b25zdCB1MTYgcGlvX2NtZF90aW1pbmdzWzVdID0gew0KPj4gICAJCTB4RjdGNCwgMHg1M0Yz
LCAweDEzRjEsIDB4NTEzMSwgMHgxMTMxDQo+PiAgIAl9Ow0KPj4gLQl1MzIgcmVnLCBfX21h
eWJlX3VudXNlZCBkdW1teTsNCj4+ICsJdTMyIHJlZzsNCj4+ICAgCXN0cnVjdCBhdGFfZGV2
aWNlICpwYWlyID0gYXRhX2Rldl9wYWlyKGFkZXYpOw0KPj4gICANCj4+ICAgCWludCBtb2Rl
ID0gYWRldi0+cGlvX21vZGUgLSBYRkVSX1BJT18wOw0KPj4gQEAgLTEwMiwxNiArMTAyLDE2
IEBAIHN0YXRpYyB2b2lkIGNzNTUzNV9zZXRfcGlvbW9kZShzdHJ1Y3QgYXRhX3BvcnQgKmFw
LCBzdHJ1Y3QgYXRhX2RldmljZSAqYWRldikNCj4+ICAgCQljbWRtb2RlID0gbWluKG1vZGUs
IHBhaXJtb2RlKTsNCj4+ICAgCQkvKiBXcml0ZSB0aGUgb3RoZXIgZHJpdmUgdGltaW5nIHJl
Z2lzdGVyIGlmIGl0IGNoYW5nZWQgKi8NCj4+ICAgCQlpZiAoY21kbW9kZSA8IHBhaXJtb2Rl
KQ0KPj4gLQkJCXdybXNyKEFUQUNfQ0gwRDBfUElPICsgMiAqIHBhaXItPmRldm5vLA0KPj4g
LQkJCQlwaW9fY21kX3RpbWluZ3NbY21kbW9kZV0gPDwgMTYgfCBwaW9fdGltaW5nc1twYWly
bW9kZV0sIDApOw0KPj4gKwkJCXdybXNycShBVEFDX0NIMEQwX1BJTyArIDIgKiBwYWlyLT5k
ZXZubywNCj4+ICsJCQkJKHUzMilwaW9fY21kX3RpbWluZ3NbY21kbW9kZV0gPDwgMTYgfCBw
aW9fdGltaW5nc1twYWlybW9kZV0pOw0KPiANCj4gVGhhdCBjYXN0IGlzIGhvcnJpYmx5IHN1
YnRsZS4NCj4gUGVyaGFwcyBjaGFuZ2UgdGhlIGFycmF5IHRvIGJlIHUzMiBhbmQgc2hpZnQg
dGhlIHZhbHVlcyBpbiB0aGUgYXJyYXkgaW5pdGlhbGlzZXI/DQoNCkkgbGlrZSB0aGlzIGlk
ZWEuDQoNCkknbGwgc2VuZCBWMyBmb3IgdGhpcyBwYXRjaCBvbmx5IGFzIGEgcmVwbHkgdG8g
VjIgb2YgdGhpcyBwYXRjaC4NCg0KDQpKdWVyZ2VuDQo=
--------------bnaKAMlWqNMZ6AzZlyZerVgm
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------bnaKAMlWqNMZ6AzZlyZerVgm--

--------------Ts5l70damiqQAQNi07LgMvW0--

--------------4wSdS5PMi69JTqYVBuLUcmQE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmqFy0YFAwAAAAAACgkQsN6d1ii/Ey/0
ZAf/TKXD+o5DYr7i3yLgz2zVFQ5mD3Ex/mjkDWJlWve0QfAY8hQdEt6SMDba+bWaqQoYSv/lQhsI
zgk4k0q8utft1jKalx1V7Bqr8akg9+PjVhbXaiXlJHE7InfoOraEdDO3MlMa6uaj7FZ272hchpMa
mkTbU9vjJamvpWblXLayDe6MQx9/mfrMPAWgrrWa+FwroFQOoolgN4fC18A0qyN9+484K1EYgzeR
3fyHyVgBI3xd5YhTe/fq50dRAtyci3HBsSkm6ulli0pRuOK3JyMSs6Embg4CmbJ2fpd/rOuZnocx
wRjhGmzjm6vtaektq8W6NZKXwQ+8PpsdabRSttp+0g==
=/96a
-----END PGP SIGNATURE-----

--------------4wSdS5PMi69JTqYVBuLUcmQE--
