Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47541C2E0
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889265; cv=pass; b=kt9nLCcvbs2e1r5o+bNQMx3TiQ+m8Z7uay/csPM/JDMQsPc9EaVmYnnTVyBVCxbJOQljaPRlktpa/jtyy+zO0Mo5cdurltLbouFSTWQt7+SE8L+JiuWtJnDMazAdPxT4NRax4X41a/BlAeMBpJeTP280epFb6XIACpc1A0VWag0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889265; c=relaxed/simple;
	bh=PrHVURoOKhs2sm5zZonahzwBhlLWgKAdKIQ/+0RPtMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q3lDHg5tcZ7+X4DMWO8dXoNVl+FZuorSPVPkYMhMASqCmGSaEYeCYNyKgncERybwPe5f3Q5Znb5HSaFfyxbS4EQQo+BiuySZIMOwWUe/3myghRhjRyOaePqMELI/PTYn1Em2aNUlCch6ygKAM+Q+AzZ+GhtHfzQ5vXGqNDZq6jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2k4jh0/; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2k4jh0/"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-57517ab9c44so530616e0c.1
        for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 06:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889260; cv=none;
        d=google.com; s=arc-20240605;
        b=C2jgriBxv15LNFtZQW1xH/zxdNJbEXjyQlL4wjh9JPuh2E2ZF/Hb2sYvZiEwJgD0Du
         nUH4aErkeL0cduYSSu4U3MNmdVjhgk6tGysTF+HN8lplYQROwLladIoABkCMncUNo54O
         Aane2029fd4OZg4sCsyOm1FvesIqK1f3PC+9bjcEaEB5+LdiPjfq5ED2ctcNZZW+k/3R
         HEW0MT9bGkoHb8VtNdzMY7d3jWGVpvMKUASX5lnM07i83bMkcvDE5RPVGz8+fqBmgdLg
         Oh1XLlro16diNeDHyU7iW/kdRK3JwiBezAG35W50MILkpJJzvm/rRtD51umP2+mbPrya
         rmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RGIQxkz57Tb/CfJyaJTTn9vDYM705LSSX4RSwJaPbfg=;
        fh=ztqLSSfhfzwf5R5ueAL3RXPewrpq9XyecaQfGUPz7Y4=;
        b=gVf/6tupci8JI3HFhoTn/nvBSdfihTV11YdVsrR7d0NLSJpUgHWK6RsNMYw0Smbe62
         Xn+nrggve3Mr2RxY2xQGi4kzNC0h4jtpANFWuMxbvsVb4QgrHOKu7xzWW947hYhcIuAp
         CrNp7OkrrPaGgz1hh7H0v/pZ4jaCwpFH71VSDBH+6X6TFCAy1Pr8gwMsNMhNjJcyjTM0
         tZG3mt6bueNhmUq1ZL/zcZcpyucPwCh3WQux0lkYocLhpj6rNKGemG8g7zNBdm7UK3wP
         fpo0k1BuLv555gM/lXBT9KOas+gjhpdYqcOMfH7RsBbB0oa3a3YFn0nE247HsVNREKuG
         4BPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779889260; x=1780494060; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGIQxkz57Tb/CfJyaJTTn9vDYM705LSSX4RSwJaPbfg=;
        b=J2k4jh0/xorrgPTZ0wyvNQWWNpg20v+I15HRwG7efAHoZTcgIg/6j6NLIaWHkxebHN
         TKAgWupN3zHdL64ykQ8X+IOX3U9Wa69YSE/uHPTVyGKOjl7yBN38FFmraluByqqLh6Qn
         MR2pmhPuVSlDZQ+o7OCS4UU7JGNj4fSNvglEBV7PlR7GSEiP1pzY0YCJuj8lPs/+2ntH
         /8Nw+lpkmhNNlCnheohy1To/iGKiszmL7UW53EPjLVbAYUURvJRNs5+t8NqBsFqCxCwX
         K3Q7LJzpV4amFVV3kwKqhPuDTs57uHD3zRwSQYkyhfgLxkdhiLS2qew0lPh2NBJcGt2f
         vzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779889260; x=1780494060;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGIQxkz57Tb/CfJyaJTTn9vDYM705LSSX4RSwJaPbfg=;
        b=cTNLkQ53OB5rLEJMJlpCIVep0ErgSG1N02O5p+ImY+EH4I4kbh3XoU8Dv/vje3yBil
         YanC1j33rVb1s9D0+pDdGJ9uaPA/lDJl72rDBSaLAH3qY8HqCx+tE2x5SwBnFvpqaW2p
         serSUOJ6y5QP5PIrCkN1M0Q8ZSz63tPVQx8K3Tbo6Gd0sqLAOE9CCZQJYiZX7XI5DjJ0
         tTSnbsOwsvNHuOFswWeWfT2bO+AykXTZhMvehAybSpnSDjZS5uUB1c9XmswMhnImD5IR
         p2s7vhYuUGOfApBP1o3EnS8IvIAgxeaNg4vwV2kaN7SvxamyWC9uey084JDNqgre5G2M
         Zzuw==
