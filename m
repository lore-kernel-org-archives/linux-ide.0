Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702D2F690F
	for <linux-ide@vger.kernel.org>; Wed,  8 Jul 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554277; cv=none; b=N55a+kWrqpeWcSDB1aoeWiDfaEv7LFwNUMNDWEzXiu5tkQ/YvBOmZD6HupQL21FsgdOBe0SQUUZ7QtqY755SqhJALHqU3SLwyZFnkDrEVGy+PuuiKDNCy8E2z3QHbu5jP1AZG0AthyBv4AI3md0J9mIWefDCBwGDnhzNRUJaXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554277; c=relaxed/simple;
	bh=WMAhI1lqJ8/W7eFmSpiLOEDpfPqjGxF8ElCpXJdcgTQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=XCA2WyUxVLJfmYks/5N5ffz+ReJDI31aT9B8VXVKj2ZRmcug+aZdM6U1YmdE5DUf/LDleczcGTIEShSBvaLwwPODkNfydzRcfOpe4pekNh3xgZwYRLKn4Y92V1L+4qJRpruO+HzaFtKtOXzYtgu8GGCj9OSd8ndPziAhVN9W2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFTAKlUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFTAKlUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E691F000E9;
	Wed,  8 Jul 2026 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783554275;
	bh=lIHPrPvtH1Nd5Qe4ng82URyyaDM9FtDF8U3A+lBErXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eFTAKlURCB8Z45H+T/nWz0mY0dZvo9PTtsRh3VXf0P2fTTt1QLqy3BfPZ8kkRl5Nd
	 diGaWDv/VMzg5io0GXnyqVVoDbkmBl3pLoPfIZq8YL6e32qfrBH8qFaVyyo8IXAX3t
	 5e4r3ezo2WaorGyuEQgMtd7l06tD4cO+YzDz7TVmzmbU9nAuO3IsMV9KZt0Ltfo5gU
	 3ZOMNc1+8UkFzprOCLq2p0fhI6zOZbmI0ih8lMErkVT1+kMlugGdpciLNT/IxK0vof
	 OfiN609Xq2TifWxFaNapExQfzH0GAxs0ohPghCzaDwby0rzvKG3gh+nt1agDHjhoF7
	 QcYRvYz0qPsUw==
Content-Type: multipart/mixed; boundary="------------8lS6wYHlIXWIlStLjFi0COnm"
Message-ID: <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>
Date: Thu, 9 Jul 2026 08:44:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260708193644.671852-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260708193644.671852-1-ipylypiv@google.com>

This is a multi-part message in MIME format.
--------------8lS6wYHlIXWIlStLjFi0COnm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 04:36, Igor Pylypiv wrote:
> Hi Damien,
> 
> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
> but ran ~10 or so seconds later. It seems like a recent regression from
> the introduction of deffered_qc.
> 
> When an active command times out while a non-NCQ command is waiting in
> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
> command's own timer expires.
> 
> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
> commands (1 timed-out + 1 in deferred_qc).
> 
> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
> the EH thread, deadlocking error recovery until the deferred command
> times out on its own.

Igor,

Can you try the attached diff ?
I will test on my end, but I need to hack something to trigger a timeout :)


