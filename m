Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4E225CF
	for <linux-ide@vger.kernel.org>; Sun, 17 Mar 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710719288; cv=none; b=m01jDcpx5Otav5i9+z/KEI2+YVE8/ezJHhxGWXgm6ACog3fH2QBx6FyuEJSzLAVZu428GseKMplnL1bqwP1Ro+vKH20D8be/paCgZ10hxxd9A5JejPshqvRayIdkjH+U+z4xVcC99Ud0eY/c5Q7oFVn0QNDVHJiXjQE3zeEgeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710719288; c=relaxed/simple;
	bh=Hppv6WevO4MjxJ+cbPxGEdMVDvMfVSN4P+uztdQ4J+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmbVt4Z4QptstccaNqR/VeWatyiaHxeEwiD5xyK1DwFlexEyq+rGI+3CQAm2AcnwvzuUlchE8W1/T3qwCQD6awa4hjIa8MmZvFTU1AFX368+7Kg1dzNzUHfnCZWM4+5tcKxtlRug6oVU5KLrMz868z4pBrY9DAZlBNbB7GYbFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tIn8CD3Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIn8CD3Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FUiMVxZJocveLT0cMXvM6PaY/E4sZ7WO5SEId+KJR28=; b=tIn8CD3QTuQOXBv87Vgo7LHqhF
	/R0AiwTUP0ABVd4W8S1g/XWMuKvZun+szmBcbShlschCffKL0c+NlEzpxAR5CGJUcp3Fu2lcYFiJ+
	0ixw+6srM3QNFTBpzzf0jjRnMU6WgXIgxTzlwFfcMEcaThLT1jGGexZgnm+TS9tRb/DtDm+xNMMDc
	nmf7+xHSC3rMKVJ+eJHCbiXfoARxTpPjWYnUIvKfUCUdymmH30DpGWdm+vxoePUWE8t2Qn1cpnzzm
	1rQcltM4qfl/8vLN7VJGsrlU70fGmR3Hdq8rLobp18oc22fAlzlkiV7ME9Z96ov5CnxD92O1ha0Nk
	Z21ml36Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm0EY-00000006mH5-1eOI;
	Sun, 17 Mar 2024 23:48:06 +0000
Date: Sun, 17 Mar 2024 16:48:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cryptearth <cryptearth@googlemail.com>
Cc: Christoph Hellwig <hch@infradead.org>, cassel@kernel.org,
	temnota.am@gmail.com, linux-ide@vger.kernel.org,
	conikost@gentoo.org, hdegoede@redhat.com
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Message-ID: <ZfeBNtNxVvA8G0UW@infradead.org>
References: <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
 <Zfd26ImhVdOSUuEf@infradead.org>
 <CAFDm6W2X_2Nhn4ZeDd-=6Sra-evDW8Dx_CE0m5yggXpOXNTQ9g@mail.gmail.com>
 <Zfd8BWwgznVSgSO3@infradead.org>
 <CAFDm6W3pe+nv5CTcEq2FwGbKS4Cdu+7xdLa1Zy6iODampfwxsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDm6W3pe+nv5CTcEq2FwGbKS4Cdu+7xdLa1Zy6iODampfwxsw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 18, 2024 at 12:44:59AM +0100, Cryptearth wrote:
> Unless you get up to speed and understand the issue ... just shut up!

*plonk*  Please go back to your arch linux forums.

