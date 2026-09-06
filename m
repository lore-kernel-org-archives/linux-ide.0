Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C587126C02
	for <linux-ide@vger.kernel.org>; Sun,  6 Sep 2026 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788722856; cv=pass; b=QUeNF8xJMeaT4fC8pohluf1Tio3k9pqZxaw4oj2syw9y90EJtsOdwYDOMpZvwqBcL8cZDsJn3e1spjgY08EgU/Kg0dOwj2n9xyf9Px6r7KInjIx0KSKMqFTG/kM5ouO37if51TPRNgcT6zjBbmVkQB5TpPW7Nw2uIo8Y7sfbq64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788722856; c=relaxed/simple;
	bh=5OweQGiTeJcs1LWIU4U2QP6BdkWLadqYP8WX0koz1/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9dBntC5PMwEW5BiO03v8toDLRgCPFEFIfO8pVIeD+kTsvbwOxQSvQiK70+Gv1FePc0Ou4J3ol6sR9xI01IVqjucRz7rgAq3q+QrEu79PDV7uK1a2Kq4zZT51lsg3K1Ky22uZ4s10n/AAHic9ZYyL81f3CFClot88LBEIQ0QQCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSD+851M; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSD+851M"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a1981228f8so23357971fa.1
        for <linux-ide@vger.kernel.org>; Sun, 06 Sep 2026 12:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788722852; cv=none;
        d=google.com; s=arc-20260327;
        b=oD6W2RG2MwuYW+t89EzAI3DQqwUS16Y88hFhcLM9zNWKjzClOCV7fuogjX1Z/mkLK0
         c12Rv9VWZXr4GtU61ssvoPO6HW90G6FwAEuHhV32oa4i9WSGiKFgQUoh2d/YjpYwrMJm
         KfE3jmOYSHQaO12MBRBAwD63M5AGfxRs+NeH32efsFPTfe/qKPFKrx+cYrONQUiZ8SiB
         lMwnPuTum7sYcMii/beIiXErTMn+UmC4ob47bUPmhKDvYXLJ2jGZX1IpRxXIaMcxLxn1
         ELJoaRu7TEbgvLyZABoFH/OZ7YQgOGXBCR/LORH/jHg2cxmf/6xYEPsx9Dzk2qz2VV/1
         MQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VukCt2X5KCLhroDMmTc/7bRt8mQvMO1+fqQxWh+08+I=;
        fh=rR4rJTl1Kz+kBS3v/HQSt0aVlXSSqzLPhkDVREhiwZ8=;
        b=Il8X2Um2prac+9V8ZZqbttajbiVpKmBmMF+JnPc09gcH9+hTkRp3yWozHp2LYOFCgB
         nmkABvOItVZZ9uYwnVOVhYDWuW+P5WQ3yA4fhSN2QAriqlNWOSMrRm8spjx2Tq2gQ4b2
         M4SVV0HTPkghe7TSZzBhWlTSaXzaWTtvDpB3iYry6RP9faliTqiCLlM4rMTk+Y5aj+9k
         wBEFKrngHxf8zmznROL2D81NPt4jP61WiI3QlNzJxev6+i/kCaAR8FzmbT1Whfdmjutq
         6rcoxQKg16R7rMBwLDg73Jz4GV2tHBelXh96gddVoRQAH3ayKXSfyuxo8RdcmHwezECH
         7LUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788722852; x=1789327652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VukCt2X5KCLhroDMmTc/7bRt8mQvMO1+fqQxWh+08+I=;
        b=kSD+851Mcqs0daSp9Sj2/FNgJlVH9oMphuPzTDZTHdyvoPhwxO8m0MzJOWhiO09uvT
         v14swu1PNPtPJQ45SB/7ZkuOyoU7l5YXj/ms9fJ7rofXpo6SdjprYOJBF5GxvKHl85cU
         eiT916QfwOaRWpiLyGAIroq2DhkxL9dWN28MHUpDP1GdnObGlbzaXYczh1TfXsG//lmO
         h65clVwZ57yh2RE5eLAxCbDDXWnjUZYrSpYLIktI0kJST+1v5zKKlMDMS7kCtAbe9RSM
         cu5J2v0TI3AjIcFWFVzee4vUcwGaNaYzd9F1+6lH+c2nnkHOsdVM7cmsQNOr4quiwN20
         V4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788722852; x=1789327652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VukCt2X5KCLhroDMmTc/7bRt8mQvMO1+fqQxWh+08+I=;
        b=iETfqY6eDe5zR/BG7mpzguARFS4K03tVBqYJewZlAci7Fsoovnq6wxMtCLqQGoe1Ix
         hhNFryhBqmqHpyMILyPsHgjSGOoVajM2pCfLKCHDqxTLCGCFBxX1RNBKOWdlEvhr6RFR
         ISxbSgU6rYX/KOLsfO/7FODNrIuDj+Xaq+cbs7jbOML8/1PVrBY6h9R8rI7cfXdoDbQP
         y1ztiPd3IIDz9WD9xlSDuPwdAl13HuVZr0W4uqAd66ihBBxIxG+fd1HCVA2351lawX7+
         yLTbwMEoDJQfLkPl4lNncL0CeuqtMUu4iDGQ6Vyzn421t52YiXKx2TzikcgX0CMzbxjF
         /96Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpg7Kb4xxK2Z0OLCzf0bNHZ+Ew2V1qlm41mxI9Lp0wIFLAjwH7wyHMHktT3Zc2S/xeHlQRjkepH4o=@vger.kernel.org
