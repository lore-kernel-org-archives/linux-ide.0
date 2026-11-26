Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795694513;
	b=iP8XYWJhURCMZjN1fMjV+pWot7MIhH3eRigqMkwvpZsc7kAeYmjHYCA3XdGa8gt4yeol
	 9uQmK1ufnIJWA2ZC9CEWu0TKTeeF2xBnHGK0XRR9oypyXRsTQGCc7cSCYDJ/zGznNIkyG
	 bts+ZoAGc1KoY5Gts4hVjBYLMTJ0U1Y3g8Mk4P+xoDc+lCPWZ/m71j/rHdiDY1tMe/KC2
	 mB/DaFepqOHsNCyW51psM/nj5JSkpilCxBLbGrmlnc1bdocXLuY+ksJOFYjThnhGp250x
	 fuf3DhG1iog5BPFyGJ0aiPju/tkXO9juvzp1bT+DZ7mFLRJpXJowHlLZVX/MBFqmfyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=7AdkqyniGSbwiyC3GQ3NLQI/BDAOzyYlQk55pjTg0Uc=;
	b=vEMiEfnzfxqg21AlB8qCQH3BrpGKAC96BQNeNpsutUQ4uMNvUoFhrM3C6RuPZOspCK7z
	 Rl36yigSNSc3EB6Wc2Mcd6T4H1QazK6orpxp+u90JeQ8eO/OI+oVBGflDNA1ZwRdOGUSE
	 xpEzDGVrPBzlNj1p6PzWpu4cGzevKRojHZmLr9R7EPu1EgvJuqKOrUc/jaDycM+tDkf9U
	 sbM6Kf8J4YryfMAzE+wWNgg0v2HsNZXPUdR2r9/Clvsi64BJVmvNeqAcNx61Piqgh08Mw
	 NGHP6wJifKenerNBVfQMuZSda19cpFSfnaj58O63o9GlGgh5jNNDvtzNf+oVf49Q6mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVbVwR6J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D3606A327
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 12:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E35D3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVbVwR6J
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e46e449e8so4506137f8f.3
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 04:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795694511; cv=none;
        d=google.com; s=arc-20260327;
        b=XLELh5fNuqJYI5pUdV5wW1sD8XjiBD7HvN2PPI9GcacKxz5ZgFkVDX/kGWew+1y/+e
         +pJ2ETznpBXU0/eys9YNwV6JsIZJkRUMiY9j3/IFGIIzO7puxQC+hONRzdf/P2W5Hmi3
         hWzySA9MN1L1FVLdADaI+83tflD8fwJOoJuQldzrUtEbXnPpzokWdNhxIerpXXzDRTQY
         5pGPGdMYQ8ql8xhdmB+LRBalDzlfqEYBPjdP68BLiHKnCJnIsZQRChFaY/AabFYtgXgG
         go72NBdBsb3GRSEcw3FRu3xRJYDUybq6w69tkTO+lUoEAywXTVTq2Xze+MSxhmGWhnPM
         GQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7AdkqyniGSbwiyC3GQ3NLQI/BDAOzyYlQk55pjTg0Uc=;
        fh=rz2K8ijUj8oVK0DMi7YmkLfSBBWIY3m3po+5LlhSZ1E=;
        b=EcFE49qnTCphVMe+tB/+FVez4sD8U+XE2ABmAwSoqV8DSS1w5eNsH/xrkuRgAB1/lx
         9PzrRsKQ4bkYHNxTKcOODi+LksZgw+Ax851uWrcR8W1SvmxiZXL7gxy2v2lOD8Z8NXc1
         qekGPRrlVHdqjmH0LDm6TvkNqbOfWxmwsuY7mIDlzoPJtDIHvnYWQoq16qZB+7cWLfj/
         NCKS5YYPBhWz7ZMOdJOFnp82i2ngYENSnFU2PpKt6VQzQrHgEwibG0hLgNDnkkPdTVtS
         a3Q5beYDysXd2U+ZEFVBqq07pQ6ijhRNRoliTHB0gqvrNR6lYZW3QlD6hXmX4aU3r6cs
         X+kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795694511; x=1796299311; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AdkqyniGSbwiyC3GQ3NLQI/BDAOzyYlQk55pjTg0Uc=;
        b=PVbVwR6J3jM4h0J45cZ7LPVJtl5I027old7AyoFSoozrwvmgGIAoRasljiz9DuAWlr
         Gpg6hvU4mIvj+zWeLM0bXH2tr19LOwZDS6kS6qVXR3x3EheLg74TsO5JFsYuWq5MTw0i
         AGFxs/M9wAZINI2RYxoCDH83Puhc6whc5OqFsKWl0aCUSwq5uMT86C4NL8NGNvRDG/8K
         puyMpkS7yyWd9spQj7EllYQVPBB/7Jczmhb6a4sRTGpppoCS5ODW+Js7MbcHqKXbN6qA
         SKYxYzs4AtA+tr/snGh2mMs2yqqJXs0YaMfmbCn1DKSVBlWZuwDqvdHJwEHxDZ2hxjNE
         709Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694511; x=1796299311;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7AdkqyniGSbwiyC3GQ3NLQI/BDAOzyYlQk55pjTg0Uc=;
        b=c9f901BkIO2wu5HnAP1bKJJbkS5bD7ybnVJSr/d5BjtA0oLwkLJ4cd57gEc45hagI6
         hxQQJDU+XlS6E/WYPmJx18RbpoKXRi1/d13e3fRWdUHtIrs52qZEd3Y6g3v+r0VtQcZn
         QbarVSD7f+yXDGWMmTe2tl9eGb/XTUbcIN/zt3+5SSUUEQnp2fusp0vPN9W9O4Xlw+v+
         0YJJ+F6jZRopvxPxIb9qO/MUcY7xqi7lhyrMlwyumfSJUA8Up/bhW0g6L3Tmlr8Gi5g6
         XIDGrsrrqDfRepbG1FoWRbdaqLB7quqE8Dno82FtTO6H7V2E+BDPwUAtICE69SzFfcwl
         h4iQ==
