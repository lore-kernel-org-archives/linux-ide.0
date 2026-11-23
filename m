Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470571;
	b=0gAdGojui79W6P6KSPwXxfNcRnxcZl/CjWAfj7IfuCLTdfeaHKMkFhZVKRpta0BcXXD9
	 0KGalOe8zxm9F3N210OOAwwBV3aHlYrR7YR7dfvlc12nUTLTsRU6X8imtksJzuh+HtecU
	 fA69+C8HDGepyaolaK7+kaaW1Uy1IixWOtlGKquQCQTcy1wzTkwsOoyMDMQTCD2G+EaJD
	 +lnOJMtOsCiJTZtQlrbw0Z1tZT6Rg84Bb6DcvoZ6o4xtmBxhgYbn96ZfPvVcyGWzSQaTH
	 rKQvLT2nOUthHgT8kJ7ibV5w5r4XuoHqZA+O2UPe7uyV8Z96Z5kCfuVre/JSDwmD3Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470571;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=f4MCZ/T3xS0Pv/9KngzSF5InnwPHAT2sh3qinXxJN+VhKy4OmtmVc8ntuFE4E3xTyJ2n
	 R6ZR/d7pdtFsInB1fDkY7VoH0fWygnN3YVJS516T66FH20LDvi1+Pfn+0RpKJxsDW4FzG
	 OGVuFXNXtBPUvfUg636dTbhT/NP3couKWaaefihwIRKGoquxTYRbgBId27yLfep69YbXB
	 bVyrwUbrcSNdlQIVjjgKH1dp43CL8CH876SNbN8QfX5XIuHnyDXQULjeybwO8/t491PHI
	 /P84efDduimLj8eSS5wt9Qr0vaUgqusJEPbdjhWm4bWnMiIZvL5iSG8KcKcJjulAvrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bCXDnQ2R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C10606A332
	for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2026 21:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C10606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bCXDnQ2R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795470570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=P8utDJXemWcB23UD8Ny7GUBZQFlqFR2oolQreTffV2mwufBZyHki6jKc6+5UwtuI/kTfo9
	hasr5FK0ggrkdSg/WOUUIKxpO1wqyCBztiJ51m2FhqAmq03OojH3MGn9TZ5hhHsqySuD/B
	bU2N2IP9WR6a8PIdTUCWdoQPZnM7OV0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-GDSrEVCNOESxpwYu8XGVjQ-1; Mon, 23 Nov 2026 21:49:28 +0000
X-MC-Unique: GDSrEVCNOESxpwYu8XGVjQ-1
X-Mimecast-MFC-AGG-ID: GDSrEVCNOESxpwYu8XGVjQ_1795470568
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-920f97bcad4so70811626d6.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Nov 2026 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795470568; x=1796075368; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
        b=bCXDnQ2Ryer5m326RspAln23rGoCEwQJTNaCAWCsv96rqxf6eaYey6KX0q789iTMCg
         Cg92nKnghbXo3L3AyI5aII6FtvN/X0pEU0jc48Fx0Ye+WTDrMCEBldLuTPmZ/51YhVfj
         VvmJkehxJ89hBkv4ZJt1bNMCaVo61f6c+86YXpf3dfNFkzzpteASf9fWCWlmuKIjM6o/
         vYTkRqeNxo/MC2KsGR6Xkj6nbwNgZs5M1+PoNjZZmW+nAHNGVytGAtdgxs5RoJLQeLDP
         o+Ag3N2s1oPGc+mQy8O6t06sfFL9LF/uoYYAzQIfprGwnH7FHh8IkRe1mFdtw9Zjrm0s
         PjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470568; x=1796075368;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
        b=J/OwtZdDNuON/0hYH0yiRKhsyylHHH92qoO2dp6YspSSFlqK8u48iESFoQ2MMgqnHh
         KP/sCSA9rEpZEpUZZf1UGVxcGDUSAn9To+3pc1lDGjKQRIWG0Zm2knA2/tR+0k3e+Tl/
         k9bAEx2jNN0qSXRffcWQ+CO/X/ZVF+cm5qdJpYOo6BtMnlWH5mWeECFZaSwOgo4EpW1E
         ZG8BRhxSQI7OD2rvmZl7/lLWdQhCp9Z4GSr9ju2NqeOcv6fN0x01TerDm/BpSRgSKZe2
         g+66qJoErV1vHF4AHvSJ5ogLc2EHjmfM5BJKEBgxZUVWHCPTJCgbvHCBE2UCn2qGnnXB
         v9Rg==
X-Forwarded-Encrypted: i=1; AL+hErEr4ATMizh+ipXmw8TlK5I+YgeRQrPoBmxt/dr0cZTtS6R7czmEtxIeBHUL2ye8XreoDs3RtEUQ2lw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kE4MP/fky9U5F829TZtZURao9UmJsNQagS9R95O018sBhkCvo
	s5L9D/t15OSPlPp8kLyJOIwjrQoZNZcQMkB8rNYGFVT0oU9vOV2Q1Q+tANu33h8GpSY38IENkbF
	XtWxC30pdYeZWhew7re4HuvyLtYo/cHLk+Gc5ZTbIqMu62zqIJZsCFbvRj3Ebag==