X-Gm-Message-State: AFuF++n9AMEeWNX/xPiEk+aus9ToAX4JBD7ygPDEVRDdTnAkM/obqGl9
	hKFSnAGoIscaM3VJFxtyM73j/n4P6g1M3QmKXWsSV5G6l099t79f3+KT+LWMJFSSOYRG9D9dIMI
	2FrN3ZdEpj/eHoXquRPHACuCPkpj/iUo=
X-Gm-Gg: AYBFou05dygThfpgbBwXapYdVDHtrST1V7EGmy3KtmhHJInivwtP6hRJsuesPBX+cQZ
	oJYnen9MIOWioNf7v7qQNW13cFkRDwr9WJ0PxReBpJ9dUUBopk3u5tps0QARn0+XNFQUmEOk2cu
	OzsuFKFSSyOLAPtcIhqRGng+2q9U59c3oBzBMd4KJigUzHY1zWyKrMuQrDpTJ6WOyhVX7rJOEF1
	BDipbfmcC87znCmR99UQkdyjjR0cfQ9dgkKMCjLHHAsgwKa5eQegJveSeD9M3lscQk3OstiKaH0
	gCaoEVZpbaRJgcM1I+fiVXIfENhOzBtH2HLqiBNxOK4yFoLeb3mGoG65ou0tVTAoQgmcZfqsY6p
	qnhjvDY+nRUhp89npWzDg9R1V
X-Received: by 2002:a2e:bc1f:0:b0:39a:d7f7:981d with SMTP id
 38308e7fff4ca-3a371bd88aemr20205641fa.12.1788722851521; Sun, 06 Sep 2026
 12:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178854093896.541085.18395405788748617410@gmail.com>
 <20260905113848.1397882-1-alvinwylim@gmail.com> <1c3df04b-7929-4b43-adb7-6007347a954e@amd.com>
 <20260906050501.1309388-1-alvinwylim@gmail.com>
In-Reply-To: <20260906050501.1309388-1-alvinwylim@gmail.com>
From: John Smith <imjohnsmith4000@gmail.com>
Date: Sun, 6 Sep 2026 22:27:20 +0300
X-Gm-Features: AcwNN1U1rTI5JTn3FGLiYTzmPjsXhJNMnzOhKZABmEjtdYio8WIEYKaZWVjVi8Q
Message-ID: <CAJ_jo9Sh07jNoAXk3zCPUq4XArxt8kgFdP8egMpNrCg+CFE-Ug@mail.gmail.com>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Alvin Lim <alvinwylim@gmail.com>
Cc: mario.limonciello@amd.com, mikael1022bzh@gmail.com, cassel@kernel.org, 
	roland.waltersson@netinsight.net, artmoty@gmail.com, 
	linux-ide@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel@wantstofly.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alvin, Mario,

