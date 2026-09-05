Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C224C06A
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788608338; cv=none; b=PbmJaTzw5jcHUOoNLJLnx9dR3SD8rTNeZXB1o+wgXDqJUin6yzAjSAWZW9+jowF1+z4+IW1TMq8uBaGZUP6QJCYwot+GqOM9rRtB/XIyrmjW+wlLDoSeJc//DO7M39Cc6DK/Qs2NfnNgpi8rmXCKEpgorNEpBBs6opXaFIkdEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788608338; c=relaxed/simple;
	bh=eelufCio3ajFbj0v4pcK9zPlboHobzfZh+K6niicKjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfk6TfibvftkWKBQ+lGena3n3Y5bOo3enPouKhpAl5Wy6XEyH7iFo7APfrgtkC4ZAnZEjDNICJhOGe15YbGJQnUx8O41izAKVlP1Cr5X+wF43rHkBJAzWFmzOuoPksx8dLFClG1pJVYDeov96sG7p4F81FTxwOQmHcEWTZ3fyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCnKH3OA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCnKH3OA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso1468102a12.0
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788608335; x=1789213135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJTgqTURHJILMT4uRM83+AU7uLG2hO9Xrjamyvkwg1Q=;
        b=iCnKH3OACUx09FGQK6R0OEyGIZdKUfYgR5aCC45FUguG68kU9Hm1uD40hyjjhY4nVS
         XszgVecvkofxbrL+ztZwlhDJDOXm+xQaCHdyeFE8XhCjPNLsoBXJiGHcGEyy9XlqYQSP
         mfBjT3GvWgtW8eNIIgd9fU2Zqe003mHiDdm4fuKJMHqDazwcINqUQQ7QTb/hdkwu0fLn
         R0xtC+SDryhlf1ry22Kf39NZuAq0K0B830Ogbxv9U2Bx5QV5dPOMkbOLvNlpg7/SlCwL
         EnQmgcnV8Bs9XIhbB2zfRxLjTMsNQEdqbXCBsnrWQPQBaiBKoBPXotiuHnukxixC+poS
         K8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788608335; x=1789213135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJTgqTURHJILMT4uRM83+AU7uLG2hO9Xrjamyvkwg1Q=;
        b=FyslFsXZ/IIAyeC6NioQFbPt4fyEOhMm0p4d75PvGzOv3LT92sAp0rcZu74aYqDTEI
         uGjtR7tzg0ljWCIdlXrLBwOYUdUBAi6MDp7cqutjTb6aubWbHXev5LLNie9NM/WZA6yE
         e4yHUQ9m0apzUiLoqF3JbWLrg1P3SM9yW0nklwAWBYEcb3ZXSkQ0GzM6pl4vPyIhrTr6
         atqN8WqGIWGNY5sHqwALNdV3arIdsEZ79ilpZU7uGrQpw83jwHP1w7VD+vgguQV1V2GJ
         B5fDk0qugPo8sJfpl762UILX8ZMqYgLHnh2GvmT4UzBkL2NySOvCuJrm9QPFZArBKfXg
         NOcw==
X-Forwarded-Encrypted: i=1; AKwUvBxUK1Cyu1vBkbzO3JdQRU8OhBUaqd78PtlbNMXimH7xqfu0kv5Vk9LPNV9mPJ0oQGhdlKnzB6Go9EM=@vger.kernel.org
X-Gm-Message-State: AFuF++lPJ8Wnv1mvzAfKI+9UYI2Qnz/KKl2MNcEE3zNP7zUYfymUfbET
	ubzou+287Kmk7Swu9cRvD5ASwYpayh6MXjoGvgwksyL7C6eAaKdN4lnN
