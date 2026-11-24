Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795543707;
	b=vJbsSw97suMtqeA96XgSHjuX7FVUMlS4FjNBIca9oKNwXwk2UQ7GCU+FkTjZKAkjwPcL
	 Tvh1TUdHOh/L/X9Wu+RumaqSnYSNQE2zRvjzDtA1SceMhdeNvF92F9BXEFeBP45b3m0nc
	 XTzPOmuj9yZ/qy0lrCqAdAx+nGTPFyJ1253qtzskblaieuye81gkQBR3T59rAgicM2JOt
	 HHJXixm7e+evVpZzxr5U3Mew7qh1ucYlecVYJ1DALWG2DChW++uAh06YNo2Nb9NU16zKv
	 YoSUp9wiQ4kG7ESe2nn4YNsO1YcO4Fl3aiZZ4Gn0InwHuD2LRGlk9jNsG5CcK06wizw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
	b=NHoCEtGcZZNDCioFNGGQKlz6I9hTrVcZJCvYA5XBReCVnWLYQ7m7AP2BQ2LkQK6MAqCH
	 SiYOUi4tewIBziLnuOpTUx+Iml6CIGSN4ozAg7BNRH/PaVST4HrWfNRLABueCF2X3tShQ
	 8BGz+mXLgz4sHf4hya+O90LxZlvG3cF7a/Mfd3EMhQVYZDmVY4WWLkDMA1vhKqFm46mKt
	 yeWHRdb4JGTod697pOilm4/9cl2oN6zEl45iG5DuxMXYwQlPEPvSzRuTfuE+IduiHk9Xg
	 TP3aGG+hxrovu4p9HmsWfXLYjtsuKOCxzb/ZnEGZ4LBO59VOc/AwdXPNwXO2hEvsK8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Iri7dSH/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47D606A33B
	for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A47D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iri7dSH/
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so8120354c88.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Nov 2026 10:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795543706; cv=none;
        d=google.com; s=arc-20260327;
        b=GebwQC3cuuqR7eKQFxQ3mYvILRR99BSfdt1jWf/10qb1q/V6mPElTigiWAGQSL2y6e
         TdFMoZEPePbaWjGofikMkrJwzBi8ph9BTbtXHHNHPKt/DMoqdgnZUuo7FeEYp2iXGQRt
         g/EOivm0DuFrvvOY1EUMrMVdUZSZHNm0Yxmg3gztQjsx+ojkDLzJ7ehmSCAU7VzIQQ2h
         CqhjpwbGYsAHbtB8vxva1ZOO80Tyk7B9xXvx25DVCwvSc8zc/IfdSVgg5mwDI8YCKUIw
         1FIToMvks5+L30Cn7Tv+LaSSoUg6p0zxLRDOFcBkl8XL4PIoGPitosT01FKkm83+9y77
         nWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        fh=ouGqyxWKn0RS6bIRvalIm4vfUI50POsiIUuIoarOp6Q=;
        b=YZNxxCU13SjZ9iLYiu68W4dn8h39gHKJEQEhhA6ubf8SkeGY0WrYD5QfxaFEdCBrcD
         Ysbl/jnwNri1N64XVnJRq2OhhPY8QwmHC8bY5+v347OqqNArQtqkR/Uvj0D4dEPdhVA1
         zl7LRldqBAqOPCClNylQ46XZ9At/TIcX5BdLYvHLnYzJsoW7u0BXpEjP+uPy/L3gUn49
         BztT9P3cSHuA2vbqJwQzxOTBJUpVtkWBbgw0pZ+Pr5EqEK29Cgo9Q0ZI1cGM0gSOl/V4
         knD+l2hWm7gH34YJu5d+6CI947+ZyLYp4Kb2yl9ZEh3CE6YLD0LUZUho7a8Bnh38NAso
         hlIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795543706; x=1796148506; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        b=Iri7dSH/Hz7a13j1fDZ2A6+mUI/bg45FVd7r/FB3BtOvVlWPf9Su6zxIXrrHPsjjaw
         o+jWbSqLcTk+qACTkHLiZ8RVcD9D+FwjC6ctQDfz9yRnLgYF+Wru5cP46Rk2AfgltrSX
         dc5ZzY7MS3Z3Qh+ro+yQLwfsawxgs2bnyFoslrhwbDsWXLoo7GDOhsp0Lk/fdlFVm2RU
         4DOjUBRCxLgq9ElcDdjnyLpjTpfINngV6+32qeIibuQjY3cpgx0mxom1Qlxz4iHsh9ij
         UNylWnpBEjsHDqVPTa/dvjVGmuceGW1zl2g1YSEP/WZDxLd1ihc5QQZRiLwI4O+W9TVE
         dlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543706; x=1796148506;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nMArKgXUq1QdbGtgFkpPLn7kMqNxxKYfOey9dGs4DsM=;
        b=LrqVNcrgruyahxeUp+Bc97T6+h2zdbjC3t+LWPHNrvobiPxCmDroz8G8i0S92/EYMn
         O2pHD3sh0WXTmOTvupGvxp/togUxoVK/aed9xOFWBXPDpO5uSy6PWIK9FJVQ/U/G1HM3
         uJGGi9zOuqr0M3T/CA/hrI24yEht/o/92Kx3EwfaFKdGE91iN16W7i8rPsfigSwN/lA9
         z69Q7RYaoJYklG5dd+p4UeoQ33dMYZFri2L74DCNf8s1g38utSo1PP18TCE7WukPYrYt
         v6zgQ+P/wGSaZdgSMQIYgc7SI1HJY4b3why06D5sB0dN3fxFgcZ/5FBw3v9Ct57jOAS4
         Pi1w==
