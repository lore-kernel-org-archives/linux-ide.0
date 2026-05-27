Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F137C90E
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853131; cv=pass; b=ujjurcgvAKzYP0iqDGp+QwOPpPlHjJcZRhD4BqtE/2Gqrg5QfnHvt6EYtoAYiDCIqCHgHmefUhq1ck1BHTOWD+mrDIgyV7olNCHwyVACfmyWoNqT0PxZNr6/cXeLOnYHZZ/jLT5G/hA2MdgUi4dYb8frvu8dmosct1AsSlt8Jgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853131; c=relaxed/simple;
	bh=de3RNEmjVlf6FxKh4JuFT0M43bNqbfKezOg6ma0IqdQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X67NM3ipqMNDM+KCbN+RXyxxhaW87xgbmEQEpd9ec/0tpccCbjrcSYpGgoU08+uIY4zmyQnR/qBo1bvjpe20m13QG6Bwq1eIlJqLheOM2oYG7fk/ZQiG8ak4OSl2TW3ggSRx7p6de4b9yo2jDvcjIvdFDKFwW6Z8m4loPJbHICw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxk2/qDl; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxk2/qDl"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6313157e181so428273137.1
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 20:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779853129; cv=none;
        d=google.com; s=arc-20240605;
        b=SZ8dhoLGpmWJCvMVNCv30dDCIP7pDBJ0fQ5ZX8DAYSGmI7xYZROm5ETGgtO11aEWAB
         1Npw6NSZUUWuvleBIBGctf7gvIpP7MjDg8kbL0gdX9NqL0rSCoz93otdG8gvD0cAtJXt
         8PnLQB1AUgK0KKhYiCcWRTRXPIWGFt9TSOzgovFc+yiL608Z/YfHCLfHcy/+8d78eaUV
         q6Csah5yY+N6W+/MoVRzGAOzHMuTnYDc03whnsNkTIdw+tqxoWMgocuJGhBxetFCgGA7
         9HqYOLRURrVye2FNBHCKa2Nkje8Gok5dXmbcfnoXtrbRe9jyNvFh4CI+jlB6dsEfv/1K
         HTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Wd3FXPkKZnwu9ukL7VaPH376XIKlVP3j5Nnx1F1F6I8=;
        fh=ztqLSSfhfzwf5R5ueAL3RXPewrpq9XyecaQfGUPz7Y4=;
        b=fcQ5/WCRJ+YDIWavP8/nqNzpj5o6L8DjdYSyMOtv5gswMuhtGcQedADroT04ndWMPj
         GEKVVkCsQcINJsykmn0MqnKkt5LTS7Myb798mzB7e+N1L1TEN/4kqaxeRRcT9K0hRYcf
         c1HiqMjuCOd501kMpa5L+2U4vP7V7N44uwLGlZ3q/1AhyOs/tix7Y3HZuSnxb1VwV+X/
         si6hG8Elm2r/BMVbGdHKVmTOCsf+DQ4HqEdzrjRBBEu1Af0ciPx0wGsvU37p/DfT69wW
         dTMF828H3PSd5rc0aXd6PZ4OVdy1ptJZfKMOWwMwIUZ7qf07ns6N1tYDrqvuxA09ipS1
         PvJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779853129; x=1780457929; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd3FXPkKZnwu9ukL7VaPH376XIKlVP3j5Nnx1F1F6I8=;
        b=Rxk2/qDlmc8naa1pp3Zsi6+r5l1IbiJ3cq+wNwwUin7LHZOoOwc6Vy1oMK3J4qXkZB
         rI/a4i6D0MgSB726PxaZ70mDEv1wHe0fm57JWYuRKmMutXM/848fN9xQ7S0N2nMqxjnJ
         Uig5E4gXqx2MvIGR6Hv/KY3HKLqcgrFvAf2/OXjVBCQSmO8PawfJo4o3Slgcneb/ieCN
         bxSDZR3Yo6V5Rxll8wi/nwqFfAPRxnHTHZKgUPZ79xhAmVh/yS9i9jz390dXywRx+zVS
         RmkFRQ/pIoHirsWQ+rwaKCG5n3Y3+6p607/7MYsXoX3odkem6WKhhmmFLdvdl/UngYpS
         V7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853129; x=1780457929;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd3FXPkKZnwu9ukL7VaPH376XIKlVP3j5Nnx1F1F6I8=;
        b=MrSnmutrCiiu58FIRcaclaYuPJvUnf9TJo3yGamRUipvCWkdIiJmJvue+0Getsb/zh
         a9qLpOLFpKKv9AKg/HXhJOSYDUSXtGE+miQ2A+Uyob1L4DzzauCCYGDxSrqC3VtmlahA
         FtDW20WpvD2K6FZEoOOe/ZPK9aiRiaiYJ5n9vJgfymlImPiG0aw0rpZ9df6XA7lhPGms
         g84SU4peK49JXomj0yYfUVv4FCFFd+Aj1GYA/BrYvOn81TDYWoAisKLbAS09/BfIKZBz
         OjbaDUdKyMWDjT7XQlLV9WCEjdJNcxVFga+dt45JLTdVBM4g1nceeX0Nveg5qQdi0duy
         qPGw==
X-Gm-Message-State: AOJu0YwBGN8exJuHwrTuBGewpTyNiJ7vmlCN+JWLfzlcfWILYef0mSi0
	vFWYFYdSvb8ra8ba/oeHzejo84dlL92YCACE4abwg+evXhMCASemICFGoxjixVc6XOcwrF64uwL
	il3hmsJRwP/Gq0GUJsZJY8pONjE8YUET1V/5HmYg=