second WTR MAX data point, same 13 registers, same procedure
(amd_smn_debugfs_enable=3D1, Mario's script, node 0):

  0x111401d0: 0x00000100
  0x111411d0: 0x00000100
  0x111421d0: 0x00000000
  0x111431d0: 0x00000100
  0x111441d0: 0x00000100
  0x112401d0: 0x00000100
  0x112411d0: 0x00000100
  0x112421d0: 0x00000100
  0x112431d0: 0x00000100
  0x112441d0: 0x00000100
  0x112451d0: 0x00000100
  0x113401d0: 0x00000100
  0x114401d0: 0x00000100

Byte-identical to Alvin's readings, including 0x111421d0 =3D=3D 0x00000000,
so that value looks typical for this board rather than specific to his
unit. Read on kernel 7.0.14-11-pve (Proxmox), AMI BIOS 0.01 dated
2025-04-27, booted with iommu=3Dpt (IOMMU enabled, passthrough default
domain), not amd_iommu=3Doff. The box has stayed clean under iommu=3Dpt
since 2026-09-05 16:02 +03 with a 1 MiB O_DIRECT write/read canary every
5 minutes and no new "Using 64-bit DMA addresses" line.

lspci -ttvvnn:

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Phoenix Root
Complex [1022:14e8]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU [1022:1=
4e9]
           +-01.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy
Host Bridge [1022:14ea]
           +-01.1-[69]--
           +-01.2-[6a]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe
SSD Controller MAP1202 (DRAM-less) [1e4b:1202]
           +-01.4-[6b-6e]----00.0-[6c-6e]--+-03.0-[6e]----00.0  Global
Unichip Corp. Coral Edge TPU [1ac1:089a]
           |                               \-07.0-[6d]----00.0  Global
Unichip Corp. Coral Edge TPU [1ac1:089a]
           +-02.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy
Host Bridge [1022:14ea]
           +-02.2-[64]--+-00.0  Intel Corporation Ethernet Controller
X710 for 10GbE SFP+ [8086:1572]
           |            \-00.1  Intel Corporation Ethernet Controller
X710 for 10GbE SFP+ [8086:1572]
           +-02.3-[65]----00.0  Intel Corporation Ethernet Controller
I226-V [8086:125c]
           +-02.4-[66]----00.0  Intel Corporation Ethernet Controller
I226-V [8086:125c]
           +-02.5-[67]----00.0  ASMedia Technology Inc. ASM1166 Serial
ATA Controller [1b21:1166]
           +-02.6-[68]----00.0  Samsung Electronics Co Ltd NVMe SSD
Controller SM981/PM981/PM983 [144d:a808]
           +-03.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy
Host Bridge [1022:14ea]
           +-03.1-[04-63]--
           +-04.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy
Host Bridge [1022:14ea]
           +-08.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy
Host Bridge [1022:14ea]
           +-08.1-[01]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI]
Phoenix3 [1002:1900]
           |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI]
Radeon High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
           |            +-00.2  Advanced Micro Devices, Inc. [AMD]
Phoenix CCP/PSP 3.0 Device [1022:15c7]
           |            +-00.3  Advanced Micro Devices, Inc. [AMD]
Device [1022:15b9]
           |            +-00.4  Advanced Micro Devices, Inc. [AMD]
Device [1022:15ba]
           |            +-00.5  Advanced Micro Devices, Inc. [AMD]
Audio Coprocessor [1022:15e2]
           |            \-00.6  Advanced Micro Devices, Inc. [AMD]
Family 17h/19h/1ah HD Audio Controller [1022:15e3]
           +-08.2-[02]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Phoenix Dummy Function [1022:14ec]
           |            \-00.1  Advanced Micro Devices, Inc. [AMD] AMD
IPU Device [1022:1502]
           +-08.3-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD]
Phoenix Dummy Function [1022:14ec]
           |            +-00.3  Advanced Micro Devices, Inc. [AMD]
Device [1022:15c0]
           |            +-00.4  Advanced Micro Devices, Inc. [AMD]
Device [1022:15c1]
           |            \-00.5  Advanced Micro Devices, Inc. [AMD]
Pink Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1022:790b]
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:=
790e]
           +-18.0  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 0 [1022:14f0]
           +-18.1  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 1 [1022:14f1]
           +-18.2  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 2 [1022:14f2]
           +-18.3  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 3 [1022:14f3]
           +-18.4  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 4 [1022:14f4]
           +-18.5  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 5 [1022:14f5]
           +-18.6  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 6 [1022:14f6]
           \-18.7  Advanced Micro Devices, Inc. [AMD] Phoenix Data
Fabric; Function 7 [1022:14f7]

