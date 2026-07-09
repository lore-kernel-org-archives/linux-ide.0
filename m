Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831611CBA
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558875; cv=none; b=piqroKeo0wJTYcpRwgiSiO/u9isoOstGQiztHCsgrFPX3zK95ecigmVAa7pK8szb7tbiFtUuSrOhGNoNEQyHj4J4paHELFoUVmLIzyBH49NA+K8yB0otTzaODUH1GG7rGJro5uZRhOYm4+/eq1A803fBI0myhCT22JVjoWIO180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558875; c=relaxed/simple;
	bh=+1VopVDq6ZQuj/92vlJ6VLMd3sfCfsNgVvfG+W7cVkQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=JWUGqiqlUlFTp6dUmZVMUhGmLO+T+nLk95MHlNCGxF+zCcIHvs0BNE9x9FePA2izK0Z4tvdsHrC1CFYZrX86SqtafuK4V9ToS3B+bvDDxTUv178VsWwe8f1Z1k2o+fZ6OkRDdw6/CKmnntDHrv4HoQDaB/N2ZwUOyWBs5mA2J9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcqf4+0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcqf4+0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B601F00A3A;
	Thu,  9 Jul 2026 01:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783558873;
	bh=oPNWL++zLGIPcD3NeS5rI5tzPZE5Njx9HDc1tqQLZDI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=hcqf4+0snfZ/6dYNkiaqSqjD/aUARdJcDsoQnSuKN924l3peNBT65NMKaylSVYzuh
	 w5XtXCTiFwdsovZwlIko08vo3IrZLL2jygnqiV1HEgg+H4iRL5SRbUHCCNq5H7HDN6
	 7/tGa+n3SVm7Q5EKB5qYw/vhrqciwo/U6fAIyOyEMwqR+5hl+dRDeLKasIOTikn9Dz
	 fyaUrPcZtfprBF00mtWmgLIlyNh1F2b9vACfC0K6spA3/AhcVwnGnp1pKi/65OjfWe
	 Hp9nNzy8XGljBhey+fvAK2c1TU0eMXN32e6kqgD3VdPehzHkB+hV12w4mU0/7N4h8j
	 w/4slKnnIeNaw==
Content-Type: multipart/mixed; boundary="------------XsMnjw60dfHILy9CGBq1wCeV"
Message-ID: <26dbfbdd-4f9d-4a5f-8f61-a3bb7c457f50@kernel.org>
Date: Thu, 9 Jul 2026 10:01:11 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
From: Damien Le Moal <dlemoal@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260708193644.671852-1-ipylypiv@google.com>
 <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>

This is a multi-part message in MIME format.
--------------XsMnjw60dfHILy9CGBq1wCeV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 08:44, Damien Le Moal wrote:
> On 7/9/26 04:36, Igor Pylypiv wrote:
>> Hi Damien,
>>
>> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
>> but ran ~10 or so seconds later. It seems like a recent regression from
>> the introduction of deffered_qc.
>>
>> When an active command times out while a non-NCQ command is waiting in
>> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
>> command's own timer expires.
>>
>> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
>> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
>> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
>> commands (1 timed-out + 1 in deferred_qc).
>>
>> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
>> the EH thread, deadlocking error recovery until the deferred command
>> times out on its own.
> 
> Igor,
> 
> Can you try the attached diff ?
> I will test on my end, but I need to hack something to trigger a timeout :)

Hacking libahci to trigger a timeout for a particular LBA read, I tested the
attached v2 and I see the deferred QC running right after the read command
timeout. So this looks like a good fix to me. Can you test please ?