-- 
Damien Le Moal
Western Digital Research
--------------8lS6wYHlIXWIlStLjFi0COnm
Content-Type: text/x-patch; charset=UTF-8; name="ata-timeout.diff"
Content-Disposition: attachment; filename="ata-timeout.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtc2NzaS5jCmluZGV4IDU4Njg1MjYzMDFhMi4uMTNhOGQyMzEyZjQxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jCisrKyBiL2RyaXZlcnMvYXRhL2xpYmF0
YS1zY3NpLmMKQEAgLTE3MzAsNiArMTczMCwyOCBAQCBzdGF0aWMgdm9pZCBhdGFfc2NzaV9z
Y2hlZHVsZV9kZWZlcnJlZF9xYyhzdHJ1Y3QgYXRhX2xpbmsgKmxpbmspCiAJCXF1ZXVlX3dv
cmsoc3lzdGVtX2hpZ2hwcmlfd3EsICZsaW5rLT5kZWZlcnJlZF9xY193b3JrKTsKIH0KIAor
ZW51bSBzY3NpX3RpbWVvdXRfYWN0aW9uIGF0YV9zY3NpX2VoX3RpbWVkX291dChzdHJ1Y3Qg
c2NzaV9jbW5kICpzY21kKQoreworCXN0cnVjdCBhdGFfcG9ydCAqYXAgPSBhdGFfc2hvc3Rf
dG9fcG9ydChzY21kLT5kZXZpY2UtPmhvc3QpOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisK
KwkvKgorCSAqIFdlIGhhZCBhIHRpbWVvdXQsIGVpdGhlciBmb3IgYW4gTkNRIGNvbW1hbmQg
b3IgZm9yIG9uZSBkZWZlcnJlZAorCSAqIHF1ZXVlZCBjb21tYW5kLiBFaXRoZXIgd2F5LCB3
ZSBtdXN0IHJlbGVhc2UgYWxsIGRlZmVycmVkIHF1ZXVlZAorCSAqIGNvbW1hbmQgc28gdGhh
dCBzY3NpIEVIIGNhbiB0cmlnZ2VyLgorCSAqLworCXNwaW5fbG9ja19pcnFzYXZlKGFwLT5s
b2NrLCBmbGFncyk7CisJYXRhX3Njc2lfcmVxdWV1ZV9kZWZlcnJlZF9xYyhhcCk7CisJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZShhcC0+bG9jaywgZmxhZ3MpOworCisJLyoKKwkgKiBMZXQg
c2NzaV90aW1lb3V0KCkga25vdyB0aGF0IGl0IG11c3QgY29udGludWUgd2l0aCBoYW5kbGlu
ZyB0aGUKKwkgKiB0aW1lb3V0IGFzIHdlIGluIGZhY3QgZGlkIG5vdCBkbyBtdWNoIGhlcmUu
CisJICovCisJcmV0dXJuIFNDU0lfRUhfTk9UX0hBTkRMRUQ7Cit9CitFWFBPUlRfU1lNQk9M
X0dQTChhdGFfc2NzaV9laF90aW1lZF9vdXQpOworCiBzdGF0aWMgdm9pZCBhdGFfc2NzaV9x
Y19jb21wbGV0ZShzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFjKQogewogCXN0cnVjdCBhdGFf
bGluayAqbGluayA9IHFjLT5kZXYtPmxpbms7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2xpYmF0YS5oIGIvaW5jbHVkZS9saW51eC9saWJhdGEuaAppbmRleCA5NmU2MjZkNmE3Y2Eu
LjMyN2RhNDNkNzQ5NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9saWJhdGEuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L2xpYmF0YS5oCkBAIC0xMTUzLDYgKzExNTMsNyBAQCBleHRlcm4g
aW50IGF0YV9zY3NpX2lvY3RsKHN0cnVjdCBzY3NpX2RldmljZSAqZGV2LCB1bnNpZ25lZCBp
bnQgY21kLAogI2VuZGlmCiBleHRlcm4gZW51bSBzY3NpX3FjX3N0YXR1cyBhdGFfc2NzaV9x
dWV1ZWNtZChzdHJ1Y3QgU2NzaV9Ib3N0ICpoLAogCQkJCQkgICAgIHN0cnVjdCBzY3NpX2Nt
bmQgKmNtZCk7CitlbnVtIHNjc2lfdGltZW91dF9hY3Rpb24gYXRhX3Njc2lfZWhfdGltZWRf
b3V0KHN0cnVjdCBzY3NpX2NtbmQgKmNtZCk7CiAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19B
VEEpCiBib29sIGF0YV9zY3NpX2RtYV9uZWVkX2RyYWluKHN0cnVjdCByZXF1ZXN0ICpycSk7
CiAjZWxzZQpAQCAtMTQ2NCw2ICsxNDY1LDcgQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgKmF0YV9jb21tb25fc2Rldl9ncm91cHNbXTsKIAkuaW9jdGwJCQk9IGF0
YV9zY3NpX2lvY3RsLAkJXAogCUFUQV9TQ1NJX0NPTVBBVF9JT0NUTAkJCQkJXAogCS5xdWV1
ZWNvbW1hbmQJCT0gYXRhX3Njc2lfcXVldWVjbWQsCQlcCisJLmVoX3RpbWVkX291dAkJPSBh
dGFfc2NzaV9laF90aW1lZF9vdXQsCVwKIAkuZG1hX25lZWRfZHJhaW4JCT0gYXRhX3Njc2lf
ZG1hX25lZWRfZHJhaW4sCVwKIAkudGhpc19pZAkJPSBBVEFfU0hUX1RISVNfSUQsCQlcCiAJ
LmVtdWxhdGVkCQk9IEFUQV9TSFRfRU1VTEFURUQsCQlcCg==

--------------8lS6wYHlIXWIlStLjFi0COnm--
