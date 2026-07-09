Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1138F643
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568068; cv=pass; b=tkBk16Pm+k/hT5m56kn3LbqHZbwJU82tmFReLFHHqa5Ae+nFVABLYXDXaM00sgtYvqyIFjyV/AnVn0Wov78tSA0jSu+9CVlxeJ0M7KeAWoHKCWWysQBPgINR4LoS6NL9x4d3I3hfjWwiRSENJPMUUaK4/j5fEXDUijY3N41zM+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568068; c=relaxed/simple;
	bh=YnwHcp5gSCbZJi1VkH0uzYLY9T/1f9/oVSvbGGMl3UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqp7dtWR2KUvMWg+7LM5jJ9v7OoqOYWb8EWwMFJF3NGm7giqBG0hcnaB0kbXjw7C+PlCMiXnXggxgl2oSTeIUPQ08qwc+091e+eJGxnwV16XvxKc7Hh2tf+M0CF1UdY1z17/5iMKrwRzKi2uB5p72oo0PR0Gm2CTC2+JO8wROIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L71oGnqW; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L71oGnqW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c01c79467so184141cf.0
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 20:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783568066; cv=none;
        d=google.com; s=arc-20260327;
        b=COsTL7tqrhdOvXW+aXyLuZLbZV2O57dHF3TrGA/chAOE4DlFLG65yG90P519Oe0QKT
         rMyjAjC6+E2V813mKlWayF0mYx/hqCdX/Lj80LKuqHZvDbtDw7m7nM0vKN2PmTTM+/uY
         UGkr+YUB2W2rJI9f7yyyI3AxdFO5fMX1ncYSYDZUdCjxfU38Jv7exVNHLWp45fqu3xR/
         XN2noZiD3PwDM1vze9kDfHVc20e9vSj0hBiggiRqea6FHL1o2TiRPqMgEw7YH57peT2t
         gduONRbkwJnq9IA4eAbz1aEzSeImZ9Zj/zexN3DhW81j7kPMsRntBd9MCvSbxB5gVjoM
         uRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnwHcp5gSCbZJi1VkH0uzYLY9T/1f9/oVSvbGGMl3UU=;
        fh=Y6prRgjPCQoCmAa8Z1xtJ/kO7KvphxJSUw6DSdaTgZo=;
        b=ANud0KFN09U24pKTR/Oi39czlkD9Q9LKXe8XLDXfeCvfhK8MQ99Twlbu3hkNMBLCW8
         AeHGKDvXgaBBx5hHmGeI8IvAf3/OLfWb7Z4iCO2nUiqcRuXwDPuNHRtJDNc7ugJviExe
         1nvgq68P0uia9akLrv6HknsPye3/MwLg78ijL1DQf+wmRDxT8IwACUpJp2YUfx2QiwpO
         8V7xeK+av/2yqUrzMLlwqRakWOJqrb2OKoh+9rh4A/HCewANevk2usbpuUM4qSYHuc5b
         uHw9IJ4Rk8l9Ng0enMa6mZFRoARiedCRrTN/bQYxgfTMV5IUf26SS9/d+G1HxjXhnWlw
         zDgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783568066; x=1784172866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnwHcp5gSCbZJi1VkH0uzYLY9T/1f9/oVSvbGGMl3UU=;
        b=L71oGnqWCOTft9J9Fu6zcn99GBSdoT1APUs+ALGgHqKdVft0+rA4lqvyO3rhUDE4vz
         4PNQBwJNAquJ/+BDIo+hT48A0fSwrNKlCrDt9+Eu2Jy0nWeOe5AijZTg3C89yts0K6bn
         yy45/Q11ZHsYi3He8Hp8FGGQpAQdtD2euEANTMJFNTK7V+rSBdYdK7Sxqt8eNfkF0OXu
         rEInI0xMr3zHiv94gthrKHowxQUZn3+Jv+MetLekoP5sEkFefx4HWf8uRpvGouAnlUib
         cgcFIBzVh8b97Ew+5D1YMGzPRJhT9K6j08dOaGbRPr8X6/cGmaWBKFC00db5One89AMU
         HpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783568066; x=1784172866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnwHcp5gSCbZJi1VkH0uzYLY9T/1f9/oVSvbGGMl3UU=;
        b=Oc0X0szEgtCqFJo38CNNsvOX3d3ZHFCg3h0ElHfrtiteD7VRsjZi6Qpvjw6L4obar1
         hRwEOWbjqx94f86Km8W5Smv/TDmpZHDKDSBxEBK/QDPuG1HgVCsvwafVJk+MkwNEdaQ9
         /2POfgjYFCjoVyKF6t+2MPCD4PWw9h2CinGWi+bVo40IlGpc5jIf2BPUmzcuenQY5K6j
         bzDw7uQAZz+el9bgN6b01f7VA+reZqXHy2myaFZ3DnNMaHbijsGvrpbVhokgkR9aSPpY
         bx/Vhm56vnxzD1/MCJfnEKhHmi1CX5XV4BQ0o3Y2nfN99wx5MRfuEjf6vyoJTvvNQzK+
         oQyg==
