Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5143783D1
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889367; cv=none; b=J0MgH7qPNvJC26JvzPCBBPrpoFnV0sqebvS6mHv3M/ao27+88STfg2KwVe89a4oqqm7Sl+7hVD03T3RkmHEf2pfmicpeWfpbpAT7iAwvFIUO8fx1JACCxa+5Xj1k+OmFsG6EI+z0ObwB13SnXeH1eiBW/8xnrE/OKCv+d4XyqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889367; c=relaxed/simple;
	bh=8YYaqhcFn9pguJ2njGd8t0vEBRkR7p2951hpmkH0RUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ1fnhmpeAVQ8oYtb4lX6ni+Ih9FKbC/uTKARI1kjnYgJ/OtCTf3cLRDbJhVGO+5k0iZS/DMes43d1wxX0+SCGG+HOfCCIlb61AqAmnZQ7NFWx/7F5gcSdyK/trkPVgyrBRXfOJYr1C2LafTwdKkRokLGCkaspoenaFp/IH0t8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxSzIIIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxSzIIIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132F21F000E9;
	Wed, 27 May 2026 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889361;
	bh=PqssrBACSJ5iHkrABxEeADrC5aLYAsfjHZEGF8YtIwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxSzIIIKmGWM4STC7gidGMB4FMFVVDNp3HKONB2+mxyiVVE8LXfbu4J1f2/jCPaqK
	 5sOgy0Z5EdiF9/rruPjHj+uHi0NoqNquxOSxKrZP89RSLsMc856dXOgLNtkBuHMCPJ
	 tHOTf1Rw97CDb+A/v3JIZod8tFWGop5SXHKEd90ngD/uZ1lK2AzDokNDJ5N9wbDUPJ
	 VGCViSRai2PMebVhxqUh+qP8tdwkTivnMyzUiRv0WJdiXcVluNunyWYWk1I5YlW6Rb
	 jzrukMHgagNmRahpwIdgDOCZBKlFcygIp+fWyLcfIUOXvByIVBesk4f5R7sEh1X4yA
	 ZaAFRUcYJvYQg==
Date: Wed, 27 May 2026 15:42:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
Message-ID: <ahb0zRlRGMI0_WwT@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-10-bvanassche@acm.org>
 <ahW5MI_05l2bpKBN@ryzen>
 <e1e8b05d-6dc1-47c9-8b85-bfb2d756a204@acm.org>
 <CANpmjNMU4nwg==7pn0UAXY9Z5s-4dZFgPwxEHHhwvhiynSi_cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMU4nwg==7pn0UAXY9Z5s-4dZFgPwxEHHhwvhiynSi_cA@mail.gmail.com>

On Wed, May 27, 2026 at 12:40:24AM +0200, Marco Elver wrote:
> On Tue, 26 May 2026 at 23:33, Bart Van Assche <bvanassche@acm.org> wrote:
> 
> Then the assumption is checked at runtime when running with lockdep.
> This is by design, because it goes both ways: every time you now add
> __assume_ctx_lock(), someone just has to move that code around and
> suddenly the assumption no longer holds and you have a bug. If you
> were using lockdep_assert_held() you're at least ensuring that someone
> running with lockdep (e.g. syzkaller) will catch the bad assumption.

My biggest worry/issue with this series is all the __assume_ctx_lock()
annotations it adds. Because __assume_ctx_lock() seems to tell the compiler:
"trust me, I have taken this lock". It seems quite fragile, and if someone
refactors the code, the annotation might no longer be valid.

I suggested something similar to what Bart suggested, a:
__objects_are_equal(dev->link->ap->lock, ap->lock) annotation.
But as Bart said, that would probably require additions to Clang.

But here Marco says that pointer-equality is unsound, since it can't be
verified statically and would have to be verified at rutime...


> 
> > Whether lockdep_assert_held() or __assume_ctx_lock() is used to help the
> > compiler alias analysis, there is a risk that these annotations are
> > incorrect. My preferred solution is that a new macro would be added that
> > supports expressing pointer equality in a direct way to the compiler
> > alias analysis engine and also that evaluates pointer equality at
> > runtime. However, I'm afraid this requires compiler changes and changing
> > Clang is out-of-scope for me.
> 
> Telling the compiler about pointer-equality is also unsound, because
> there's no way to verify our assumption statically. The only way to
> recover soundness is to again introduce runtime checks of some sort.
> 
> > I chose __assume_ctx_lock() because it is evaluated only at compile time
> > and a compile time annotation is sufficient in this context.
> 
> There's a real risk that your assumption may become stale, and if it
> were my codebase, I'd prefer lockdep_assert_held() just to make sure
> we check our assumption at runtime. This is not my subsystem -- just
> my 2c.

Right now, I think my ideal solution would be to, to the furthest extent
possible, try to avoid adding __assume_ctx_lock().
Sure, a few special cases might be acceptable, if there are no reasonable
way to avoid it.

And if there is no reasonable way to avoid it, at least with the current
behavior in linux-next/master, I would prefer a lockdep_assert_held() over
a __assume_ctx_lock().


Kind regards,
Niklas