X-Gm-Message-State: APuU4Z/jtmGUcZO6lbkr2roYgS6Ljcog+fckjIDDh8v0OGDXDAWSIv+y
	8MysvhbVtGIC/8o58LMxa2kjLFkOBw1almZZI4EjXVRfMVeFjsXalj5effWQVG/MDY5IsZqn6RZ
	J64LOhqTtvpiPdjHdH2r58MfzWX58p2FM//5PtBQ=
X-Gm-Gg: AZFdTZe8vthwCsUsenIgTuEWpjrVZZXSu9XBWpuq7PgFuXms/vEY5uMcHQiYwfXsysN
	fY2Oz7QzVLbTmzD88te95MpV5tKXvyPkMj/gK+HZ+J14kyThsJiAdDW/LEHNElzH9KDXnXNQ4tP
	OKk8Py6yF3nSftjZYsWVcXqM2VJZPYDfO1s4zG6UhosZzbE73RPxBE9wxlMCsqCP3ZX9CVkv1Kf
	4FFnGSUtU04R6m74HtiHxLw1nMUojcg1A1mBH+DlDHZQyGrwapF4IpXfPMSxDCe7eZQWgVHS00q
	VNtUktHQ6FTNDqsLCq1gGVvBCTo67EMak0hF+EgvuQKNfMxrg6an4wcPGUsWgrkP0505u/naanr
	qn9mQZUAt0gCeaUwEZl78CqizmgkqtcMaWZEFXQ==
X-Received: by 2002:adf:e014:0:10b0:4a7:7bec:e159 with SMTP id
 ffacd0b85a97d-4abb400bb4fmr30154780f8f.15.1795694510856; Thu, 26 Nov 2026
 04:01:50 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mohammad Harsij Sani <mohammadsaniac@gmail.com>
Date: Thu, 26 Nov 2026 15:31:38 +0330
X-Gm-Features: Aa3M54q2RjPTRGnaYpDsnkzIUEOujeO9AE9ok77YUyT4lD3kI7V5IkEgpVABdhM
Message-ID: <CACeOiPg=3_wY40upkFVkWQvJouomoTF6Ro+eL_DimkunYVSUFQ@mail.gmail.com>
Subject: [BUG] ata: libata-core: ADATA SU650 (XD0R3C0F) drops link / FPDMA
 timeouts with LPM enabled (fixed by libata.force=nolpm)
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello libata maintainers,

