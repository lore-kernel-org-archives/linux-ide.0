Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E032505CD
	for <linux-ide@vger.kernel.org>; Sat, 10 May 2025 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746878385; cv=none; b=SXgQxfYdEtmCV5Bvtz9GvWWizHnQdMnpZ38brxlNsxxdSVUnpbL4pIboNrw7K1oSntE4RNKLrWtb5qcld+rl7fVTPyU23b0gXwXM0pi3nMZ8+1xOtdOhq//K8rdf8czQSZbqRqL0I4ZGJ8bI0Ugnpf2IejqQqq4/NhEX0lcFWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746878385; c=relaxed/simple;
	bh=xJZHjhd96NmP1l027iUb3em6YmlinjC3jACMCTT010o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pq+0+RGha+Ii6QQQb3iXvK2oG4GUu+/T9gfMk83dRnYAlVyDmFFP9tQgncDUDCPzrQskMl8uoN++hoiuc98YPN1IYzRa3lvVOXfOmbXECMOcayWsbU1vWyex971ohpVeEvPcdlRIHUfVMRWIKDMAD1wxpSZdSwN1UD21zIl4aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwd7HMnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwd7HMnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534FEC4CEE2;
	Sat, 10 May 2025 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746878384;
	bh=xJZHjhd96NmP1l027iUb3em6YmlinjC3jACMCTT010o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jwd7HMnIOqVFbhFuqiaWbnqH8zKh+TPTEvdzxXPvxIwdDuoUVS+b3nJTAK7sbztqY
	 Baux8flRXfm/zPuF2POF7bwtnyTIYy9HH3LEcuf5nJ+jL+xtmD9BWa4gGiJSqRDXHS
	 js2oU6ebjhglkdiHt2hdbw4mqKhsqAw3bQkad8pngGlEkA2rf/mLfoiXrJaCjZ2mjP
	 chvLJ70yl+7iRON5MxGhW2AlrpOexOfTGGAnOJr9ioTziCGI8VlylXiHtYl/sXhGgB
	 y+H6UAos9P+FVWPM2xkEM500LtO25dPZxaoZ3UllXu42l5oC+9Ho4YUiTenUOtdWni
	 1NjcUW7gf4yhA==
Date: Sat, 10 May 2025 13:59:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aB8_rITWsMzkTiyE@ryzen>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
 <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
 <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com>
 <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
 <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>

On Sat, May 10, 2025 at 01:14:52PM +0300, Mikko Juhani Korhonen wrote:
> ke 7.5.2025 klo 11.56 Damien Le Moal (dlemoal@kernel.org) kirjoitti:
> > >>>>> On 5/1/25 05:36, Ioannis Barkas wrote:
> > >>> I have two WD20EFAX-68FB5N0 and both behave consistently, unusable
> > >>> from 6.9.0 on as they just keep resetting the SATA link , but they
> > >>> have worked flawlessly with 6.8.x for a year and also now with the
> > Can you share a dmesg output for the good case with 6.8.x kernel ?
> > We would like to see differences with the non-working case.
> 
> Hello Damien,
> here is the dmesg from good 6.8.12. Thanks!

Hello Mikko,

In the (bad) dmesg that you shared earlier, we saw:
touko 05 09:18:59 taavi kernel: ata1: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580100 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata2: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580180 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata3: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580200 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata4: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580280 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata5: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580300 irq 42 lpm-pol 3
touko 05 09:18:59 taavi kernel: ata6: SATA max UDMA/133 abar
m131072@0xfc580000 port 0xfc580380 irq 42 lpm-pol 3

In this new (good) dmesg we see:
[    1.839502] ata1: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580100 irq 42 lpm-pol 0
[    1.840186] ata2: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580180 irq 42 lpm-pol 0
[    1.840859] ata3: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580200 irq 42 lpm-pol 0
[    1.841516] ata4: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580280 irq 42 lpm-pol 0
[    1.842166] ata5: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580300 irq 42 lpm-pol 0
[    1.842804] ata6: SATA max UDMA/133 abar m131072@0xfc580000 port
0xfc580380 irq 42 lpm-pol 0

lpm-pol 0 means "keep firmware settings".

That we see a difference suggests that the value of the Kconfig
CONFIG_SATA_MOBILE_LPM_POLICY
of these two kernel builds are not the same.
Could you double check this?



It is theoretically possible that both kernels were built with the same
Kconfig value. If your BIOS marks a port as external / hotplug capable,
then libata will force set lpm-pol to 0 (overriding the Kconfig value).

However, if you haven't changed any BIOS settings between booting your
two different kernels, then this second scenario sounds very unlikely.


Kind regards,
Niklas