X-Gm-Message-State: AOJu0Yy2QiKE8Z/Smh6frt/oEECr24yxSCNCGDeOIX1+8ABGIr+VssoM
	tZT0Rrqp3/R+1nAmXLapc3l5oaOSigz7UYYhja+/+/HvRuaROz/ojWzOw4o9j8Crqip/p5PkRzS
	ubIbg/Ju/Bt7hSJ/OMrdrk68LPa9gL1ew4dd6eeg2eQ==
X-Gm-Gg: Acq92OEEoRPJvKwuOaH9fVIQYp2fOrdj1FfPRo3W3vdeFQnQOJ6EX8O/MNdjhptaUTH
	STftKwg9ejrJ8lEOjDfVBMdXaTTdQkvs/CJ4zLOPbl3XL3yFuUI/NTu/HQqQwMdo08BjEz6ofhU
	ljS+vr+vhdmqE+GiublD/4A6J+DTSoDXZzwMeNvwr3URmsH7gI5hnP86B1d/GoCEWRYJ6NmRblL
	YF6WUkCo652qsWz05MYp1+Ar9QphaCTy9pp+xuBxKvl8b7SVXwv5IzycZRnuanraUdfDIbkknXn
	+wSOO1dm3F0rHGvrUhHvP4ON7iUqTNcftOq2gMl2JQCsLl/tZEtZ5NyxxHXSMgqaU5HLwkmbfRh
	4ofGPvaJx1uF0Qp0cJX36qJw89axjbN/3Tr89SMQlpeIhig+gLztXw+gI7YFwdfcZVKeW4dnlZP
	U0BmMlfNjyZX3YMzdZhtc0KmKYf/Ke/ressdRcIwnz47mU2F8eqN7VUHejuK7VxeHpqAbHKpbtU
	T8F7M7A
X-Received: by 2002:a05:6122:2ac3:b0:575:35f9:66b7 with SMTP id
 71dfb90a1353d-58663e43d1dmr3883286e0c.3.1779889259562; Wed, 27 May 2026
 06:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdcr8dMyX+ZRj3ARv6iFkLKXL2+onQbhCkX+=rnXKX3o4SDUw@mail.gmail.com>
 <6c4af01f-f57c-4b40-bd99-9746bb062bcf@kernel.org>
In-Reply-To: <6c4af01f-f57c-4b40-bd99-9746bb062bcf@kernel.org>
From: Michael Lazin <microlaser@gmail.com>
Date: Wed, 27 May 2026 09:40:46 -0400
X-Gm-Features: AVHnY4LJHJjzJJkA6cbf8GifCIFQy36H4yh-9G0vNNqMoO1NkTDNwdLp0JmAGP8
Message-ID: <CALdcr8e8GS8uQYy3=7mXXvyPCkvwX=pSiZ7RkU5G34cQuDEO4g@mail.gmail.com>
Subject: Re: [RFC] libata/ahci: three MMIO trust boundary issues under hostile
 hardware model
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To the linux-ide maintainers,

Thank you for the quick response and for validating the report.

While I initially offered to submit the formatted patches for Issues 1
and 2, my day-to-day expertise and current bandwidth are heavily tied
up in threat hunting and automation rather than low-level C
development. I realized that if I take this on, I might become a
bottleneck, and I want to make sure these mitigations do not stall out
waiting on me.

I am stepping back from writing the actual C patches so that a
dedicated kernel developer can pick this up and ensure the
implementation aligns perfectly with subsystem standards. Please feel
free to use or modify the proposed logic from my original email
however you see fit.

I am more than happy to review the resulting patches from a
threat-modeling perspective or assist with testing once they are
drafted.

Best regards,

Michael Lazin

.. =CF=84=E1=BD=B8 =CE=B3=E1=BD=B0=CF=81 =CE=B1=E1=BD=90=CF=84=E1=BD=B8 =CE=
=BD=CE=BF=CE=B5=E1=BF=96=CE=BD =E1=BC=90=CF=83=CF=84=CE=AF=CE=BD =CF=84=CE=
=B5 =CE=BA=CE=B1=E1=BD=B6 =CE=B5=E1=BC=B6=CE=BD=CE=B1=CE=B9.

Michael Lazin

