Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13134EEF3
	for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930699; cv=none; b=h7y43qZcz9CaC5PJ3aiL4NkE9UbTQDvmZkIiW2h3gNfLemsCS1ZBMLpUKR5soLD1b/TEuRhb/Lb/CeXRbQjyDYiFfwM+lnfv6ZCsaY7opoSu3gJpXD6eVGm9mhG46VqIQBgJ/A3N2cElQZmrzlSMG01v0gsaxVDlueWTYKRKLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930699; c=relaxed/simple;
	bh=tpyZvgdIuReJeSrdOPCyYr8fsLpfLCii8h1S1BKcev0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvwY2xT7yRr6H24aRqVz0UfwjCJs4NvGdEqShArSnfwmLYXWp12Qtzs93aBwGC0DZliIe7nVxoTWPVKs5D/fnrXmxsdJw8vEz+kN7bzzelYhNOPQ5uVXYr1OxjWQADHKx+deZQe6NoOEQB1W9Ms7/rx2MnJS1DQGkwIyyFjP/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWTVVlBb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWTVVlBb"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39652a6e963so2163356a91.0
        for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930697; x=1788535497; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=OWTVVlBbRUCkbMVkRasQwwDxPWox/hkiL5iu7d9S25HY2zJqkrIxjPXkQ8V6EKsGkA
         iJYENLOmUiE7+LwNJ+TNrlxyeViCzC4yb5e8I+wfHtrMDrE2EKU69+DUrseyp4rd24Er
         GFMavUJY+7oX28ge4JG1rZjcFy69hoTZQFUWKdSsHdw/3pmQZDqdaqb1fXRFQa7tz5s0
         q91km5mJ/ag9TgRTJsYqZpK1aNRhvBqsEbRTtMmj5nnyjvoUNskLRiPY4VHTKS09w6pU
         Jt34/k4A3EyUpMj8c9rWdiA+KYQdcp2Yt+4rEYgA091/eVQJAXufEp72Wg0vhyaNmJcc
         8qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930697; x=1788535497;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=iSsaG/kZmGt+x0ibTJ7TlFsWDMiZiHjizyff+GeybhlZzHswl+YI8qvUK+FVlYYfI5
         +t0OjYaWKr0LvwNdWKDJtYaoOQl2LstCyMpeiKBPmCa1qfODK4ppDAYLGkW0p2h1zqTe
         x/UXkdHrwAtjrU3iS0B3AqrSK9Xot36dGsIiCcunVQCA/cmBYZO2KnVvBsLePGZe+gCu
         tSqRCXvvCxnHWaVoaFFujSRSb2YBX6IccMuzSB3DcyD9fyFd9qEWB1gWimUZ8nQnrV8u
         MYE4iApwYXCruBwp8sTD9D2swrwhw/4JP0sFMS5WrxsQ9tB5my3+luJw4/cPnOfgJBqH
         yIvA==
X-Forwarded-Encrypted: i=1; AHgh+RoSzkLhBq45E1CwtcafWqrQCTRuwBKesnzd2lfs/EQ7ShPnHZi73xVkena3gLjB5E2BLGg15ifDrNY=@vger.kernel.org
X-Gm-Message-State: AFuF++mB4G2o4cRiNPXusf6FDxDV9sg8V78FDEAs6Nsl3yqpK4+COmmC
	DyQTBEl1nSUw0HfhKyDwspfFSFnBEy+0uCUQCwoIJ+k/lligwgXS/+7O
