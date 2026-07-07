Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E641D4FD;
	Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409637; cv=none; b=uivTJlJY/pgEsvurc7tYfk2U0USF5xtsu+A3yxAFsuDUATv/Rl51/lh4FOXqincq5Gon6IESf9iDT4ygIOdIq1sWjMIXEO+R807qC9g5aCv6CaUmDDIdkxOIJcNJsEB3LePQ6h43IvnpSKtqt1jMJBzCsIj0NFG2IZ4iNnLmGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409637; c=relaxed/simple;
	bh=Qt6SGxWV7Oexpy3To2teBu5k3MHUzOTtXmcd2MXzk5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFJzsz463iCdDPAIVIGHtCft5I/37LkIEiRAGPdLJ4TjOKDtTQtHZKKWeZwZ8oz2W9KzfcalTBY6dPuGR3D538N1Q+biRdcd6HsNmoSfd9q2/qwveRtODFw7Dq3N8E7t7npcj+NMQgAikSEjGvZhPH4nfMGJPQ8EFGdhBuZbzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3HXpSks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3HXpSks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898551F00A3E;
	Tue,  7 Jul 2026 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409636;
	bh=bmFy3RTkV6oAfOtQ0nNMgDyx+nF5cTbzOJUQB1Z58go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3HXpSksWy6w5ACTbnbwRwH4/A88iFU8tLWdJY3uKS67ez0MUDiflPfoNLaPy4qu8
	 wEtQ30IT1rPCokCIZ9xrld3nFhMzdeT9FuccqiyYpAsC8qw9lVzMtEJBMtYFJzruep
	 qwrzdVy/gKo8INTxnDYkhmaOTgiDxIRBKMmhaCZffL1AIfCrOejlsJyheFL1FNQk2D
	 1kXpsi4cS3fFrAfR4VBf99X5g9JygKFamAmbMIrs5pspYVoKPTj1IMxXCY+Se4OH8u
	 7tPp94jHox9Jkif7DAHBNlliPuBWCygRoLvlXLz22LHmF2y1cumV5J5EjXAP1vZvWx
	 dGyL8RTxhe9kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 36/40] dept: track PG_writeback with dept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>, linux-rt-devel@lists.linux.dev, cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, ojeda@kernel.org, dlemoal@kernel.org, tytso@mit.edu, dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-37-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-37-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:55 +0000
Message-Id: <20260707073355.898551F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] False lock acquisition registered in DEPT for SHARED waits on PG_w=
riteback, permanently corrupting the task's dependency graph.
--

commit 9dc48dc95eded487307805ef6bce49ac459667ad
Author: Byungchul Park <byungchul@sk.com>

dept: track PG_writeback with dept

This commit adds DEPT tracking for PG_writeback to track writeback waits
and events. It extends the existing page bit tracking machinery to cover
PG_writeback in addition to PG_locked.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0655354b084..ec736811a2c66 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
[ ... ]
> @@ -292,6 +293,8 @@ static inline void dept_page_set_bit(struct page *p, =
int bit_nr)
> =20
>  	if (bit_nr =3D=3D PG_locked)
>  		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
> +	else if (bit_nr =3D=3D PG_writeback)
> +		dept_request_event(&pg_writeback_map, &p->pg_writeback_wgen);

[Severity: High]
Does wiring PG_writeback into this tracking logic cause false lock
acquisitions for shared waits?

In the wait queue logic, tasks can wait for writeback to complete
without actually acquiring the bit (a SHARED wait). However, when a task
waits on PG_writeback and the bit is already clear on the fast path,
folio_trylock_flag() sets WQ_FLAG_DONE:

mm/filemap.c:folio_trylock_flag() {
        ...
        } else if (test_bit(bit_nr, &folio->flags.f))
                return false;

        wait->flags |=3D WQ_FLAG_WOKEN | WQ_FLAG_DONE;
        return true;
}

Then in folio_wait_bit_common(), it unconditionally registers an acquisition
if WQ_FLAG_DONE is set:

mm/filemap.c:folio_wait_bit_common() {
        ...
        if (wait->flags & WQ_FLAG_DONE)
                dept_page_set_bit(&folio->page, bit_nr);
        ...
}

Because the task never actually acquired the bit, it will never clear it,
leaving DEPT recording the lock as permanently held. Could this cause
DEPT resource leaks and false positive deadlock reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D36