X-Gm-Gg: Acq92OGWrT33iqJXx9Pw6RlCYd4epQ+M6KiQVgBg2eoKqwq+v9LNo1Z6tyvVckts2PG
	I5HASGSUabjge0jWUZF8/OvtIm64t9c1oaFPBv1KJfk6rASXIZ4rAC+JII5eOK/hUsBH+wDmGsC
	6OGdI6vjrcrR6DSO0uQuCpSJ5vxswaE7z6MLMPPv1JY06z5Jfws4u1YyqTFE0L4/nQZIMUUERk5
	IWYoDzCQYeINgTyoxR9+2SCuNr5jRglhC+KkGCBo5JJNQfxvedrWoSHzd3KBPDTMT9gEGVh3SdJ
	4gTt4BvEzMefI/js1FIyXuU7Qho+BfYWKNlcShI8rPqdxqLtNM/iV43Jxa3iyPtS8+c4/UiYv0K
	yBd7S7MEYqob3h8dY+Rf8gUVGdr6xElZXt2ph8DuzULomgFP9ECxreHqnI9eASWj9kUR934dUVC
	6XtN4852MKtmtt/e/gI/bFbGdDk7nncylm+EGvbK6wIdI09OY/FfCEuEInZhzUOogmZUNaxLh2q
	1Tk2EwqlDubSMKDbeuBh9L9AT8ItmSm5IrAHrmy8At11HXfK1MH
X-Received: by 2002:a05:6102:48a:b0:633:3bf6:976f with SMTP id
 ada2fe7eead31-67c6914670cmr3508991137.0.1779853128795; Tue, 26 May 2026
 20:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Lazin <microlaser@gmail.com>
Date: Tue, 26 May 2026 23:38:37 -0400
X-Gm-Features: AVHnY4K22PwEFWooa2OFpssOlPG8aTIbf7_Lh6OxRcK2lRqyFZ2D3onk1fngYbE
Message-ID: <CALdcr8dMyX+ZRj3ARv6iFkLKXL2+onQbhCkX+=rnXKX3o4SDUw@mail.gmail.com>
Subject: [RFC] libata/ahci: three MMIO trust boundary issues under hostile
 hardware model
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To the linux-ide maintainers and list,

Apologies in advance if this hits a moderation queue =E2=80=94 I am sending
from Gmail and am in the process of subscribing to the list. I am a
Debian developer (debian-devel) with a background in network security.
I would ask that you judge the technical content on its merits rather
than the sending domain.

I have been auditing the AHCI driver against a zero-trust hardware
model =E2=80=94 specifically the threat of malicious or malfunctioning PCIe
peripherals. I have mapped three issues I believe warrant discussion.
I can send patches for issues 1 and 2; issue 3 requires broader IOMMU
policy discussion. All references are against drivers/ata/ in the
current mainline tree.

---

ISSUE 1: Port map not bounded against cap.np (libahci.c,
ahci_save_initial_config)

The driver reads HOST_CAP and HOST_PORTS_IMPL as independent MMIO
values without enforcing consistency between them. A hostile device
returning HOST_CAP.np =3D 0 (implying 1 port) alongside HOST_PORTS_IMPL
=3D 0xFFFFFFFF (32 ports asserted) causes the host struct to be
allocated for one port while the activation loop walks 32, producing
out-of-bounds reads and writes into adjacent kernel heap objects.

Proposed fix: after reading both registers, clamp port_map to the
range implied by cap.np before any allocation or iteration depends on
it:

    u32 cap_ports =3D min((cap & 0x1f) + 1, AHCI_MAX_PORTS);
    port_map &=3D GENMASK(cap_ports - 1, 0);
    if (hweight32(port_map) > cap_ports)
        port_map =3D (1U << cap_ports) - 1;

---

ISSUE 2: Unbounded interrupt loop in ahci_thunderx_irq_handler (ahci_thunde=
rx.c)

The ThunderX handler re-polls interrupt status in a loop without an
iteration bound. A hostile or malfunctioning controller holding its
interrupt line asserted permanently can trap the CPU in interrupt
context indefinitely, causing a hard lockup with no recovery path even
on systems with the NMI watchdog enabled (detection latency 10=E2=80=9330
seconds).

Proposed fix: introduce a loop ceiling (e.g. 64 iterations) with
disable_irq_nosync and a dev_warn on breach, following the standard
Linux pattern for interrupt storm handling.

---

ISSUE 3: DMA scope not bounded to allocated buffers (libahci.c, ahci_port_s=
tart)

This is an architectural issue rather than a localized bug. The DMA
mask configuration tells the kernel what addresses the device can
address =E2=80=94 it does not restrict the device to only the buffers
allocated for it. Without strict IOMMU mapping (iommu.strict=3D1,
available since 5.11), a compromised PCIe AHCI controller can issue
DMA writes to arbitrary physical addresses, including kernel text.

The driver-level mitigation is validation of PRDT physical addresses
against the allocated scatter-gather list in the completion path
before acting on them. The system-level fix is enforcing strict IOMMU
domain isolation per device.

---

I am happy to follow up with formatted patches for issues 1 and 2 if
there is interest. Feedback on the framing of issue 3 welcome =E2=80=94 I
recognize it touches policy outside the driver itself.

Best regards,
Michael Lazin
Debian Developer