-- 
Damien Le Moal
Western Digital Research
--------------XsMnjw60dfHILy9CGBq1wCeV
Content-Type: text/x-patch; charset=UTF-8; name="ata-timeout-v2.diff"
Content-Disposition: attachment; filename="ata-timeout-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtc2NzaS5jCmluZGV4IDU4Njg1MjYzMDFhMi4uNTIyMWQ3MDA0YzBlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jCisrKyBiL2RyaXZlcnMvYXRhL2xpYmF0
YS1zY3NpLmMKQEAgLTE2ODUsNyArMTY4NSw4IEBAIHZvaWQgYXRhX3Njc2lfZGVmZXJyZWRf
cWNfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZShhcC0+bG9jaywgZmxhZ3MpOwogfQogCi12b2lkIGF0YV9zY3NpX3JlcXVldWVfZGVm
ZXJyZWRfcWMoc3RydWN0IGF0YV9wb3J0ICphcCkKK3N0YXRpYyB2b2lkIGF0YV9zY3NpX2Rv
X3JlcXVldWVfZGVmZXJyZWRfcWMoc3RydWN0IGF0YV9wb3J0ICphcCwKKwkJCQkJICAgIHN0
cnVjdCBzY3NpX2NtbmQgKnRpbWVkX291dF9zY21kKQogewogCXN0cnVjdCBhdGFfbGluayAq
bGluazsKIApAQCAtMTY5OCwxNSArMTY5OSwyNyBAQCB2b2lkIGF0YV9zY3NpX3JlcXVldWVf
ZGVmZXJyZWRfcWMoc3RydWN0IGF0YV9wb3J0ICphcCkKIAkgKi8KIAlhdGFfZm9yX2VhY2hf
bGluayhsaW5rLCBhcCwgUE1QX0ZJUlNUKSB7CiAJCXN0cnVjdCBhdGFfcXVldWVkX2NtZCAq
cWMgPSBsaW5rLT5kZWZlcnJlZF9xYzsKKwkJdTMyIGhvc3RfYnl0ZTsKIAotCQlpZiAocWMp
IHsKLQkJCWxpbmstPmRlZmVycmVkX3FjID0gTlVMTDsKLQkJCWNhbmNlbF93b3JrKCZsaW5r
LT5kZWZlcnJlZF9xY193b3JrKTsKLQkJCWF0YV9zY3NpX3FjX2RvbmUocWMsIHRydWUsIERJ
RF9SRVFVRVVFIDw8IDE2KTsKLQkJfQorCQlpZiAoIXFjKQorCQkJY29udGludWU7CisKKwkJ
bGluay0+ZGVmZXJyZWRfcWMgPSBOVUxMOworCQljYW5jZWxfd29yaygmbGluay0+ZGVmZXJy
ZWRfcWNfd29yayk7CisKKwkJaWYgKHFjLT5zY3NpY21kID09IHRpbWVkX291dF9zY21kKQor
CQkJaG9zdF9ieXRlID0gRElEX1RJTUVfT1VUOworCQllbHNlCisJCQlob3N0X2J5dGUgPSBE
SURfUkVRVUVVRTsKKwkJYXRhX3Njc2lfcWNfZG9uZShxYywgdHJ1ZSwgaG9zdF9ieXRlIDw8
IDE2KTsKIAl9CiB9CiAKK3ZvaWQgYXRhX3Njc2lfcmVxdWV1ZV9kZWZlcnJlZF9xYyhzdHJ1
Y3QgYXRhX3BvcnQgKmFwKQoreworCWF0YV9zY3NpX2RvX3JlcXVldWVfZGVmZXJyZWRfcWMo
YXAsIE5VTEwpOworfQorCiBzdGF0aWMgdm9pZCBhdGFfc2NzaV9zY2hlZHVsZV9kZWZlcnJl
ZF9xYyhzdHJ1Y3QgYXRhX2xpbmsgKmxpbmspCiB7CiAJc3RydWN0IGF0YV9xdWV1ZWRfY21k
ICpxYyA9IGxpbmstPmRlZmVycmVkX3FjOwpAQCAtMTczMCw2ICsxNzQzLDI4IEBAIHN0YXRp
YyB2b2lkIGF0YV9zY3NpX3NjaGVkdWxlX2RlZmVycmVkX3FjKHN0cnVjdCBhdGFfbGluayAq
bGluaykKIAkJcXVldWVfd29yayhzeXN0ZW1faGlnaHByaV93cSwgJmxpbmstPmRlZmVycmVk
X3FjX3dvcmspOwogfQogCitlbnVtIHNjc2lfdGltZW91dF9hY3Rpb24gYXRhX3Njc2lfZWhf
dGltZWRfb3V0KHN0cnVjdCBzY3NpX2NtbmQgKnNjbWQpCit7CisJc3RydWN0IGF0YV9wb3J0
ICphcCA9IGF0YV9zaG9zdF90b19wb3J0KHNjbWQtPmRldmljZS0+aG9zdCk7CisJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKKworCS8qCisJICogV2UgaGFkIGEgdGltZW91dCwgZWl0aGVyIGZv
ciBhbiBOQ1EgY29tbWFuZCBvciBmb3Igb25lIGRlZmVycmVkCisJICogcXVldWVkIGNvbW1h
bmQuIEVpdGhlciB3YXksIHdlIG11c3QgcmVsZWFzZSBhbGwgZGVmZXJyZWQgcXVldWVkCisJ
ICogY29tbWFuZCBzbyB0aGF0IHNjc2kgRUggY2FuIHRyaWdnZXIuCisJICovCisJc3Bpbl9s
b2NrX2lycXNhdmUoYXAtPmxvY2ssIGZsYWdzKTsKKwlhdGFfc2NzaV9kb19yZXF1ZXVlX2Rl
ZmVycmVkX3FjKGFwLCBzY21kKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKGFwLT5sb2Nr
LCBmbGFncyk7CisKKwkvKgorCSAqIExldCBzY3NpX3RpbWVvdXQoKSBrbm93IHRoYXQgaXQg
bXVzdCBjb250aW51ZSB3aXRoIGhhbmRsaW5nIHRoZQorCSAqIHRpbWVvdXQgYXMgd2UgaW4g
ZmFjdCBkaWQgbm90IGRvIG11Y2ggaGVyZS4KKwkgKi8KKwlyZXR1cm4gU0NTSV9FSF9OT1Rf
SEFORExFRDsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKGF0YV9zY3NpX2VoX3RpbWVkX291dCk7
CisKIHN0YXRpYyB2b2lkIGF0YV9zY3NpX3FjX2NvbXBsZXRlKHN0cnVjdCBhdGFfcXVldWVk
X2NtZCAqcWMpCiB7CiAJc3RydWN0IGF0YV9saW5rICpsaW5rID0gcWMtPmRldi0+bGluazsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbGliYXRhLmggYi9pbmNsdWRlL2xpbnV4L2xp
YmF0YS5oCmluZGV4IDk2ZTYyNmQ2YTdjYS4uMzI3ZGE0M2Q3NDk2IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2xpYmF0YS5oCisrKyBiL2luY2x1ZGUvbGludXgvbGliYXRhLmgKQEAg
LTExNTMsNiArMTE1Myw3IEBAIGV4dGVybiBpbnQgYXRhX3Njc2lfaW9jdGwoc3RydWN0IHNj
c2lfZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBjbWQsCiAjZW5kaWYKIGV4dGVybiBlbnVt
IHNjc2lfcWNfc3RhdHVzIGF0YV9zY3NpX3F1ZXVlY21kKHN0cnVjdCBTY3NpX0hvc3QgKmgs
CiAJCQkJCSAgICAgc3RydWN0IHNjc2lfY21uZCAqY21kKTsKK2VudW0gc2NzaV90aW1lb3V0
X2FjdGlvbiBhdGFfc2NzaV9laF90aW1lZF9vdXQoc3RydWN0IHNjc2lfY21uZCAqY21kKTsK
ICNpZiBJU19SRUFDSEFCTEUoQ09ORklHX0FUQSkKIGJvb2wgYXRhX3Njc2lfZG1hX25lZWRf
ZHJhaW4oc3RydWN0IHJlcXVlc3QgKnJxKTsKICNlbHNlCkBAIC0xNDY0LDYgKzE0NjUsNyBA
QCBleHRlcm4gY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCAqYXRhX2NvbW1vbl9zZGV2
X2dyb3Vwc1tdOwogCS5pb2N0bAkJCT0gYXRhX3Njc2lfaW9jdGwsCQlcCiAJQVRBX1NDU0lf
Q09NUEFUX0lPQ1RMCQkJCQlcCiAJLnF1ZXVlY29tbWFuZAkJPSBhdGFfc2NzaV9xdWV1ZWNt
ZCwJCVwKKwkuZWhfdGltZWRfb3V0CQk9IGF0YV9zY3NpX2VoX3RpbWVkX291dCwJXAogCS5k
bWFfbmVlZF9kcmFpbgkJPSBhdGFfc2NzaV9kbWFfbmVlZF9kcmFpbiwJXAogCS50aGlzX2lk
CQk9IEFUQV9TSFRfVEhJU19JRCwJCVwKIAkuZW11bGF0ZWQJCT0gQVRBX1NIVF9FTVVMQVRF
RCwJCVwK

--------------XsMnjw60dfHILy9CGBq1wCeV--