X-Gm-Gg: AYBFou08+gZOTFL1ZjgDZdT+/DVUjmUKPEu8M1C9DBWxS4/sRYAKsg4jquZl1QtmKnR
	Ey5BEG3s+YymPFq3HWK0Wdo8rfAXw4hNV+XohQ8KnzhNlXq9qSukeCFpfvMdlHV+VK69teiGrzK
	hcnOSrxEJlbD068hC5JwsVO3KoIkOj2ZV1dubgZSYbHeHB/Zdm0vubeBst9Qzs+HToe1ob5k9/W
	nymcfYcg/ec7kH19KGFYBK0mnHLrTjd0yzI285lXV1RCJjGljbY9BgkUz/hhNF7uYofWdOlOyDc
	OqLg2lX4ZX9E53FviJscVu+OQB2ZY5BCiPR6upTX7b4MHeqeWisq0zWIwwrb2+m5hCUPnso3yTw
	3U4wDKJlAdSm5tkuP+bWlnKmrnr6Bcuy+UClMN8xMbmilur+Mnacm3+EHkhEVssOllc00CMzRBN
	7Lnpd75q3BWU1PjFFmtc6oDYDlEe6w9uePdkMDol+lSHAZAj4ofUgWH53kNCYymyu7yEmOFTZ40
	ELC
X-Received: by 2002:a17:90b:3149:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39b2618060cmr19540300a91.10.1788608334984;
        Sat, 05 Sep 2026 04:38:54 -0700 (PDT)