X-Forwarded-Encrypted: i=1; AHgh+RoAntpVMrj4kJtnzCJfxA1WkX8Nnv7RU3MSSVXNY49TDyfOG9tRJeXBg6jo8Hmz+DDxpw4NKDCgLvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpnm/VuZ3L6EbgO7M6wLyd81P1igMpOcWcfEosl5EP8/NOatpO
	Y/GQOGtiAmP0ABo+nJS6mftgU60Zf+naoHLyPQDlZj2k6g5IEmYjn/JRBBCEqhfEODCSCJ/VAXE
	G4BphRdwk0GA4ZXLt2OclUG4/59xbCjb9Jl/CmbLh
X-Gm-Gg: AfdE7cnhqkonWE2KDYDdgUASR7hq7npXR5KWRn53bHaft2MZcKEyUjiZthoKq8iOX2d
	eQJVA0PABurWn262tasWGpz6TXXhwC1906J8PBG+IEnCT0VBB84DIbCvG6SflFLcADmUp9H74fE
	l/Ro4d2N7lt1LUqEQbBJryZSshUTRMeqNF649ao2dNzoPv9lj6+YX2MVEg0KXOhK+2IoL5f4rHT
	qYVzS9Qw6B7T2AxSSLCQaYHgy3w35pQuLroDwdXo9U4Ih0R4/oBo/7lKdJ8z8jCtA2yQBfweW5R
	ywKVmoSbt+zJk57it07jbkOQpJaAtQ==
X-Received: by 2002:a05:622a:248b:b0:517:5ac7:332e with SMTP id
 d75a77b69052e-51c9a7990e9mr3535921cf.6.1783568065317; Wed, 08 Jul 2026
 20:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702020142.3399851-1-rkaruna@google.com> <20260702021411.B01331F000E9@smtp.kernel.org>
 <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org> <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
 <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org>
In-Reply-To: <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org>
From: Karuna Ramkumar <rkaruna@google.com>
Date: Wed, 8 Jul 2026 20:34:14 -0700
X-Gm-Features: AVVi8CfbAcgGqz-QJ-NyJv_X0AMeDeCMo8PBT3Fs4cz3f84_fg3eA2anGJSuTU8
Message-ID: <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, cassel@kernel.org, 
	linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 6:10=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 7/7/26 08:10, Karuna Ramkumar wrote:
> > Before I start working on this, I would love to hear your feedback on:
> > 1. Whether you think this API update (passing `rbuf_len` down to all
> > actors and helper functions) is the right approach, or if you prefer
> > simpler, and more localized checks elsewhere.
>
> I do not think it is necessary at all because rbuf is statically declared=
:
>
> static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
>
> So the buffer address and maximum size is known to all functions using it=
.
>
> > 2. What would be the best way to test all these simulated command
> > paths to ensure the fix is verified appropriately?
>
> Most functions for emulated commands generate only a very small amount of=
 data,
> far below ATA_SCSI_RBUF_SIZE. So I would suggest that we simply add check=
s to
> the functions which may potentially exceed that. Off the top of my head, =
I do
> not know if we have any, but we should just check.
>
> Note that ideally, we should have each function allocate their own local =
buffer
> to handle the translation. But this is right now a little hard to do beca=
use
> these translation/emulation functions are called with the port locked, so=
 we
> would have a memory allocation for a potentially large-ish buffer under a=
 spin
> lock, which means no reclaim/no wait allocation, and thus potential for f=
ailure
> which we do not have right now. A proper/ideal fix would need to drop
> ata_scsi_rbuf, have some helpers for managing the internal buffer and red=
esign
> the submission path to not have the port locked until the translation is
> actually generated. That is all more work and more changes.
>
> So as a first step, let's check the emulation function if any of them can=
 exceed
> ATA_SCSI_RBUF_SIZE in size, fail them with internal target failure.

Hi Damien,

I went through all the SCSI actor functions in libata-scsi.c and
calculated their maximum size consumption.

As you mentioned, most command emulations triggered via actor
callbacks write a fixed or small amount of payload, and are well
within the 2048 byte limit of `ata_scsi_rbuf`.

There are two functions that can potentially overflow though:

1. ata_scsiop_inq_b9: Writes 64 + nr_cpr * 32 bytes. If nr_cpr crosses
62, then this can cause an overflow
2. ata_format_dsm_trim_descr: Writes trmax * 8 bytes. If trmax > 2048
/ 8, then this can cause an overflow too.

I will prepare a patch to add bounds checks to these two functions and
send it over for review. Please let me know if you have any
suggestions/concerns.

Thanks,
Karuna

>
> --
> Damien Le Moal
> Western Digital Research
