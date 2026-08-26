Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF913112B2
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734515; cv=none; b=Dj/Ikdk7yu2ySkI3qrPxo9/55AJJWuRUQz8D6OrGIE9b0KK775PuOLwc4brNJHZkRzuaXvx0wqCbMA/u492NVbthxWlv0DvjIZmogalotKHvJydQQ6Cbg1Th0fWCMJdWCHxTWsC+/Mm3+sk2sswkvZFB31p9Y9pDOZsR0+7M2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734515; c=relaxed/simple;
	bh=O8GKQKz28ZNgMu7z5Eem7Zdo5G+exwtTeHN9QNCrjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IshF4brjr/LkiQB5MqBBjwXcgBbpfJA/mHWkRn5EkKmxoOa2TBHq2a65Nz8QwfRmCZVKCOrJxDjV+3NM2Y4XFpKcV02gGeGo/ss8vx/wZpEB//XbpvOi0nfq8SY2tmPV2zHWWEw3/mJIncx9VHAtRPqYrbhYBcHNKO2A7sLQKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+kev8xo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+kev8xo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so3383858a12.1
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787734512; x=1788339312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+CsASGyH2xOZDi3fuDOU1Hvcxr+b3Bmf36364fbVag=;
        b=W+kev8xoC4jzBZMA9lrpTW+50CrVimEhcLTCr6BKTH9IFMLTGAJdk4U76n5I/Htw36
         hQSQWglm2bWrPTF9DEly3j/B1bs4FgLaFby6X0vD9wDAbVCRJQi+EI5lUgFDp7Q3siun
         +mH61/lB04MPdFSJo6TDlLe4Nkq7n5e+1Z7iXbNHx/Elzsf6sRGRG4YLOotmfqcVAzcK
         gz+HojnOy7K+QMdbC9vUr8vZ8q7grOoRF/X4O1TWjqYv09az9JmKW9AxAVRuVm7q2IFM
         ///96CEndVsgIWqp6pLQnj4E7lfT4KWaPQ526pFJ8YhHq2Ecl7vN6GREO6dFm/cdALds
         664g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734512; x=1788339312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+CsASGyH2xOZDi3fuDOU1Hvcxr+b3Bmf36364fbVag=;
        b=NFVChkmUeKaYCDUCx6FQ+/Uu5kqSIiXMZ19VGx65TxrqOywtQutIoMPSN+k9x/Xe/m
         q+ioPwZR6wqPmEOTPRTdpnWL//xRcuT7ISSefWt9xSVzlbPQS1AyHLQFZwBKXj1ihPHO
         Ay37foijsCUWsKeoR8qpGctBsQXHtckXurpYXFZa1F51FQ3A8/uj+ACf45zbcwOJgV+I
         iWALZ7X0qy/t2hFd9XU13Vit/W/oYhZneH5I7nTJk1g90S4y4BcHINyAwrPZ2gjX9Y85
         B964owgsE/LfRHG4TO0j1/VfUTwL5s+Co5bdIw9cYwOeamiLDEseG6lIVW2ULLbL+SAN
         G8RA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+3+Ji+GQ3PH/oUYhNZY0ZH2kRN6kX/cw7qr/olh9NytZq7egZnOlcRZad1vVpUdA4T7WI5QAz/TM=@vger.kernel.org
X-Gm-Message-State: AFuF++nyule66uUafRIjJFzaRVmt02eYNYR1zqm+jESc/P85aP/Dnw9Q
	Xy+KmNwQwveu+vD+MWd280Ro1RIP/btOT20HQqjHMrMnjcL1m/H5zKUM
X-Gm-Gg: AR+sD10CzprualggExPNci+VzQpeYyR1b/529c82n48UVDo8hHPpJ8diSl4JkNEdJKi
	PxZS3qcy+ZflUWuu5NYBRe2HiJvcbmh+QtUMHZKm8yuZNb8Bw4GZwEOOWwAjH6dWk0V4uYciMom
	NbE/l5QMF4v4ev5R2/vSC3TDOOUN2FGrT9vjloGEni8W0Xze7u8GSp2pPkXGV7Y17cGoEl58QX8
	rpWxMfRzFfgdYHJ81sLu9vg8FKN6NuStO2aN3Mgcb96YqiG1YSMlXb4w0VzGRmjdbGBM6tYtGtJ
	GDijBsuGAM/xb9yiCZ89MPbnu34/Ur73g2a8XMamS9ArmyJ08zThoR+80swmY1NFsx+VOP+xbXW
	FJzCSVI/pd+zAPh+jh2j0ZQIkVA9+pOopc8opbebGKBpkAdR/ufdhW+CnFk/D6bmUVh7H4JgnMj
	vn+zIcLyFGOL6Zz+tDEO/ge93E1M3LAoyRPuJ6lMA5XWeKlEZytnyxoqQuKvfxiXwLAfSEM38Q6
	vkpcZY7ozJXlGoECZ/eXuYz+RKsmU4lgTJzoUKK7wz2S1U=
X-Received: by 2002:a05:6402:a5d1:10b0:6a5:dfb6:360c with SMTP id 4fb4d7f45d1cf-6a5dfb63743mr3614000a12.2.1787734511805;
        Wed, 26 Aug 2026 01:55:11 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:78ce:12f6:160d:28db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8b641fsm3643120a12.3.2026.08.26.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:55:11 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:55:10 +0200
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
Message-ID: <gsfi4glv5fnwzwdw3sm7r2evfwn7gl6xqzjvslxwghdfxvreeu@i6s3xc65iple>
References: <20260824153339.512487-1-p.pisati@gmail.com>
 <20260824153339.512487-2-p.pisati@gmail.com>
 <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>

On Tue, Aug 25, 2026 at 09:53:18AM +0200, Geert Uytterhoeven wrote:
> > +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
> > +                                         unsigned char *buf,
> > +                                         unsigned int buflen, int rw)
> > +{
> > +       struct ata_device *dev = qc->dev;
> > +       struct ata_port *ap = dev->link->ap;
> > +       void __iomem *data_addr = ap->ioaddr.data_addr;
> > +       unsigned int words = buflen >> 1;
> > +       u16 *buf16 = (u16 *)buf;
> > +
> > +       /* Transfer multiple of 2 bytes */
> > +       if (rw == READ)
> > +               raw_insw(data_addr, buf16, words);
> > +       else
> > +               raw_outsw(data_addr, buf16, words);
> > +
> > +       /* Transfer trailing byte, if any. */
> > +       if (unlikely(buflen & 0x01)) {
> > +               if (rw == READ)
> > +                       buf[buflen - 1] = raw_inw(data_addr) >> 8;
> > +               else
> > +                       raw_outw(buf[buflen - 1] << 8, data_addr);
> > +               words++;
> > +       }
> > +
> > +       return words << 1;
> 
> This may be one less than the actual number of bytes
> Why not buflen?

Cause every other driver (e.g. buddha, falcon, gayle, etc) is actually returning
words << 1: i think we are returning the "whole number of bytes" read
from the bus/ATA register here, or at least that's how i understood it.

Anyhow, thanks for the review, i'll send a V6 addressing all comments.
-- 
bye,
p.