X-Gm-Gg: AR+sD13Z9UV59KftIejHq5mhhqCZSAgpbLCPZ5iXut+TkVPhxqv+MAeVNMRFcfR1Z3b
	/lQQVwXVBbuyhdNNhxdfG7HRyJWnyyeqE3pb6WQ+T3upvuBIRbkTEqAMKXUQpQ/nqi8v4j3zqNS
	e+gN6MxFVHZuQY2V2pASM0D8bwtfhS/5/Azbc0IPKXo/LFN6J/GSijmEwRk6XvD1jR7Q4B4xV9g
	bpFjz1xCnYdVPxpef5y/AhZZvWs5Y5wQ0nWz9ipopO/K3ZLUHv2uDD8TybcjscgaBFAmO/FJwr8
	iNcT2IwOjDGh69alxQiGI5nJYyH+xZjNHLwp0jw2Jgf9o+W1o5XdRJMVfM7NqiSnp0cslWQTKt6
	9QmHkZruok6ogzBJ5oaZIZGCCtkM1OmWsOBIns79D6lLUYs15+IHIoI4YDk6/B+3p8TvVx+5FNu
	DUrD9DJ0wuJtcSfI4+aV7p89pVQoUhdOyRf3bFQVWhAu7IlFdhx2qNdxEufMvPA4A4hYH7X2TTz
	oNlWS2dP+CnY/BKaUd5BFWBKD0jbFfx7zfX6ED8JhjyIjbaaMac50hvxXbXH1G1F/0n
X-Received: by 2002:a17:90a:f088:b0:398:9beb:a2bd with SMTP id 98e67ed59e1d1-3989beba8bdmr429233a91.31.1787930696923;
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm7412788eec.16.2026.08.28.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: Mario.Limonciello@amd.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc:
 regressions@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 22:24:51 +0700
Message-ID: <178793069172.1699234.13635367891277204598@gmail.com>
In-Reply-To: <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
References:
 <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 8/28/2026 6:22 PM, Limonciello, Mario wrote:
> BUT the issue internally does show the issue is specificially once the
> 32-bit IOVA space is exhausted.
>
> Unfortunately; the solution is currently a BIOS change in how the type
> bytes of the IOVA is handled.

Hi Mario,

Thanks -- the 32-bit IOVA exhaustion detail is the first thing that explains
the timing I see. My failure takes 3h25m of sustained reads to appear, and a
reboot clears it completely with the same kernel and the same on-disk data.
"Low IOVA space works, high IOVA space does not, and a reboot starts from an
empty low space again" fits that exactly.

The ASM1166 write-up you linked is also a very close match: a controller that
advertises CAP.S64A but cannot actually reach above 4 GB. My SATA controller is
the AMD 600-series chipset one (1022:43f6), which is Promontory/ASMedia silicon,
and it likewise advertises 64bit in its AHCI flags.

Firmware, since you mention a BIOS fix: I am already on the latest available for
this board.

  Gigabyte X870I AORUS PRO ICE
  BIOS FB1c, 2026-07-21, AMI, platform firmware revision 5.41
  AGESA!V9 ComboAm5PI 1.3.0.1c
  CPU microcode 0x0a70520a

So whatever BIOS-side change you have internally is either not in AGESA
1.3.0.1c, or not sufficient on this board.

On the bisection: before committing to two weeks, I would like to try making the
reproducer fast. If the trigger really is 32-bit IOVA exhaustion, then booting
with iommu.forcedac=1 alone should hand out high IOVAs immediately and fail in
minutes rather than after 3h25m. If that works, a v6.19..v7.0 bisection becomes
an evening rather than a fortnight, and you would also have a reproducer that is
practical to run in a lab.

I will try that tonight, with all services stopped, then the
amd_iommu=pgtbl_v2 iommu.forcedac=1 combination Vasant asked for. I will report
bytes re-read, wall time and workload rather than a verdict.

If you already know that forcedac alone will not behave that way, please tell me
and I will not waste the evening on it.

And to be straight about the rest: this is a production home server, so a
two-week bisection is a real cost for me. The reproducer is three lines of fio.
If you can run it on comparable hardware in your lab, that would very likely be
faster than me doing it here -- and I am happy to run any specific kernel or
debug patch you want in the meantime.

Thanks,
Mikael Etienne
