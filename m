Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDB3C98B5
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835265; cv=pass; b=utAYX6pyQWZ6LUdUk/Es5k/56mhuLs5rI6OyOvMEKs5xknEndeqPtMxXj4E+ONfQSGHVoyylOH5mlRJmJ7snLodArMPalS0VLpv9ipU5LvG1hDXyBmxJhIsIkbFhsZD14Jv7y/mPBNUI+1uyNg35RDxEMIO+xIVDBYEOLvIJpds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835265; c=relaxed/simple;
	bh=zpqx0sx4lBvPcz6P0QMViQlREyJU3QVhmzAiRWaINMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyj0/RLRbGnWALKANLcjE1ncTajDHf0SCZM9EYYZo6BAKxXxITorNnYV3aF5PGNkR7bNhpihcUDWuqzf0siWVcfnKLNhi1u/dh/Zwz6fHwtYwy9dkxcm0lSdFVru0+GL7CMNrv60RSUCRbEBvSr3jmEjbT6b6/WIS6LNvLmalgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDUFkYka; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDUFkYka"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3042a388168so3534231eec.1
        for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 15:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779835263; cv=none;
        d=google.com; s=arc-20240605;
        b=S6phlj4dt5iX4xReVEwYEnQUEn0LePG9bBiVnUdmRE2x6q/k8MyYKlb85uRQjFYfeF
         6m1/PbBxFci00Lm0YqLGOVHFuZ6wd5+oo82IHvSxZD3Ib3T9GFAjyQ3ij8WiHRQZqwjH
         W8Gres7O9h1nl9DlCeGxV3x82OVVjkGSt8ClbNebtfj9juQUnfnTnS1WzCsnYgoO6f2O
         8ZHztA7AJzqAuEElE/j30pnEyrUhLsamWUJKoNRjb7HiPwj8YxqgcqlPd6B8/7x81OHN
         eMUOulCgsH8Zs6qzAnE8SBg588ZTEUepDW766bzhE0wGUz4vDKn3U9UbPLmGu7571d22
         RHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R+ZbZMXXu+QYZpQRkt1/PiHnFcJ5L0sv3opcO8C7h4M=;
        fh=VUfVBnaB2dBFRZG41umIF6r4PYdYj6azGRU2eON1zhU=;
        b=BIdioqwkq4qzg/44xsREI/0W11sPczfl59NvQYKH8fjF96TfvueX62/u8pEXxWShKO
         3OpkBidz770yk2zNF0uv5Odqo1IrjZst5EJyInZvtBqgGetDe82JOKpoAxCvnHRvsUCP
         qeTjFYqyx/0Gsq45OGU6NMv4AFIaWXnHywa33Meigg/XRvYSssfW6vMWikG0+qbocP8R
         vjYvK5/DBbGxkulUyHf1w8pvBWXzRRSsO1wZVneGigyeRkwFVOkQsL9eo87jA1Wnmrsh
         QW75Y51KclM9/piDZ/iIBwsrH/DSSx5kunZ8wcFk1xXicqdNrDSH7ekA3qwgc0FFQVjQ
         oU8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779835263; x=1780440063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+ZbZMXXu+QYZpQRkt1/PiHnFcJ5L0sv3opcO8C7h4M=;
        b=BDUFkYkabUWXa/Rel34oHURo2urlT9DKcEohkkGE0hle0H8L4f7ieiJAMCRImshmue
         AV1yzzzlR8KsJuoQYixAA4cZJ4k3AddgCUtoq6lEpsMFYcwaUh9kmXbsOLUh/BE4Kuor
         2YVtUe/CiEPXZeyNxz1P1+7yUv53u3xuDSNboGdPh1E4X8H79+u15eI1HkGJykxU6Nbf
         +ENFzwQcPLz8srR6kGMjX4RwsRvL5cw1BMlkLt6VhzwrYJSXNAZad3BUTpWUp/o2vn1r
         jF3vwVy5F4smKRYZyFS9kuFueHO97l9EO43SMunwpdROwUwmoh5oz5jUjZKxDv9/iAhG
         Z8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779835263; x=1780440063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+ZbZMXXu+QYZpQRkt1/PiHnFcJ5L0sv3opcO8C7h4M=;
        b=MmMJSsQJxsMNtM/2hjLVbeEiNN/srKcrnMwIKowIbwb72V88Kbx/04n8gZRazMgI7E
         mY0VCV4JiYYnCBnDkgi+FFolwBi5pDJJY4Lxi2z0z5EBxxSaCbbujQgedCeKRKCoAegf
         Edd9RLWdZQFcsW/zQwuaJpyu6V5qrBo8AYl92nMoxFytjlMohu7LhrzrYL34XoB+nBn7
         ZNXrZrNYU5x0FxxQZfc82KdFC3+XTd82eCdQBoUbXtnIn1VpaADmi0fQXjuaoELIJilB
         gc4vLwEe+Puosduy2+dEEggBsRdyjtEhb4pEmUYzBnBtUqzRMSN05E3ZhwiMfNNgbTTA
         uyYA==
