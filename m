Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1863B27EA;
	Fri, 10 Jul 2026 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665781; cv=none; b=NcOAKxe0A1aULEUwfr/s0xSL2Ii+F5YweosmJt2cUI8QMDV+pFYwpEqrVdeDulXChbqSocfouZk3hsXSEwSqt+cqWkboGUi8fPnVTA0C4VNTbM0fegEq9QdNgFDzeo0mx1iMsQ22AeOhgf4iPWc2MpXkvfAjjtYs6uEAliexOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665781; c=relaxed/simple;
	bh=dYPQ3qI7LzGINyL+H9EE/9uwSSKr+tivpILGoN07k10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2GMhsP8YLQO27+qsw0jjOxjOdNAYYGq/+Zc7xOeYEPIvSAhEw9lpF0RN7jfEmDOUsW9jMy+ZI7nuwklMQLNfT3ZEaxAGmtcPIP6hC0nQmk0HrdHAMC2utwlaRFiUPEWFsP0r3IIkls04uHB5Sb49kQJsFoKh42wE3IRehUB0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-e4-6a509471be8b
Date: Fri, 10 Jul 2026 15:42:52 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: Chuck Lever <cel@kernel.org>, tytso@mit.edu,
	Anna Schumaker <anna@kernel.org>, linux-kernel@vger.kernel.org,
	dlemoal@kernel.org, dri-devel@lists.freedesktop.org,
	Jeff Layton <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev,
	ojeda@kernel.org, linux-modules@vger.kernel.org, cassel@kernel.org,
	linux-ide@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 13/40] dept: apply sdt_might_sleep_{start, end}() to
 hashed-waitqueue wait
Message-ID: <20260710064252.GI37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-14-byungchul@sk.com>
 <20260707073317.37C831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073317.37C831F000E9@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhesuzULdwSkCWwdFjMhatO/+zWBybsILZ
	Yt2LI2wWD/bbW1z5+p7N4ueyVewWx3Y8YrK4vGsOm0XD7O+sFpdWX2CxWDl/OaNFw9LbrBat
	PT/ZHXg9Nq3qZPO4332cyePF5pmMHk1njjJ7fN4kF8AaxWWTkpqTWZZapG+XwJWx9uoVxoIl
	UhUrvk5mb2BcLdjFyMEhIWAiMfe/SRcjJ5i5Y3kfI4jNIqAqMXHNGxYQm01AXeLGjZ/MILaI
	gLLE7B1nmboYuTiYBV4wSTS0N7KDJIQFUiT2fDgNVsQrYCHx8NciFpAiIYFJjBL3/rUzQSQE
	JU7OfAI2lVlAR2Ln1jtsIEcwC0hLLP/HARGWl2jeOhtsDqeAlcS1e+fZQGxRoMUHth0HWywh
	8JpN4tGWw6wQV0tKHFxxg2UCo+AsJCtmIVkxC2HFLCQrFjCyrGIUyswry03MzDHRy6jMy6zQ
	S87P3cQIjKNltX+idzB+uhB8iFGAg1GJh9eg3j9LiDWxrLgy9xCjBAezkgjvAxmgEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsaOmsd5SxoU4gxYL530
	nx3qys6mZarxzeNCwt/lT/eYfXN3EN27NuPLcx6NySfXZ7E+WCl7pUFy1gnDpVXWHzm2lc30
	+9D+6fnZJhl9prDFch3fJnw9b1i+rbHhk8qEyLDFJvN1lRg+b3+6ZS6b8Ym8uo6w3XOYz879
	vWtTdnV4aNxVuZePrlUpsRRnJBpqMRcVJwIAkqUGd58CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrFs4JSDL4Ec/l0Xrzv8sFscmrGC2
	WPfiCJvFg/32Fle+vmez+LlsFbvF4bknWS2O7XjEZHF51xw2i4bZ31ktLq2+wGKxcv5yRouG
	pbdZLVp7frI78HlsWtXJ5nG/+ziTx4vNMxk9ms4cZfZY/OIDk8fnTXIBbFFcNimpOZllqUX6
	dglcGWuvXmEsWCJVseLrZPYGxtWCXYycHBICJhI7lvcxgtgsAqoSE9e8YQGx2QTUJW7c+MkM
	YosIKEvM3nGWqYuRi4NZ4AWTREN7IztIQlggRWLPh9NgRbwCFhIPfy1iASkSEpjEKHHvXzsT
	REJQ4uTMJ2BTmQV0JHZuvcPWxcgBZEtLLP/HARGWl2jeOhtsDqeAlcS1e+fZQGxRoMUHth1n
	msDINwvJpFlIJs1CmDQLyaQFjCyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAuNiWe2fiTsY
	v1x2P8QowMGoxMNrUO+fJcSaWFZcmXuIUYKDWUmE94EMUIg3JbGyKrUoP76oNCe1+BCjNAeL
	kjivV3hqgpBAemJJanZqakFqEUyWiYNTqoHRoOT//Pl/Tp+e6fm88aqayeedP7gZI/asK+Z+
	6HneadMDsZRKK5037rtrY5VlLLIZnxrEKuaxtWWnBkU2c+5IdTH4t87txkPLw1sk1mnMEfQz
	0F8V7Fcro/Xy6PrpFltOXyv7YBB7RnKO4x//fX8Ufs63nHolvTVpVfT7r7v2/RbP/RHz7HGA
	EktxRqKhFnNRcSIAPLNln4cCAAA=