.. =CF=84=E1=BD=B8 =CE=B3=E1=BD=B0=CF=81 =CE=B1=E1=BD=90=CF=84=E1=BD=B8 =CE=
=BD=CE=BF=CE=B5=E1=BF=96=CE=BD =E1=BC=90=CF=83=CF=84=CE=AF=CE=BD =CF=84=CE=
=B5 =CE=BA=CE=B1=E1=BD=B6 =CE=B5=E1=BC=B6=CE=BD=CE=B1=CE=B9.


On Wed, May 27, 2026 at 4:27=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 5/27/26 12:38 PM, Michael Lazin wrote:
> > To the linux-ide maintainers and list,
> >
> > Apologies in advance if this hits a moderation queue =E2=80=94 I am sen=
ding
> > from Gmail and am in the process of subscribing to the list. I am a
> > Debian developer (debian-devel) with a background in network security.
> > I would ask that you judge the technical content on its merits rather
> > than the sending domain.
> >
> > I have been auditing the AHCI driver against a zero-trust hardware
> > model =E2=80=94 specifically the threat of malicious or malfunctioning =
PCIe
> > peripherals. I have mapped three issues I believe warrant discussion.
> > I can send patches for issues 1 and 2; issue 3 requires broader IOMMU
> > policy discussion. All references are against drivers/ata/ in the
> > current mainline tree.
> >
> > ---
> >
> > ISSUE 1: Port map not bounded against cap.np (libahci.c,
> > ahci_save_initial_config)
> >
> > The driver reads HOST_CAP and HOST_PORTS_IMPL as independent MMIO
> > values without enforcing consistency between them. A hostile device
> > returning HOST_CAP.np =3D 0 (implying 1 port) alongside HOST_PORTS_IMPL
> > =3D 0xFFFFFFFF (32 ports asserted) causes the host struct to be
> > allocated for one port while the activation loop walks 32, producing
> > out-of-bounds reads and writes into adjacent kernel heap objects.
> >
> > Proposed fix: after reading both registers, clamp port_map to the
> > range implied by cap.np before any allocation or iteration depends on
> > it:
> >
> >     u32 cap_ports =3D min((cap & 0x1f) + 1, AHCI_MAX_PORTS);
> >     port_map &=3D GENMASK(cap_ports - 1, 0);
> >     if (hweight32(port_map) > cap_ports)
> >         port_map =3D (1U << cap_ports) - 1;
>
> Looks sensible, but we should WARN about a device that has a weird port_m=
ap
> that shows ports beyond the number of ports.
> Note that the reverse is common: number of ports is high, but the port_ma=
p is
> only a small subset of the max ports.
>
> > ISSUE 2: Unbounded interrupt loop in ahci_thunderx_irq_handler (ahci_th=
underx.c)
> >
> > The ThunderX handler re-polls interrupt status in a loop without an
> > iteration bound. A hostile or malfunctioning controller holding its
> > interrupt line asserted permanently can trap the CPU in interrupt
> > context indefinitely, causing a hard lockup with no recovery path even
> > on systems with the NMI watchdog enabled (detection latency 10=E2=80=93=
30
> > seconds).
> >
> > Proposed fix: introduce a loop ceiling (e.g. 64 iterations) with
> > disable_irq_nosync and a dev_warn on breach, following the standard
> > Linux pattern for interrupt storm handling.
>
> Sounds good.
>
> > ISSUE 3: DMA scope not bounded to allocated buffers (libahci.c, ahci_po=
rt_start)
> >
> > This is an architectural issue rather than a localized bug. The DMA
> > mask configuration tells the kernel what addresses the device can
> > address =E2=80=94 it does not restrict the device to only the buffers
> > allocated for it. Without strict IOMMU mapping (iommu.strict=3D1,
> > available since 5.11), a compromised PCIe AHCI controller can issue
> > DMA writes to arbitrary physical addresses, including kernel text.
> >
> > The driver-level mitigation is validation of PRDT physical addresses
> > against the allocated scatter-gather list in the completion path
> > before acting on them. The system-level fix is enforcing strict IOMMU
> > domain isolation per device.
>
> This would need a little more digging: ahci_fill_sg() uses the SG list pa=
ssed
> from SCSI layer, but I am not sure if these are built using the dma API t=
o
> validate/set the iommu.
>
> > I am happy to follow up with formatted patches for issues 1 and 2 if
> > there is interest. Feedback on the framing of issue 3 welcome =E2=80=94=
 I
> > recognize it touches policy outside the driver itself.
>
> Please do ! Patches that fix issues and improve the code are always welco=
me !
>
>
>
> --
> Damien Le Moal
> Western Digital Research