X-Forwarded-Encrypted: i=1; AFNElJ9RCLqG09kdCOZE6aweopg82Lzi43FDy+AbM7LiSzSuwvdjEhp5S41ZYnRCbdYrJzeUGvxzOpqxuc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkbEVw28phw/8bHESMsyZla0QLsJWeEVn0z22ApiCLX/Pr1WA
	s7+5NqZQzhzh1NWsoZuIS2nWvYQyHROKNruo6WRXI3d/QID8+hQ0+tIlNx1126Vz+DVbrc3PbLp
	uaT588Or5iUlVq/ytTGNhUXDDP7WG2pBSb1y2E95G
X-Gm-Gg: Acq92OGeRz90xqhC7UtkJG8MnDzqbagoPh5vRcJu23g4WIdO1OZaQEdvqyagUV1GPML
	TDPrqgRyNznCFz4fduffUuRim+EXTvzFSdP/CBfIZGvkZOgtXvTTbK00f1e0IFu7cGLaIKDFstc
	Cg4NDE+cLbIxfKTKrIu248/YpAaQPdWM7dOa0BuY/sT2ACvtu6PoJu6PoJAfRgNSLxNMhB3S7GK
	DhtEqRgevtQOu6j7QE4DascSwaTBsd3p1PUgrCAxDTthSVv9KEQyBW83v+BG64P/QxHguYL5BNU
	+95OU9muOll6uIx0nPL815rXrdFtHmyOvwrdDftjaXNDty8wjQ==
X-Received: by 2002:a05:7300:8c88:b0:304:13f3:ecdd with SMTP id
 5a478bee46e88-3042fc83f2fmr9985615eec.0.1779835262042; Tue, 26 May 2026
 15:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521173347.2079560-1-bvanassche@acm.org> <20260521173347.2079560-10-bvanassche@acm.org>
 <ahW5MI_05l2bpKBN@ryzen> <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