Received: from pve-storage.hammies.cc ([165.173.24.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae60891b2sm7148989a91.0.2026.09.05.04.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 04:38:53 -0700 (PDT)
From: Alvin Lim <alvinwylim@gmail.com>
To: mikael1022bzh@gmail.com,
	cassel@kernel.org,
	mario.limonciello@amd.com
Cc: roland.waltersson@netinsight.net,
	artmoty@gmail.com,
	linux-ide@vger.kernel.org,
	david.laight.linux@gmail.com,
	kernel@wantstofly.org
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Sat,  5 Sep 2026 19:38:48 +0800
Message-ID: <20260905113848.1397882-1-alvinwylim@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <178854093896.541085.18395405788748617410@gmail.com>
References: <178854093896.541085.18395405788748617410@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 04, 2026 at 11:55:38PM +0700, Mikael Etienne wrote:
> That would be particularly worth it for Alvin, since iommu=pt is
> insufficient for him while it is completely clean for me -- that is the
> only divergence between our reports.

There is no divergence, and the fault is mine. I owe the thread an
apology.

My writeup stated that iommu=pt is insufficient. I never tested it. I have
no data on iommu=pt on this machine in either direction, and I am not now
claiming the opposite either -- only that the statement was not mine to
make and should be disregarded wherever it has been read.

The cause was poor discipline in my own record keeping. My incident notes
recorded some things I had measured and some things I had picked up from
other people's reports about other hardware, and by the time I wrote them
up for publication the distinction had been lost. The published page then
read as though all of it were my own result. That is how an untested
claim ended up being cited on this list, and it is a fair description of
what went wrong.

I am cleaning that up now. The rewritten page contains only what I
personally tested and observed on this machine, plus an explicit section
listing what I did not test, so nobody has to guess which is which. The
previous version stays in git history rather than being quietly replaced.

What I actually observed
------------------------

  Controller : ASMedia ASM1166 [1b21:1166] rev 02, all 6 SATA bays
  Kernel     : 7.0.6-2-pve (Proxmox) at the time of the corruption
  IVHD       : AMD-Vi: Using global IVHD EFR:0x246577efa2054ada, EFR2:0x0

(Full platform details are at the end of this mail, in case they help
with deciding who tests what.)

Symptom, with the IOMMU enabled: silent non-deterministic read corruption
on every SATA disk. A single isolated read was often clean; six concurrent
reads of one file returned six different md5s. SMART clean, no link
resets, no MCE. NVMe on the same host was unaffected. On-disk data turned
out to be intact -- it was entirely a read-path problem.

The fix I applied was amd_iommu=off, and nothing else. The machine's RAM
was later changed, so it has now run under that single parameter at two
different physical address ranges:

  2026-06-17 -> 2026-08-01   45 days   32 GB   (30 GiB visible)
  2026-08-01 -> 2026-09-05   35 days   96 GB   (92 GiB visible)

Kernel error lines on this host, same grep either side of the fix:

  2026-06-15 -> 06-17 16:00   (~2.5 days)    4240
  2026-06-17 16:00 -> now     (80 days)         0

Zero corruption to date in both memory configurations.

One further correction I have to make, because it wrongly closed off a
test. My writeup said this part lacks GIOSup, so amd_iommu=pgtbl_v2 could
not work. I read that off the "Extended features" boot line and treated
the absence of the name there as absence of the feature. Decoding the
register instead, bit 48 (GIOSUP) and bit 4 (GT) are both set here, so on
my reading of amd_iommu_v2_pgtbl_supported() it should be available on
this box. I have not tested pgtbl_v2 either -- I have only established
that my stated reason for ruling it out was invalid.

What I did NOT test on this machine
-----------------------------------

  - iommu=pt
  - amd_iommu=pgtbl_v2
  - iommu.forcedac=1
  - any other kernel version
  - the 32-bit DMA quirk itself; no kernel was ever built with it
  - which DMA addresses were actually in play; never instrumented, so I
    cannot say whether the failing addresses were above or below 4 GB
  - any controller other than this ASM1166, and any non-AMD platform

I know the symptom, I know amd_iommu=off removes it, and I know this
controller handles physical addresses far above 4 GB without error. I do
not know the mechanism, and I should not have implied otherwise.

Accordingly, please treat my ASM1166 patch as withdrawn:

  https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/

I never built or ran a kernel with that quirk, and the submission did not
disclose that. Its premise -- that the controller cannot address above
4 GB -- is contradicted by the 80 days above.

The submission also carried a Fixes: tag naming commit 3bf614106094
("ata: ahci: add identifiers for ASM2116 series adapters"), together with
Cc: stable@vger.kernel.org. That Fixes tag was wrong, and I want to be
clear why rather than leave it as an assertion.

ahci_pci_tbl ends with a generic catch-all,
PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) -> board_ahci,
which is present in v5.10 and v6.1, both well before that commit. So the
ASM1166 already bound to board_ahci through the catch-all, and adding its
explicit ID did not change how it was handled. Nothing about DMA differed
before and after, so there was no regression for that commit to have
introduced.

That matters because of what the two tags do together: Fixes: is what the
stable tooling reads to decide which series a backport applies to, so with
Cc: stable@ beside it the pair would have aimed an untested patch at every
stable series containing that commit. Nothing came of it, because the
patch was never applied. It should not have been there all the same.

What I can offer as a test platform
-----------------------------------

Setting this out in full, so nobody has to reconstruct it from earlier
messages when deciding who should test what.

  Board      : AOOSTAR WTR MAX (6-bay mini NAS)
  CPU        : AMD Ryzen 7 PRO 8845HS (Zen 4)
  IOMMU      : AMD. EFR 0x246577efa2054ada, EFR2 0x0
               GIOSup (bit 48) and GT (bit 4) both set
  SATA       : one ASMedia ASM1166 [1b21:1166] rev 02, 6 ports,
               6 HDDs, 98 TB total, 2-3 TB free per filesystem
  NVMe       : present, on separate controllers, never affected
  OS         : Proxmox VE (Debian). Kernel 7.0.14-14-pve now;
               7.0.6-2-pve when the corruption happened
  Current    : running amd_iommu=off since 2026-06-17

What I do NOT have, so please do not wait on me for it: no JMicron
JMB582/585, no Intel or ARM IOMMU machine, and no SATA controller other
than this ASM1166. The JMB585-plus-Intel/ARM test asked for earlier in
this thread is not one I can run.

What I can do:

  - any boot parameter combination: amd_iommu=pgtbl_v2, iommu.forcedac=1,
    iommu=pt, or back to amd_iommu=off
  - older kernels from the Proxmox archive
  - build and run a custom kernel, if a patch needs testing
  - run the fio crc32c canary; there is room for a 256 GB canary and I can
    leave verification looping overnight

One constraint, stated up front rather than discovered later: this is a
live NAS and the affected controller carries real data, including a Ceph
OSD. Any test with the IOMMU re-enabled needs a scheduled window with the
filesystems unmounted and that OSD stopped. I would write the canary first
under amd_iommu=off, through the path I know is good, and then run
verify-only passes in the test configuration, so nothing is ever written
through a path under suspicion.

So: tell me which test would actually be useful and I will run it and
report the result either way, including a negative one. I would rather
spend the window on the question you want answered than guess at it.

Alvin Lim
