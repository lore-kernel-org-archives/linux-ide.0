Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525B1C6A4
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710716651; cv=none; b=ueuEr2Iu76u6KnRkc9TWh4aMsXAyLcC3IwGj2ZJ4SaZeAGnuhrfJrsxgnvFfC2wzSs2O/Q8zO4dLULIBOCqRfvFo2y63bFuuateCyNUyLoUIfigLMc/y89AfThb50eigLkNhAIv0rFr15FiWv/U4DGZCFec5F3JYnz3FAcEiyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710716651; c=relaxed/simple;
	bh=qsuSP55IJaz96rIm1ggbtxEKR6unZnEH6+p41dD3hXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr1c6yo7zRkFLYF0DMiMIkWMt/Gn5RJgAJl2md2BJdeRp6lmoAw8nveDKpxPH/B/PQNQjdZY9jvRiDKFtP/v99H6rN/c5PFs99Vfr7nj2DJgn5ihTM/8rhIEUBoELyzVlxwzy23uI4g3WiWv39BSpzZ5Fe67Y6wr54oyCKfwCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rK9RyCZF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rK9RyCZF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmn9C4zuH2Y03Ct1wAffnMNpKXh+6MBRs4rSCq8sR3w=; b=rK9RyCZFs0DObc5qDMovm4lDoN
	7uw19vmNmn3VU08/6wtYk2G6N/Bx/HBnYdKKqRg6OthIcOwsE10dF0ZTlMO2mLhmHujLDXOsIwlTZ
	x7Vzu+3o6W7Y6N1mzZawdEQWTd557zGQCxUD+C3oPnCW7VNWSjjEKzdcax7lcNo28DbMijIzQdSfX
	flqvVPuNQ1FuUWV+0uh6LP0hB+9VAF5NJMCku+1Mgpcs97RUeSyQiOyaF5w6QT5TbQG1Tv2scmIZI
	NnqIu/ev0i32EMsxYMHfB2C8lrFLeMLuFHXfMEHkkuJ6oxaKCR5Sm8iT7jognOieSG0q81tysDK4a
	LCr6BmRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlzY0-00000006hsl-3PUk;
	Sun, 17 Mar 2024 23:04:08 +0000
Date: Sun, 17 Mar 2024 16:04:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cryptearth <cryptearth@googlemail.com>
Cc: cassel@kernel.org, temnota.am@gmail.com, linux-ide@vger.kernel.org,
	conikost@gentoo.org, hdegoede@redhat.com
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Message-ID: <Zfd26ImhVdOSUuEf@infradead.org>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Dude, if you don't care about our kernel holdrs copy rights and want
to use non-GPL moudles you're completly on your own anyway.  Say this
early and don't waste the kernel developers time.