X-Gm-Gg: AZFdTZd9JazYzjAxM0SC621ZhjSG0hc2K/QQeIFjw8QEO2+BFT4s7UhMMhcV5V7SnYM
	C9kkNuqOoeRPku7+xuajBBR1ARkMHNyK6fl2BijVYoUDqUeAdCFWvPH4nbcYDmwaEEz+Oqdln6u
	UTbjuDlpKxBCosaLb2eRzVaASLmHMU1kG8DBi2BTIgtT0i8j8wfH1fHwaT1q2eS0v73/zyvF7a6
	TikS7XCxt2sXuJuj41ogd1CHNt87k5LBjJrzXUrUSlZkQ9sR71BFlTZyWrok3iusH1zQ7w63V0j
	5chIUe2MQkZILEfd5ur4k9HPf+b/vWf4enHQOChwxR7M67hhO9cqfA0CMo4ajfEgTNga6WVaSbq
	US1I7J9S0YxJyl4mwY0xmlMPldhs1TTW6djo1U7LVu0iRFUmn0J+OzLa4iFQH7pu+HZerJ87zYh
	UpOQyzhA//zt7zPM54VuSqmtKGpdbDgIBfoXlO2GMdVSgtbhq3Ri8gqe6r9h477XYjVLpWyH4=
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238824456d6.4.1795470568028;
        Mon, 23 Nov 2026 13:49:28 -0800 (PST)
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238823796d6.4.1795470567440;
        Mon, 23 Nov 2026 13:49:27 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0f6bsm117366396d6.21.2026.11.23.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:49:23 -0800 (PST)
Message-ID: <7eb28c6334a655eb5bfbf3035cf1f1ff1041bb3e.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Niklas Cassel <cassel@kernel.org>, Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>
Date: Mon, 23 Nov 2026 16:49:07 -0500
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-23 at 22:15 +0100, Niklas Cassel wrote:
> Hello Tobias,
>=20
> On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
> > One way forward could be to a new entry to __ata_dev_max_sec_quirks
> > similarly to the recent commit
> > a12cc63129380a5364e787d92b30a3257f66c250
> > ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8").
> > However,
> > I wonder, whether that would fix the underlying issue or rather be
> > a
> > workaround, because 4088 does not fit the pattern of all other
> > entries,
> > which specify either a power of 2 or a power of 2 minus 1.
>=20
> Your attached kernel log shows that you have a
> Samsung SSD 860 PRO 1TB, FW: RVM02B6Q
>=20
> This SSD is probably quite common, so I somewhat doubt that it is the
> SSD that is at fault here.
>=20
>=20
> >=20
> > Furthermore, the first error messages are DMAR faults, and a SATA
> > SSD that
> > isn't functioning properly shouldn't cause any DMAR faults, because
> > the SATA
> > controller should never read from or write to areas outside its
> > memory
> > region.
> > Since the issue with mounting the rootfs disappears with
> > intel_iommu=3Doff, I
> > wonder, whether there is a limitation on the maxmium block size
> > either by
> > the hardware or from the configuration of the IOMMU and SATA
> > controller by
> > the kernel.
>=20
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI
> tables -
> DMAR on Intel).
>=20
>=20
> We have seen similar reports here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220693
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221713
>=20
> Does it work if you revert:
> d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?
>=20
>=20
> It would be nice if we could involve some Intel IOMMU experts.
>=20
> If the ACPI DMAR is at fault, perhaps it is possible for the kernel
> to
> patch the ACPI DMAR for your platform.
>=20
>=20
> Kind regards,
> Niklas
Hi Niklas, Tobias,

I tried to help here but (full transparency) I had some LLM help for
further ideas after I coul dnot repriduce this on my platform.

I tried to reproduce this on a Coffee Lake desktop (i7-8700, Cannon
Lake PCH AHCI 00:17.0) whose INCLUDE_ALL DRHD reports the same
relevant capabilities as Tobias's dmar1:

  dmar1: cap d2008c40660462 ecap f050da
  (SLLPS =3D 2M|1G, ecap.C =3D 0, MGAW 39, SAGAW 4-level only)

with intel_iommu=3Don, DMA-FQ default domain, max_sectors_kb =3D 4096.

- 6.12-based kernel (pre d373449d8e97, i.e. the old VT-d page table
  code, with the larger BLK_DEF_MAX_SECTORS_CAP): 2M O_DIRECT reads,
  clean.
- 7.4.0-rc1 (generic iommu page table): 2M and 4M O_DIRECT reads and
  2M writes from hugepage-backed buffers against a SATA SSD, ~15k
  I/Os, no DMAR or ATA errors. The iommu:map tracepoint shows
  2 MiB-aligned iova/paddr mappings, and domain_translation_struct
  shows 2 MiB leaf PDEs (e.g. 0x000000039c200082, PS set), so the
  superpage path was exercised.

The 4088 vs 4089 threshold matches exactly the point where a request
first needs a full 512-page (2 MiB) IOVA, which is where superpage
mappings become possible. All three of Tobias's fault addresses fall
in the same 2 MiB window at 0xff400000.

So on this hardware neither the old nor the generic page table code
shows the problem, which supports Niklas's suspicion of something
platform specific. One difference: on Tobias's system dmar0 reports
no superpage support (cap c0000020660462) while dmar1 does; on mine
both do.

Tobias, a few things that would maybe help narrow it down:

  1. Boot with intel_iommu=3Don,sp_off and an unmodified cap. If the
     faults go away, superpages are involved.
=20
  2. The full dmesg from a failing boot, including the DMAR/DRHD
     lines. The faults are reported as DMA Write while the outstanding
     commands were WRITE FPDMA QUEUED, and I'd like to see what else
     was in flight.

Regards,
Laurence