Happy to read any further registers or run a reproducer if that helps.

Thanks,
John Smith

=D0=B2=D1=81, 6 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 08:05=
, Alvin Lim <alvinwylim@gmail.com>:
>
> On Sat, Sep 05, 2026 at 07:26:49AM -0500, Mario Limonciello wrote:
> > Two things:
> >
> > 1. lspci -ttvvnn
> > 2. Turn on  amd_smn_debugfs_enable=3D1 on kernel command line.
>
> Both below. Your script ran unmodified.
>
> Conditions
> ----------
>
>   Board      : AOOSTAR WTR MAX (DMI: TianBei "WTR MAX")
>   BIOS       : AMI 0.01, 2025-04-27, revision 5.29
>   CPU        : AMD Ryzen 7 PRO 8845HS
>   SATA       : ASMedia ASM1166 [1b21:1166] rev 02, 6 HDDs
>                subsystem [1b21:2116], PCIe 8GT/s x2
>   Cmdline    : root=3D/dev/mapper/pve-root ro amd_iommu=3Doff quiet
>                amd_iommu=3Doff amd_smn_debugfs_enable=3D1
>
> amd_iommu=3Doff was in force for every reading below. I did not re-enable
> the IOMMU at any point, so these are values as seen in the configuration
> this machine has run since 2026-06-17.
>
> I took the same maintenance window to apply a pending Proxmox kernel
> security update, and captured twice so the reboot was not wasted:
>
>   7.0.14-14-pve   the kernel I quoted in my earlier mail
>   7.0.14-15-pve   after the update
>
> The two captures are byte-identical, so on this box the values do not
> depend on which of those two kernels is running. That is an observation,
> not a conclusion -- I have no basis for saying more than that.
>
> To be explicit, since I would rather foreclose the misreading than
> correct it later: this is not a test of the corruption on the newer
> kernel. amd_iommu=3Doff was set for both boots, so neither capture
> exercised the failing path, and nothing here says anything about whether
> 7.0.14-15 behaves differently.
>
> SMN registers
> -------------
>
>   0x111401d0: 0x00000100
>   0x111411d0: 0x00000100
>   0x111421d0: 0x00000000
>   0x111431d0: 0x00000100
>   0x111441d0: 0x00000100
>   0x112401d0: 0x00000100
>   0x112411d0: 0x00000100
>   0x112421d0: 0x00000100
>   0x112431d0: 0x00000100
>   0x112441d0: 0x00000100
>   0x112451d0: 0x00000100
>   0x113401d0: 0x00000100
>   0x114401d0: 0x00000100
>
> All thirteen read cleanly; no invalid reads and nothing stalled. I have
> not tried to interpret them and am not going to guess at what they mean.
>
> lspci -ttvvnn
> -------------
>
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Phoenix Root Comple=
x [1022:14e8]
>            +-00.2  Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU [1022=
:14e9]
>            +-01.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host =
Bridge [1022:14ea]
>            +-01.1-[6a]--
>            +-01.2-[6b]----00.0  Samsung Electronics Co Ltd NVMe SSD Contr=
oller SM951/PM951 [144d:a802]
>            +-01.3-[6c]----00.0  Micron/Crucial Technology P510 NVMe PCIe =
SSD (DRAM-less) [c0a9:560a]
>            +-01.5-[6d]----00.0  Samsung Electronics Co Ltd NVMe SSD Contr=
oller 980 (DRAM-less) [144d:a809]
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host =
Bridge [1022:14ea]
>            +-02.2-[64-65]--+-00.0  Intel Corporation Ethernet Controller =
X710 for 10GbE SFP+ [8086:1572]
>            |               \-00.1  Intel Corporation Ethernet Controller =
X710 for 10GbE SFP+ [8086:1572]
>            +-02.3-[66]----00.0  Intel Corporation Ethernet Controller I22=
6-V [8086:125c]
>            +-02.4-[67]----00.0  Intel Corporation Ethernet Controller I22=
6-V [8086:125c]
>            +-02.5-[68]----00.0  ASMedia Technology Inc. ASM1166 Serial AT=
A Controller [1b21:1166]
>            +-02.6-[69]----00.0  Micron/Crucial Technology T500 NVMe PCIe =
SSD [c0a9:5415]
>            +-03.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host =
Bridge [1022:14ea]
>            +-03.1-[04-63]--
>            +-04.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host =
Bridge [1022:14ea]
>            +-08.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host =
Bridge [1022:14ea]
>            +-08.1-[01]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Ph=
oenix3 [1002:1900]
>            |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Ra=
deon High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
>            |            +-00.2  Advanced Micro Devices, Inc. [AMD] Phoeni=
x CCP/PSP 3.0 Device [1022:15c7]
>            |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device=
 [1022:15b9]
