Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC31B4F02
	for <linux-ide@vger.kernel.org>; Mon, 20 Jan 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385713; cv=none; b=dEMJXscsc6yZgq5fbDoiKf5pEH4Z9hCWWiXnwdzafhQ0x4ler8Zpf/hVFg33v1prMmk+foTpiWgPh+prZb5jmoIqElvdsrzIFcOJCr3IknCDXzSaJUhTacEfGGV4AGXDhOib9F/nQEzfg5MA6A7Q7y5zmxgPuoirh4no5hvsUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385713; c=relaxed/simple;
	bh=uHh3fAiNaMRX6jhLGe/z9gvDInzLl+QzA8pzx31Ml20=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=jo/dlO7uX88vHBFz9koV0Nh3kJA+A4GYUSU1uDQntzhmNkGnz+hNgvSKQ5fQcDWKj9Cxr9laCBQ6T3tavUaxAONGJqisUf0bC5u6PeqG9O7x7W1iN1xCODaMPC/1nIgAqJ0c6Ho0js1mtdwWNf4c8RyUMt2bb9VKTXs21otwwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YuTTurEp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YuTTurEp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Cc:From:References:To:
	Subject:Reply-To:MIME-Version:Date:Message-ID:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iREdaoKsqudnnoWIzw52B6h0J8wS4bxYa8QYukOay8A=; b=YuTTurEp7+56flaQy/Glyzl7Xy
	EStukpNP7XhUTnNuIAicBPk/CZpbI5WPU4WHwYNgSArJwK7JnBetRg0KNMn67G0Nbghb6N1klVm5c
	slDAKrLM2gOXuXn+vXx34gtdlOTPt8E4exijfZRvMt01JBkjuEw+nzNW7WkvtvgDclH30GsoYroCu
	LYEtIcbGv1uLdx7/8UIPIx2yIWIuudB5Gk+YW+yHrHT45esutclb75jGTFOgUYSP+GFjNW5RuVr0e
	dWG9I9/LWjIC5sA62HsFvwSsr/Zo185rH9dfOhv8r/xNax8noXFB0zERZd6YdaGzPqtsUcj25fc9v
	wiskHGqw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <daniel@debian.org>)
	id 1tZtO3-0061sG-65; Mon, 20 Jan 2025 15:08:23 +0000
Content-Type: multipart/mixed; boundary="------------FbMl9upNZd0YqtwtWxFQzw4T"
Message-ID: <ac64a484-022c-42a0-95bc-1520333b1536@debian.org>
Date: Mon, 20 Jan 2025 16:08:16 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: daniel@debian.org
Subject: Re: [PATCH] Disabling link power-management on Samsung SSD 870 QVO
 drives to make them work.
To: Niklas Cassel <cassel@kernel.org>
References: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
 <Z45NEMKVAsxKvafa@ryzen>
Content-Language: en-US
From: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org
In-Reply-To: <Z45NEMKVAsxKvafa@ryzen>
X-Debian-User: daniel

This is a multi-part message in MIME format.
--------------FbMl9upNZd0YqtwtWxFQzw4T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 1/20/25 14:18, Niklas Cassel wrote:
>> I've added a new case for 870 QVO specifically as regular 870 don't have
>> the issue.
> 
> This should have been in the commit message.

thanks for the pointer, I have now adjusted the commit message.

> Out of curiosity, did you test on regular 870, so you know they are not
> broken as well?

we don't have many of non-QVO variants, but so far none of them has
needed it. I've added that to the commit message as well.

> You probably also want to add:
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org

added, thanks!

Updated patch attached.

Regards,
Daniel
--------------FbMl9upNZd0YqtwtWxFQzw4T
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ata-libata-core-Add-ATA_QUIRK_NOLPM-for-Samsung-SSD-.patch"
Content-Disposition: attachment;
 filename*0="0001-ata-libata-core-Add-ATA_QUIRK_NOLPM-for-Samsung-SSD-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmMmI0NGJhZjYwZDExODgyNjk2YTk5NDQ1YmYyMTdkNmVlNDA5OTAzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgQmF1bWFubiA8ZGFuaWVsQGRlYmlhbi5v