In-Reply-To: <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
From: Marco Elver <elver@google.com>
Date: Wed, 27 May 2026 00:40:24 +0200
X-Gm-Features: AVHnY4I-Q1Y5qQ_JLA7GxC5v03MPkhLFhlchxtNFW1PQECsJuAfDSgNph7_A6Yg
Message-ID: <CANpmjNMU4nwg==7pn0UAXY9Z5s-4dZFgPwxEHHhwvhiynSi_cA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
To: Bart Van Assche <bvanassche@acm.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Mikael Pettersson <mikpelinux@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 23:33, Bart Van Assche <bvanassche@acm.org> wrote:
> On 5/26/26 8:16 AM, Niklas Cassel wrote:
> > On Thu, May 21, 2026 at 10:33:37AM -0700, Bart Van Assche wrote:
> >> @@ -5162,6 +5165,10 @@ void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
> >>      struct ata_link *link = qc->dev->link;
> >>      u8 prot = qc->tf.protocol;
> >>
> >> +    /* Tell the compiler that qc->ap == qc->dev->link->ap->lock == ap. */
> >> +    __assume_ctx_lock(qc->ap->lock);
> >> +    __assume_ctx_lock(qc->dev->link->ap->lock);
> >
> > When I look at the definition of lockdep_assert_held(), when building with
> > lockdep:
> > https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L284-L285
> >
> > When building without lockdep:
> > https://github.com/torvalds/linux/blob/v7.1-rc5/include/linux/lockdep.h#L392
> >
> > Even in the case where we don't build with lockdep, we will call
> > __assume_ctx_lock(l);
> >
> > So my question is, why don't we instead add:
> > lockdep_assert_held(qc->ap->lock);
> > lockdep_assert_held(qc->dev->link->ap->lock);
> >
> > Right now, there seems to be very few __assume_ctx_lock() in the code base,
> > would it not be more consistent to add lockdep_assert_held() calls instead?
>
> My opinion is that adding __assume_ctx_lock() in the implementation of
> lockdep_assert_held() was wrong and that this change should be reverted.

I don't know how to convince you otherwise, because the trade-offs are:

A. Current design: lockdep_assert_held() implies __assume_ctx_lock(),
and ensures that assumption are checked at runtime. Soundness, which
is your concern, is only affected if we never cover this code with
lockdep. For complex control flow or cases such as here, we have a
_sound_ escape hatch, not because the static checking is sound, but
because we _force_ a runtime fallback. That's the intended programming
model here (__assume_ctx_lock alone is discouraged).

B. Remove the implicit __assume_ctx_lock() from lockdep_assert_held():
For cases requiring __assume_ctx_lock() annotations, we have no forced
runtime fallback. We need to explicitly add lockdep_assert_held()
alongside, which is ugly and hard to enforce. The design is less sound
than A, and requires more churn, neither of which scales well.

The problem that lockdep_assert_held() suppresses useful checking is
only a problem because we're dealing with code that has pre-existing
lockdep_assert_held(). The correct design is A, it's just that we're
dealing with a codebase with history, and it'll take time to remove
redundant lockdep_assert_held() where Context Analysis now offers
better (static) analysis. Starting with the wrong design, and then
trying to transition to the good design is harder than accepting the
small hit to

> Most code annotated with lockdep_assert_held() is suitable for compile-
> time context analysis. Adding __assume_ctx_lock() in the
> lockdep_assert_held() definition suppresses useful diagnostics from the
> compiler about a lock not being held although it should be held.

Then the assumption is checked at runtime when running with lockdep.
This is by design, because it goes both ways: every time you now add
__assume_ctx_lock(), someone just has to move that code around and
suddenly the assumption no longer holds and you have a bug. If you
were using lockdep_assert_held() you're at least ensuring that someone
running with lockdep (e.g. syzkaller) will catch the bad assumption.

> Whether lockdep_assert_held() or __assume_ctx_lock() is used to help the
> compiler alias analysis, there is a risk that these annotations are
> incorrect. My preferred solution is that a new macro would be added that
> supports expressing pointer equality in a direct way to the compiler
> alias analysis engine and also that evaluates pointer equality at
> runtime. However, I'm afraid this requires compiler changes and changing
> Clang is out-of-scope for me.

Telling the compiler about pointer-equality is also unsound, because
there's no way to verify our assumption statically. The only way to
recover soundness is to again introduce runtime checks of some sort.

> I chose __assume_ctx_lock() because it is evaluated only at compile time
> and a compile time annotation is sufficient in this context.

There's a real risk that your assumption may become stale, and if it
were my codebase, I'd prefer lockdep_assert_held() just to make sure
we check our assumption at runtime. This is not my subsystem -- just
my 2c.