X-Forwarded-Encrypted: i=1; AL+hErFcqSHiaBnavijt/2fjKsMOBh2u2JnVjiFtyRCJ0zBSB2Itu1vGe0IwU4NhUq9ZpFdAepeTvvum9T4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sS8/Bqx+9j23ikuDo1OwmxYyqkZ9gvsqoXi4HD42eI8Fj1ids
	ZyV3bGXa4GMkBJahuSRpL6Ch645zgLEWNP4eMBvs5ndu38gQemWjgvJl223lnBaWF1uvZGpygUV
	1QGDqOj0jFPeCtzM5wCtzW5C5zYgACCws27fBTiPfdaCF
X-Gm-Gg: AZFdTZeRw+0zhePZ/zrOVFRcV3xLVbNhEUAUSwC2BTkZBJWX9KG+7FQAbEVXkpM7mRF
	xqSQy/9BhLydjMFyIvxGx8MIpdwiDJkdsEIiZfahv96y6WiHpDTBNrWEH1cH+3nLVawna37SG44
	ZdsovRyBfv8FubB6f+bMlQl5btC6vM+2E1tiuZOBcw/nnk/S7IRvHYAZIso+PR6TSdjjaDFkWJB
	clc4zex/k1Gv0DAQqDRvQHUWJ7tF5PPOXPrESqdyVqzWqVJ19EHptNxn7/IYALSD3H6DlEz2WOn
	ZFK5H5eIwQlKTxMgINjTuhigQTy8JAV855iSrsn5s4z5ULNUIID7wgMUPyjiyLUCFeXDCqYqvTG
	OC4OD/5o8vmWuLO4SOqxK/Ry+xl1CksejEX59
X-Received: by 2002:a05:693c:60d7:b0:386:a01f:a31e with SMTP id
 5a478bee46e88-386a01fa8a5mr11918162eec.29.1795543705646; Tue, 24 Nov 2026
 10:08:25 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Pe3k <pe3cek@gmail.com>
Date: Tue, 24 Nov 2026 19:08:13 +0100
X-Gm-Features: Aa3M54otumHZzTyMQ-Us0DWBLs1TljAZawi1sbF3vaHvMFbTD4Mkpwm8wiJeKc4
Message-ID: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
Subject: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
firmware declares for it. With the default translated DMA domain this
corrupts disk data on every boot under write load. iommu=pt avoids it.
Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.

Topology
--------
00:1f.0 ISA bridge [8086:1c54] and 00:1f.2 AHCI [8086:1c02] share IOMMU
group 10 (DMA-FQ), probed in that order. The group's reserved_regions
include "0xf1f7e000 0xf1f94fff direct". The DMAR RMRRs covering that
range list 00:1f.2 in their device scope, but not 00:1f.0.

6.12.118 (default cmdline)
--------------------------
Once per boot, ~20 min into sustained writes, 23 errors (21 + 2):

  DMAR: ERROR: DMA PTE for vPFN 0xf1f80 already set (to f1f80003 not 167119001)

from AHCI writeback (ata_qc_issue -> iommu_dma_map_sg). Each one is a
4 KiB page that reaches the disk with wrong content: mostly zeros, some
with firmware data from the RMRR. No I/O error is reported.

7.3.4 and 7.4-rc4 (default cmdline)
-----------------------------------
No DMAR errors. Instead 64-84 writes per boot fail before reaching the
device:

  ata2.00: failed command: WRITE FPDMA QUEUED
  ... res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x40 (internal error)

followed by I/O errors and 4-8 MiB of zeros in written files. In one
7.3.4 run the machine also took an NMI (iLO: "Unrecoverable System
Error (NMI)"). An iommu:map trace filtered to the RMRR shows the cause:

  map: IOMMU: iova=0x00000000f1f7e000 - 0x00000000f1f7e000
paddr=0x00000001c94d6000 size=0
   => iommu_map_nosync <= iommu_map_sg <= iommu_dma_map_sg
   <= dma_map_sg_attrs <= ata_qc_issue

With iommu=pt both 6.12 and 7.3.4 run clean.

Suspected cause (not verified in the source)
--------------------------------------------
The domain's IOVA reservations seem to come from the device that
initialises it (00:1f.0, no RMRR). When 00:1f.2 joins the domain, its
RMRRs are identity-mapped but never reserved in the IOVA allocator.

Reproducer
----------
Fresh boot, ext4 on an AHCI disk, 6 parallel cp of a 10 GiB random
file, sync, drop_caches, compare hashes. Fails within ~25 minutes.

I can test patches on a spare machine of this model. Full logs, the
DMAR table and traces are available on request.

I used Claude Code to run the tests, analyse the
logs and draft this report. The results and logs are from my own
machines, and I have reviewed the report.

Thanks,
Peter Nouza