cmc+CkRhdGU6IFNhdCwgMTggSmFuIDIwMjUgMDY6MzY6NDMgKzAxMDAKU3ViamVjdDogW1BB
VENIXSBhdGE6IGxpYmF0YS1jb3JlOiBBZGQgQVRBX1FVSVJLX05PTFBNIGZvciBTYW1zdW5n
IFNTRCA4NzAgUVZPCiBkcml2ZXMKCkRpc2FibGluZyBsaW5rIHBvd2VyIG1hbmFnZW1lbnQg
b24gU2Ftc3VuZyBTU0QgODcwIFFWTyBkcml2ZXMKdG8gbWFrZSB0aGVtIHdvcmsgYWdhaW4g
YWZ0ZXIgdGhlIHN3aXRjaCBvZiB0aGUgZGVmYXVsdCBMUE0KcG9saWN5IHRvIGxvdy4KClRl
c3Rpbmcgc28gZmFyIGhhcyBzaG93biB0aGF0IHJlZ3VsYXIgU2Ftc3VuZyBTU0QgODcwCih0
aGUgbm9uIFFWTyB2YXJpYW50cykgZG8gbm90IG5lZWQgaXQgYW5kIHdvcmsgZmluZSB3aXRo
CnRoZSBkZWZhdWx0IExQTSBwb2xpY3kuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpG
aXhlczogNzYyN2EwZWRlZjU0ICgiYXRhOiBhaGNpOiBEcm9wIGxvdyBwb3dlciBwb2xpY3kg
Ym9hcmQgdHlwZSIpClNpZ25lZC1vZmYtYnk6IERhbmllbCBCYXVtYW5uIDxkYW5pZWxAZGVi
aWFuLm9yZz4KLS0tCiBkcml2ZXJzL2F0YS9saWJhdGEtY29yZS5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEv
bGliYXRhLWNvcmUuYyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMKaW5kZXggYzA4NWRk
ODFlYmU3Li42M2VjMmYyMTg0MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYXRhL2xpYmF0YS1j
b3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYwpAQCAtNDE0Myw2ICs0MTQz
LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXRhX2Rldl9xdWlya3NfZW50cnkgX19hdGFf
ZGV2X3F1aXJrc1tdID0gewogCXsgIlNhbXN1bmcgU1NEIDg2MCoiLAkJTlVMTCwJQVRBX1FV
SVJLX05PX05DUV9UUklNIHwKIAkJCQkJCUFUQV9RVUlSS19aRVJPX0FGVEVSX1RSSU0gfAog
CQkJCQkJQVRBX1FVSVJLX05PX05DUV9PTl9BVEkgfSwKKwl7ICJTYW1zdW5nIFNTRCA4NzAg
UVZPKiIsCU5VTEwsCUFUQV9RVUlSS19OT19OQ1FfVFJJTSB8CisJCQkJCQlBVEFfUVVJUktf
WkVST19BRlRFUl9UUklNIHwKKwkJCQkJCUFUQV9RVUlSS19OT19OQ1FfT05fQVRJIHwKKwkJ
CQkJCUFUQV9RVUlSS19OT0xQTSB9LAogCXsgIlNhbXN1bmcgU1NEIDg3MCoiLAkJTlVMTCwJ
QVRBX1FVSVJLX05PX05DUV9UUklNIHwKIAkJCQkJCUFUQV9RVUlSS19aRVJPX0FGVEVSX1RS
SU0gfAogCQkJCQkJQVRBX1FVSVJLX05PX05DUV9PTl9BVEkgfSwKLS0gCjIuNDUuMgoK

--------------FbMl9upNZd0YqtwtWxFQzw4T--
