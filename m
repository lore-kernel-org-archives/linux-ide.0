Received: from melduny.fyrkat.no (melduny.fyrkat.no [217.144.76.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD019D088;
	Tue, 13 Aug 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.76.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559650; cv=none; b=QOKe2R5UdA/StfEqZsLcteMRGH3cNvSMyDMVvFHDv6dg8vYiTu/3sqeQ31GfWHxya1HSz++WPz7jQUdEnpi8RDyUOUDsc31+U5wK6ai1GldpU0mRwg0GNrIkjXjcPUViiG6TB+FGaUvKOl0N+N8u8mn8mPw6vWPueSWf51J+3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559650; c=relaxed/simple;
	bh=GnmamnijN1d9ntajL9FjsTThRSDKiNgbBapoXppW0Yc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZqZTqmMLQYld3i40tJWWCNygbvMTaHqVPP0RTakkRJ4ZjDBdrj+dpirGcdygzNJNm9L0ZdhPPRBqKfBys95e9vhlqToBu0JTLanTvU5d9m8kJdP30Ezz0puGctfpGn1DjOHU/TN2TOBMEx9dolzAdfMcG8TJForOT8CVX1GZ7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no; spf=pass smtp.mailfrom=kolla.no; arc=none smtp.client-ip=217.144.76.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolla.no
Received: by melduny.fyrkat.no (Postfix) with ESMTPSA id 6924C7B5F;
	Tue, 13 Aug 2024 14:34:00 +0000 (UTC)
Date: Tue, 13 Aug 2024 16:33:59 +0200 (CEST)
From: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-ppc@kolla.no>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Niklas Cassel <cassel@kernel.org>, 
    =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-ppc@kolla.no>, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    linux-ide@vger.kernel.org, 
    =?UTF-8?Q?Jon=C3=A1=C5=A1_Vidra?= <vidra@ufal.mff.cuni.cz>, 
    Christoph Hellwig <hch@lst.de>, linux@roeck-us.net
Subject: Re: Since 6.10 - kernel oops/panics on G4 macmini due to change in
 drivers/ata/pata_macio.c
In-Reply-To: <87sev81u3f.fsf@mail.lhotse>
Message-ID: <972fdf28-df68-682c-c5f3-2df33a0ca578@kolla.no>
References: <62d248bb-e97a-25d2-bcf2-9160c518cae5@kolla.no> <3b6441b8-06e6-45da-9e55-f92f2c86933e@ufal.mff.cuni.cz> <Zrstcei9WN9sRfdX@x1-carbon.wireless.wdc> <87sev81u3f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 Aug 2024, Michael Ellerman wrote:

> Niklas Cassel <cassel@kernel.org> writes:
> > Hello Jonáš, Kolbjørn,
> >
> > thank you for the report.
> >
> > On Tue, Aug 13, 2024 at 07:49:34AM +0200, Jonáš Vidra wrote:
> >> On Tue 13. Aug 2024 0:32:37 CEST, Kolbjørn Barmen wrote:
> >> > Ever since 6.10, my macmini G4 behaved unstable when dealing with lots of
> >> > I/O activity, such as sync'ing of Gentoo portage tree, unpacking kernel
> >> > source tarball, building large software packages (or kernel) etc.
> >> > 
> >> > After a bit of testing, and patient kernel rebuilding (while crashing) I
> >> > found the cuplit to be this commit/change
> >> > 
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=09fe2bfa6b83f865126ce3964744863f69a4a030
> >> 
> >> I've been able to reproduce this pata_macio bug on a desktop PowerMac G4
> >> with the 6.10.3 kernel version. Reverting the linked change
> >> ("ata: pata_macio: Fix max_segment_size with PAGE_SIZE == 64K") makes
> >> the errors go away.
> >
> > Michael, as the author of the this commit, could you please look into
> > this issue?
> 
> I can. My commit was really just working around the warning in the SCSI
> core which appeared after afd53a3d8528, it was supposed to just fix the
> warning without changing behaviour. Though obviously it did for 4KB
> PAGE_SIZE kernels.
> 
> I don't have easy access to my mac-mini so it would be helpful if you
> can test changes Jonáš and/or Kolbjørn.

I applied your patch (to 6.10.4 sources) and built a kernel, and did some stress
testing (tarring adnd untarring large archives) and so far it looks good.


Thanks! :)


-- kolla