I would like to report a SATA Link Power Management (LPM) compatibility
issue on an ADATA SU650 SSD (firmware XD0R3C0F) that causes the drive to
drop off the SATA bus after a few minutes of uptime under Linux, and is
completely resolved by booting with `libata.force=1.00:nolpm`.

System information:
- Machine: LENOVO 81DC (BIOS 8RCN58WW 05/19/2021), Intel Core i3-7100U
- Distribution / Kernel: Arch Linux, Linux 7.3.5-arch1-1
- SATA Controller: 0000:00:17.0 [8086:9d03] (ahci, lpm-pol 3 /
med_power_with_dipm)
- SSD: ADATA SU650 (240 GB), Firmware XD0R3C0F (ata1.00, Features: DIPM)

ATA device, with non-removable media
Model Number:       ADATA SU650
Serial Number:      2N16291S4S2U
Firmware Revision:  XD0R3C0F
Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions,
SATA Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
Used: unknown (minor revision code 0x0028)
Supported: 10 9 8 7 6 5
Likely used: 10
Configuration:
Logical max current
cylinders 16383 16383
heads 16 16
sectors/track 63 63
--
CHS current addressable sectors:    16514064
LBA    user addressable sectors:   268435455
LBA48  user addressable sectors:   468862128
Logical  Sector size:                   512 bytes
Physical Sector size:                   512 bytes
Logical Sector-0 offset:                  0 bytes
device size with M = 1024*1024:      228936 MBytes
device size with M = 1000*1000:      240057 MBytes (240 GB)
cache/buffer size  = unknown
Form Factor: 2.5 inch
Nominal Media Rotation Rate: Solid State Device

00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-LP
SATA Controller [AHCI mode] [8086:9d03] (rev 21)
Subsystem: Lenovo Device [17aa:3868]
Kernel driver in use: ahci
Kernel modules: ahci

Symptoms without `nolpm`:
1. The system boots cleanly at 6.0 Gbps (SATA link up 6.0 Gbps) and runs
   normally for roughly 2 to 6 minutes.
2. Under normal/light I/O, ata1 logs `SErr 0x50000 { PHYRdyChg CommWake }`,
   `READ FPDMA QUEUED` / `WRITE FPDMA QUEUED` timeouts, and `action 0x6 frozen`.
3. `ata1: reset failed, giving up` occurs, followed by
`hostbyte=DID_BAD_TARGET`,
   `Aborting journal on device sda2-8`, and Input/output errors across all
   partitions on sda (both on the installed OS and on a recent Arch live USB).
4. SMART counters on the drive remain completely clean (0 reallocated,
   uncorrectable, program/erase fail, and UDMA CRC errors; 97% remaining life),
   and Windows 11 dual-boot on the exact same physical SSD works without issue.

Workaround / Verification:
Booting with `libata.force=1.00:nolpm` completely resolves the issue:

[Wed Nov 25 23:09:59 2026] ata1: SATA max UDMA/133 abar
m2048@0xb132d000 port 0xb132d100 irq 123 lpm-pol 3
[Wed Nov 25 23:09:59 2026] ata1: SATA link up 6.0 Gbps (SStatus 133
SControl 300)
[Wed Nov 25 23:09:59 2026] ata1.00: FORCE: modified (nolpm)
[Wed Nov 25 23:09:59 2026] ata1.00: ATA-10: ADATA SU650, XD0R3C0F, max UDMA/133
[Wed Nov 25 23:09:59 2026] ata1.00: 468862128 sectors, multi 1: LBA48
NCQ (depth 32), AA
[Wed Nov 25 23:09:59 2026] ata1.00: LPM support broken, forcing max_power
[Wed Nov 25 23:09:59 2026] ata1.00: Features: DIPM
[Wed Nov 25 23:09:59 2026] ata1.00: configured for UDMA/133

With `libata.force=1.00:nolpm`, the drive stays completely stable with zero
timeouts, resets, or I/O errors.

Please note that ADATA SU650 is known to ship with several different
controllers/firmware revisions (XD0R3C0F appears to be Realtek RTS5735DL),
so you may want to scope an ATA_QUIRK_NOLPM entry in
drivers/ata/libata-core.c to firmware "XD0R3C0F" or "ADATA SU650" as
appropriate. Happy to test any patch or provide additional logs if needed.

Best regards,
Mohammad Sani
