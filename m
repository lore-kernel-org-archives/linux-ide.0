Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EC3845D0
	for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712279; cv=pass; b=kLCKq7J6XB+glg3PZ0wOVwqnZXXtHbOq3cwo6dhS/kxMEjDT3+ITGj2B0+S4Se/nM9/FPDyyBRg7E7XGCAGDAjWvZzu0XUl5XMcNSZyDn3eiAweUSffIIwfg5h9YgRChC2FO/jzOCs/Er70PY0b2mp46SXWBFPRq4GOefI1TRaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712279; c=relaxed/simple;
	bh=45/772M2ivi6fpTGCjKRNRa8Df2a9ZbYROKdGWmG3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdfMEZ3eGCsh3LiuDYnd3TXimlwwVwMacaLL55PkAOjmpTz2/4j9C4Ncoi90Mgaqk+BnrLZ/jmfNFM3gI/poqy/4nYyWgwiWVGhoDTSdTxama+Nh4SG5XzaXja8uK01kS0O7NNO7RnaE2MMv1PcZdb4OyTxvyJ3WEIwduVBL12M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijN7czOA; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijN7czOA"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15a5b265so43791cf.0
        for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2026 12:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783712274; cv=none;
        d=google.com; s=arc-20260327;
        b=Et4v483a/uzrZ5dK7LD6J+OR2Y9BPYDiDK6JKGJJp3xUwBkpj6KotzRGq8NNXmEey3
         oqQFlciVy/zd91XUj67cbDTFk3gmk3Xs71Phre91Xa1RFdNhLTzDPV1UTmMoMsBUceZF
         DcJ29FQbwIG3edZb2pmOEVYiC1GU4HG+o/CL7HCK5gJEO1MvE717y6Y2HJRaMX1vg6Jm
         mKGASaNRzKPdMogIE1IQ7RKq0P/ZiSs1ZnXszWViKP4xAYjzZh3sYra+Lvx5AuiWmvL1
         QAzb5Ek5mApKL/CQHd+XjdeYo2AZjmh88x9yIbWPXDskE2RolZs2XEp9rKXmKmq7AUNV
         D21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=45/772M2ivi6fpTGCjKRNRa8Df2a9ZbYROKdGWmG3gw=;
        fh=PsEUo3PJsk80oaO0HIwmBQkeluxzDKkoyr07qduhPUE=;
        b=gw1Wh4BByWIUEtMGRcnxf9m0/zSjOl+cl5grmPKlAwyruhRAfgnk0tMKBatpFubHey
         grgFsku9BJwHNqjoO5lqCxN8hg4Sj23l82TvjxPqbgWRsbvLZ+dxe7OZCL1eZCnBguxJ
         JfoI9X3+o3TS32G4o2VsbXItyZsMPFaf2xqkDGP+kJRadw2Zs1r/pzQdldNlnNZdduOc
         i23zyaqnSmchtbU2Ji1TCd3X4rGdkLdRQXm73lTeJV6eVqgmE3miIG1bgYubGZ9/yS0m
         7nl517LbPKdbB9dw7wcak7HFv1nuxzEV5vXD9kosJydfMK9u6ePhARDYW+6axERUXN/h
         f9og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783712274; x=1784317074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=45/772M2ivi6fpTGCjKRNRa8Df2a9ZbYROKdGWmG3gw=;
        b=ijN7czOAiATcTtfBbkJR4Okma9ktX29Y2b3rSc2imx2QePg5vGv/u39Dg+6/FoPnRo
         d8Y/43QOh5DZtlD5v8JKuWrPYKjCf/A76PN8Ow76qAhEPIWmtXJENLoAvRB4F/Dr0O2R
         MiWu8VEMbBmQbSbcstRFq+zpxwr7czM4AC7RdRFg8zADs6JhP14Y8q9Q5RcEm5dJ5xfw
         fXiGxLd8nUcb6vDKjHtSBeOmTbglltmjO111IERjygDBVg3tR19JEdqsE3L/1fIN00OE
         sqdReRaGJjJs57ziAl/n97MddQPNK2l76idvoqVDUBEN3oSQAMbRwVUgKhm8X9w40srv
         wJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712274; x=1784317074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45/772M2ivi6fpTGCjKRNRa8Df2a9ZbYROKdGWmG3gw=;
        b=WLO2rFplDrN5A8uTavalDrT5R76mPqDWeEQzo+aTf4GdvIBtk+pR5lInBc1IyySfnY
         Ey1vbOYbgEXYGceDv+rI/0pWZpbkoACBCLxjTb/u0YQZR9Rorqb+9DWNiYTNM3vy5EAE
         0uBYytkUPoaMiAHxBGatrIwwwB8Bh1qAE3xCYkmDu5fyTzB3P4Womb9zBmCYzIlFUjKP
         GBZl1jawZqewBTO9wlcR0wZFko93l50QN5DhznBSymfDp6K9INrKLRnJY6+c8lvG6j7S
         JjSS94jIKuFjL+5/jWV2Kx5kNBVPP5bGJTD3u5mHEfc6WFcMX7Vnx6tJwyP37NoTVer8
         jEHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYvQDzZeX+Y69Lk2RUrAhr+XjY0dmMqZs3R+QNxW4wkHWmgTEs5HnuY+RBmbDxTixEGeZ1im9gUCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vDwBSVaZ9XKWa6YFMSX1nb4igNsRJxgQIVFkM/XoX8YxKyz+
	eHVHNIFoN0it6qxBh+JB0HXN3V/+HXIiPi1Twe/Z8Nq/SKrPZDpPEMc1ZglyBBvD4K5xBeYDddN
	esgXsWEVj/Ni4p0qJHbmEEW8nzmCAjT362d6PKHxNKXy+nrErtLNiKubpnUU=
