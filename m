Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D742907
	for <linux-ide@vger.kernel.org>; Sat, 18 Jan 2025 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737179562; cv=none; b=bIqc0WM7aBGlTzX6tksDV0vArKJHokRsJtxxO0qgrk+g+gubTTvIIMlawgrb7cYgc6XKIqDj7f+nTAoLKxt1ahpcaj+TSkP5NTGVe/W+4EaCUDh1puaHm5LcVWOnh8NS7TIo3QxwNBj7PHKm8Ay2Kj6opLCR7jlAjXM5McAK9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737179562; c=relaxed/simple;
	bh=6Z/Lmn/R/f2osqu73iePApsYoIVEikT+q8EC6z2K2FQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=Yop8hBNA1cmborhjN3rFteeJUdOv07du3aYlUSq1OA/X5zN3K4HCGskNgy7dqjArtpQm2GmWv1cmbKl4I8iP5uS/lHX4fG0q5LDs1TSK0xXPE/mf2bUWYtpcN6jNb9uYCtcOOua/lJiI6rGuKruCSy++xZgcEF9gzmNOWus4MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=P6IiKKR5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="P6IiKKR5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Subject:From:To:Reply-To:MIME-Version:
	Date:Message-ID:Content-Type:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6Z/Lmn/R/f2osqu73iePApsYoIVEikT+q8EC6z2K2FQ=; b=P6IiKKR5bFu/3dr+xA/Tujgh8N
	T2WTfdnXU97/jjMHD4CwYQwYn4fsh0aEYMYVE4frDB9fcQnOjQxTt1Np5fCvQm0cMqzBB31wqa2s9
	GcENgS984GDLEsvXZTTY3QgMbYBUvMsLK3KrXRZBCol3Rpy2RYL/ArefGwHhGwFEg5YchCvwPsAaJ
	EutfSD1lsLJApL08lpx3sminRywrq/fFqF5eMp57sKsbXpM3yxH3MQnw7B8c6QFlvyDMzaywq/2uj
	sIIx8Nc7Nv09cDBO7nLcqT9X/J6Vfgn6zzou8yKZpuRPTMvBoSmkRTBBke76JNXZle+1n1S8QN08G
	0WfrgHiw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <daniel@debian.org>)
	id 1tZ1l2-0043NB-22
	for linux-ide@vger.kernel.org; Sat, 18 Jan 2025 05:52:32 +0000
Content-Type: multipart/mixed; boundary="------------AE9cqBvqSPiGmiBwTGzEYRMF"
Message-ID: <a421afd8-d841-4d3c-bfe9-9dee707bb319@debian.org>
Date: Sat, 18 Jan 2025 06:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: daniel@debian.org
Content-Language: en-US
To: linux-ide@vger.kernel.org
From: Daniel Baumann <daniel@debian.org>
Subject: [PATCH] Disabling link power-management on Samsung SSD 870 QVO drives
 to make them work.
X-Debian-User: daniel

This is a multi-part message in MIME format.
--------------AE9cqBvqSPiGmiBwTGzEYRMF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

since the kernel enabled LPM by default, Samsung 870 QVO SATA SSDs don't
work anymore. Disabling LPM for them solves it, please consider applying
the attached patch.

I've added a new case for 870 QVO specifically as regular 870 don't have
the issue.

[I'm not subscribed to the list, please CC on replies]

Regards,
Daniel
--------------AE9cqBvqSPiGmiBwTGzEYRMF
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Disabling-link-power-management-on-Samsung-SSD-870-Q.patch"
Content-Disposition: attachment;
 filename*0="0001-Disabling-link-power-management-on-Samsung-SSD-870-Q.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1NWUyY2IxMmZhYTQ4Y2Y0MjlhZDRhMjk5ZWE0ZTRhM2E5YmEyNWY1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgQmF1bWFubiA8ZGFuaWVsQGRlYmlhbi5v
cmc+CkRhdGU6IFNhdCwgMTggSmFuIDIwMjUgMDY6MzY6NDMgKzAxMDAKU3ViamVjdDogW1BB
VENIXSBEaXNhYmxpbmcgbGluayBwb3dlci1tYW5hZ2VtZW50IG9uIFNhbXN1bmcgU1NEIDg3
MCBRVk8gZHJpdmVzCiB0byBtYWtlIHRoZW0gd29yay4KClNpZ25lZC1vZmYtYnk6IERhbmll
bCBCYXVtYW5uIDxkYW5pZWxAZGViaWFuLm9yZz4KLS0tCiBkcml2ZXJzL2F0YS9saWJhdGEt
Y29yZS5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hdGEvbGliYXRhLWNvcmUuYyBiL2RyaXZlcnMvYXRhL2xpYmF0
YS1jb3JlLmMKaW5kZXggYzA4NWRkODFlYmU3Li42M2VjMmYyMTg0MzEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvYXRhL2xpYmF0YS1jb3JlLmMKKysrIGIvZHJpdmVycy9hdGEvbGliYXRhLWNv
cmUuYwpAQCAtNDE0Myw2ICs0MTQzLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXRhX2Rl
dl9xdWlya3NfZW50cnkgX19hdGFfZGV2X3F1aXJrc1tdID0gewogCXsgIlNhbXN1bmcgU1NE
IDg2MCoiLAkJTlVMTCwJQVRBX1FVSVJLX05PX05DUV9UUklNIHwKIAkJCQkJCUFUQV9RVUlS
S19aRVJPX0FGVEVSX1RSSU0gfAogCQkJCQkJQVRBX1FVSVJLX05PX05DUV9PTl9BVEkgfSwK
Kwl7ICJTYW1zdW5nIFNTRCA4NzAgUVZPKiIsCU5VTEwsCUFUQV9RVUlSS19OT19OQ1FfVFJJ
TSB8CisJCQkJCQlBVEFfUVVJUktfWkVST19BRlRFUl9UUklNIHwKKwkJCQkJCUFUQV9RVUlS
S19OT19OQ1FfT05fQVRJIHwKKwkJCQkJCUFUQV9RVUlSS19OT0xQTSB9LAogCXsgIlNhbXN1
bmcgU1NEIDg3MCoiLAkJTlVMTCwJQVRBX1FVSVJLX05PX05DUV9UUklNIHwKIAkJCQkJCUFU
QV9RVUlSS19aRVJPX0FGVEVSX1RSSU0gfAogCQkJCQkJQVRBX1FVSVJLX05PX05DUV9PTl9B
VEkgfSwKLS0gCjIuNDUuMgoK

--------------AE9cqBvqSPiGmiBwTGzEYRMF--