>            |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device=
 [1022:15ba]
>            |            +-00.5  Advanced Micro Devices, Inc. [AMD] Audio =
Coprocessor [1022:15e2]
>            |            \-00.6  Advanced Micro Devices, Inc. [AMD] Family=
 17h/19h/1ah HD Audio Controller [1022:15e3]
>            +-08.2-[02]--+-00.0  Advanced Micro Devices, Inc. [AMD] Phoeni=
x Dummy Function [1022:14ec]
>            |            \-00.1  Advanced Micro Devices, Inc. [AMD] AMD IP=
U Device [1022:1502]
>            +-08.3-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD] Phoeni=
x Dummy Function [1022:14ec]
>            |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device=
 [1022:15c0]
>            |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device=
 [1022:15c1]
>            |            \-00.5  Advanced Micro Devices, Inc. [AMD] Pink S=
ardine USB4/Thunderbolt NHI controller #1 [1022:1668]
>            +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controlle=
r [1022:790b]
>            +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [102=
2:790e]
>            +-18.0  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 0 [1022:14f0]
>            +-18.1  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 1 [1022:14f1]
>            +-18.2  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 2 [1022:14f2]
>            +-18.3  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 3 [1022:14f3]
>            +-18.4  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 4 [1022:14f4]
>            +-18.5  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 5 [1022:14f5]
>            +-18.6  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 6 [1022:14f6]
>            \-18.7  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric=
; Function 7 [1022:14f7]
>
> What I can still do cheaply
> ---------------------------
>
> I deliberately left amd_smn_debugfs_enable=3D1 on the command line, so
> more SMN reads cost me nothing -- no reboot, no maintenance window. If
> you want further registers, or the same ones under different
> conditions, just send the list.
>
> I can also still run any boot parameter combination (amd_iommu=3Dpgtbl_v2=
,
> iommu.forcedac=3D1, iommu=3Dpt), older kernels from the Proxmox archive, =
a
> custom kernel with a debug patch, or a long fio crc32c canary. The one
> constraint I mentioned before still applies: this is a live NAS and the
> ASM1166 carries real data including a Ceph OSD, so anything that
> re-enables the IOMMU needs a scheduled window with the filesystems
> unmounted, and I would write the canary first through the path I know
> is good.
>
> Still not something I can offer: no JMicron JMB582/585, no Intel or ARM
> IOMMU machine, and no SATA controller other than this ASM1166.
>
> A note for John Smith, added to Cc
> ----------------------------------
>
> John -- I have added you because you are running the same machine I am,
> and one of the readings above may be worth your attention.
>
> You reported a TianBei WTR MAX with AMI BIOS 0.01 dated 2025-04-27,
> revision 5.29, an ASM1166 with subsystem [1b21:2116], and IVHD EFR
> 0x246577efa2054ada. I checked each of those against this box today
> rather than assuming, and every field matches.
>
> The EFR needed a different route, which may be useful to you: with
> amd_iommu=3Doff there is no AMD-Vi line in dmesg to read it from, so I
> took it from the IVRS ACPI table instead --
>
>   od -An -tx1 /sys/firmware/acpi/tables/IVRS
>
> parsing the IVHD type 11h/40h blocks, where the EFR image sits at offset
> 0x18. Both blocks give 0x246577efa2054ada, EFR2 0, with GIOSup (bit 48)
> and GT (bit 4) set. That is a live reading from this machine, not the
> figure quoted from my earlier mail.
>
> The thing that stands out: of the thirteen registers above, twelve read
> 0x00000100 and one -- 0x111421d0 -- reads 0x00000000. From a single
> machine I cannot tell whether that is ordinary for this board or
> specific to my unit, and you are the only person I know of with an
> identical one, so your numbers would be directly comparable to mine.
>
> That is the whole reason for the Cc. No obligation, and no request
> attached -- I just did not think it was right to sit on it without
> telling you.
>
> Alvin Lim