X-Gm-Gg: AfdE7cnpvQNB5I1DayCTZTS6WAp3i+PZzDZvwmSfyfp+L/VjaEydMX/Gp0QIHnlN7BI
	FB/oNM1Gz1TlWQriA/AJsNZEWJWJ48ercRSS2xGkyAGalWHiohwAah2m6JMeaK+sjtsOsbXHPrt
	afYWyJufRUBHVSapZtPkrIkOoFzvkdgs/ts20TOrN/x+NZBh3NcGHd8nrSawlbXHvfC4K4dc/TV
	VDesNYcquHwFCpIhAjfm4CvnjnbxnVk5SILV6r4XBDVp2KXkPYWutnndPZN/0iUYvB+xgg/0jb4
	AHFlP4h/iK1b4FUlR2lew2i0MLun
X-Received: by 2002:a05:622a:c01:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-51cbe686cdemr1615401cf.11.1783712273761; Fri, 10 Jul 2026
 12:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702020142.3399851-1-rkaruna@google.com> <20260702021411.B01331F000E9@smtp.kernel.org>
 <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org> <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
 <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org> <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
 <0E78BE5F-B4EE-460A-A6D5-F0CE47BFC7DF@kernel.org>
In-Reply-To: <0E78BE5F-B4EE-460A-A6D5-F0CE47BFC7DF@kernel.org>
From: Karuna Ramkumar <rkaruna@google.com>
Date: Fri, 10 Jul 2026 12:37:42 -0700
X-Gm-Features: AUfX_mw4uC-QpbL3MfJaXisd2xgR5S7uGqtH2tHtdoxGsMQs1DyRcDNHLIpWeW4
Message-ID: <CAD50XqqyJu7eQjXyBkQa+O737qfWaJb3Mc6-hhF63juanc5Vyg@mail.gmail.com>
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, sashiko-reviews@lists.linux.dev, 
	linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 6:11=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
>
> On 9 July 2026 05:34:14 CEST, Karuna Ramkumar <rkaruna@google.com> wrote:
> >On Mon, Jul 6, 2026 at 6:10=E2=80=AFPM Damien Le Moal <dlemoal@kernel.or=
g> wrote:
> >>
> >> On 7/7/26 08:10, Karuna Ramkumar wrote:
> >> > Before I start working on this, I would love to hear your feedback o=
n:
> >> > 1. Whether you think this API update (passing `rbuf_len` down to all
> >> > actors and helper functions) is the right approach, or if you prefer
> >> > simpler, and more localized checks elsewhere.
> >>
> >> I do not think it is necessary at all because rbuf is statically decla=
red:
> >>
> >> static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
> >>
> >> So the buffer address and maximum size is known to all functions using=
 it.
> >>
> >> > 2. What would be the best way to test all these simulated command
> >> > paths to ensure the fix is verified appropriately?
> >>
> >> Most functions for emulated commands generate only a very small amount=
 of data,
> >> far below ATA_SCSI_RBUF_SIZE. So I would suggest that we simply add ch=
ecks to
> >> the functions which may potentially exceed that. Off the top of my hea=
d, I do
> >> not know if we have any, but we should just check.
> >>
> >> Note that ideally, we should have each function allocate their own loc=
al buffer
> >> to handle the translation. But this is right now a little hard to do b=
ecause
> >> these translation/emulation functions are called with the port locked,=
 so we
> >> would have a memory allocation for a potentially large-ish buffer unde=
r a spin
> >> lock, which means no reclaim/no wait allocation, and thus potential fo=
r failure
> >> which we do not have right now. A proper/ideal fix would need to drop
> >> ata_scsi_rbuf, have some helpers for managing the internal buffer and =
redesign
> >> the submission path to not have the port locked until the translation =
is
> >> actually generated. That is all more work and more changes.
> >>
> >> So as a first step, let's check the emulation function if any of them =
can exceed
> >> ATA_SCSI_RBUF_SIZE in size, fail them with internal target failure.
> >
> >Hi Damien,
> >
> >I went through all the SCSI actor functions in libata-scsi.c and
> >calculated their maximum size consumption.
> >
> >As you mentioned, most command emulations triggered via actor
> >callbacks write a fixed or small amount of payload, and are well
> >within the 2048 byte limit of `ata_scsi_rbuf`.
> >
> >There are two functions that can potentially overflow though:
> >
> >1. ata_scsiop_inq_b9: Writes 64 + nr_cpr * 32 bytes. If nr_cpr crosses
> >62, then this can cause an overflow
> >2. ata_format_dsm_trim_descr: Writes trmax * 8 bytes. If trmax > 2048
> >/ 8, then this can cause an overflow too.
> >
>
>
> Please note that ata_format_dsm_trim_descr()
> was changed recently, on libata for-7.3 branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=
=3Dfor-7.3
>
> I don't think that this function can overflow anymore.

Hi Niklas,

Thanks for the heads up! Since ata_format_dsm_trim_descr() is already
fixed, I created a patch for ata_scsiop_inq_b9 and pushed it upstream
for review.

https://lore.kernel.org/all/20260710193235.334782-1-rkaruna@google.com/

Thanks,
Karuna
>
>
> Kind regards,
> Niklas
