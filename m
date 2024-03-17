Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F48208CA
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710717959; cv=none; b=CirkYl4PpkcVQ9BKC361teNye35p2qNx6D0W0JZBKu10+wTgbGaWiEG7J7b0ltldC8+c/8URrK8GS0NdLKc8JBhRRJTSfVS4TFud7D3X/LkBLMfhT3PLuPnowEjj2mVn87Uvp5Z3yP9HI8UNeI8lU0/o1f1RWLIS4evd/Q8rvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710717959; c=relaxed/simple;
	bh=OVpiGEKECEIczEXyTxTlSUd9U688igJTp6b24CwJg34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3RN+b9ZoC2uRmbY2HT7Bo/P47oI4A9pVpkTlqKJiezvUUDemtc5HcOSVAH7Sjz2+4b5t/o05y/4T3fcFNfWonUKLjbALW8rHVXYNOmxIzxZRiKJLxg4oOXV4veRLnizVIYAKWbvjptzQxEN6O5WIKQena3i5+cPo1Di65k1qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nkxKH3FR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkxKH3FR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MSX3QQ3nccAm+ud2sb225SDZrxHwO9FU2CSsKuaAaE4=; b=nkxKH3FRaqfGkI3o0r5qZVBmtR
	xq0ASgcm/8ze7zEfzx2FrJq53op4VkJw9wlj6h2k/DTlW2C6lho3tBDjcZwGtATgjcqOM1FHQrZU7
	toV6bYVVpibahtGtgPgGjdKY5+cwKwX+DDm7zVQfnea0C0SnqJdu9i2mzruyNKXmIq+w9qF2lOkBx
	4JHYenZ9aoNtVBWqZl/5FlSkJ3f+wKHD7mSCC6HD2mCi0IQ3ATPSbFklChx7b2UFuaUHA+fem8dqV
	uvkAgPv5lRiXmCJvTCWGDDZF/nDWp6pzRGw0y2FtNWzylcl5C5LlG6ZX8lSojxGBn7LxvTK2fuC1B
	qJdKwn8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlzt7-00000006k0W-1QeM;
	Sun, 17 Mar 2024 23:25:57 +0000
Date: Sun, 17 Mar 2024 16:25:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cryptearth <cryptearth@googlemail.com>
Cc: Christoph Hellwig <hch@infradead.org>, cassel@kernel.org,
	temnota.am@gmail.com, linux-ide@vger.kernel.org,
	conikost@gentoo.org, hdegoede@redhat.com
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Message-ID: <Zfd8BWwgznVSgSO3@infradead.org>
References: <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
 <Zfd26ImhVdOSUuEf@infradead.org>
 <CAFDm6W2X_2Nhn4ZeDd-=6Sra-evDW8Dx_CE0m5yggXpOXNTQ9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDm6W2X_2Nhn4ZeDd-=6Sra-evDW8Dx_CE0m5yggXpOXNTQ9g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please stop wasting everyones time.  You are completely on your own if
you use sbit like ZFS and nvidia drivers and ignore our licensing.