X-CFilter-Loop: Reflected

On Tue, Jul 07, 2026 at 07:33:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_var_event` is interrupted, leaving the DEPT tracker in an inconsistent state.
> - [Medium] The `sdt_might_sleep_end()` macro is bypassed when `___wait_event` is interrupted, leaving the DEPT tracker in an inconsistent state.
> --
> 
> commit 0bd2d42866fa6b852ee5317edcaf6890a90c3c65
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
> 
> Make dept able to track dependencies by hashed-waitqueue waits.
> 
> > diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
> > index 9e29d79fc790a..179a616ad245a 100644
> > --- a/include/linux/wait_bit.h
> > +++ b/include/linux/wait_bit.h
> [ ... ]
> > @@ -257,6 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
> >       struct wait_bit_queue_entry __wbq_entry;                        \
> >       long __ret = ret; /* explicit shadow */                         \
> >                                                                       \
> > +     sdt_might_sleep_start(NULL);                                    \
> >       init_wait_var_entry(&__wbq_entry, var,                          \
> >                           exclusive ? WQ_FLAG_EXCLUSIVE : 0);         \
> >       for (;;) {                                                      \
> > @@ -274,6 +276,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
> >               cmd;                                                    \
> >       }                                                               \
> >       finish_wait(__wq_head, &__wbq_entry.wq_entry);                  \
> > +     sdt_might_sleep_end();                                          \
> >  __out:       __ret;                                                          \
> >  })
> 
> [Severity: Medium]
> If this wait is interrupted by a signal, the loop executes a goto __out
> which bypasses sdt_might_sleep_end(). Does this leave the dept tracker
> in an inconsistent state where the task's stage remains permanently armed?
> 
> This could cause false positive dependency tracking splats on subsequent
> waits, or fail to record new dependencies because the tracker is blinded by
> the stale stage.
> 
> I noticed the exact same issue is present in ___wait_event():
> 
> include/linux/wait.h:___wait_event() {
>     ...
>                 if (___wait_is_interruptible(state) && __int) {
>                         __ret = __int;
>                         goto __out;
>                 }
>     ...
>         sdt_might_sleep_end();
> __out:  __ret;
> })

I will fix it.

> [Severity: Medium]
> Does ___wait_event() also skip sdt_might_sleep_end() when interrupted?
> By missing the paired cleanup call, the task's stage could remain
> permanently armed here as well.
> 
> Would it make sense to move the __out label above sdt_might_sleep_end(),
> or otherwise ensure the state is cleaned up on the interrupted paths for
> both of these macros?

Right.  I will fix it.

	Byungchul

> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=13
