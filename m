Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A07D096
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843752; cv=none; b=T8jTYfqg7o9RdUjxzkW+lpvfQvDCRvvcjz1mfb8J+kius0Ge5j0mtEW9bGcly5GcRVrKvPHyAVjHafosRph5ZCY45TrXXue4DSfx9rD6lgxPhUvjxuVbUYoKvrgVcyvwSRDLLTIxlOq5wPBT89cmFu+NnEhP7tHqRn+VJifjFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843752; c=relaxed/simple;
	bh=o2qyMZiwYgFouV7+Bhtp2YcriKCq50QinqqXrv7sb8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cApYnPPrUbqQrXExxwt9f21icc50XvbUiydGYujkNzah4lFukLCUSlLIJza6TUAK5J0z00rPW+stq18PHascnTnxgfwchbrq+9nsiPXDRr5baYKa5F65JqWlUSAguI7jyK/BhfHqTrThCmRNJza684CS8qq1J/Nyrz8bwnnl6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJxDoKX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJxDoKX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFC0C433F1;
	Tue, 19 Mar 2024 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710843752;
	bh=o2qyMZiwYgFouV7+Bhtp2YcriKCq50QinqqXrv7sb8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJxDoKX2pHZ3pd2vYahx7NLNkznQhHmAnylaj67b4pKOec1Z1wnu+m2fnvdm8dsQw
	 9OLY5b+CvzVcib+PZMWH6iSvdIydHQ6+YgdPOGJo7osrURf6Ovx+2zb+fRf7uEl1AI
	 m0rbXpQB3KCF/IL2f9UYXJetjVwU95p6TMJWloBG2Caa1wfJgw3IBzuiKWnGtNCDHn
	 3pw4a39P1ofyCHYse/sSgHdhtL6Sq8DrQTDPZ3vM8G9H62Bv5Td+TTWFgWxQhAu/LH
	 IWZiwWMEZmEqcIPnWzGd/nO4xz0ujucuGegCcKUVB1Fcv36oB6bfu1hbPpryLBi1s1
	 hX+cm4OzAXPxg==
Date: Tue, 19 Mar 2024 11:22:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Szuying Chen <chensiying21@gmail.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw, conikost@gentoo.org,
	cryptearth@googlemail.com, temnota.am@gmail.com,
	hdegoede@redhat.com, jnyb.de@gmail.com
Subject: Re: ASMedia PMP inquiry
Message-ID: <ZflnYu5W5WnnzDio@ryzen>
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>

Hello Chloe,

On Tue, Mar 19, 2024 at 05:13:22PM +0800, Szuying Chen wrote:
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> 
> On 3/18/24 19:32, Niklas Cassel wrote:
> > A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
> > We need to be able to read the PMP device and vendor ID, in order to apply
> > the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
> > that is connected is bad, not only because it violates the specs, but also
> > because it stops us from providing the proper quirks for the connected PMP.
> > 
> > Could you please tell us how we can communicate with the PMPs directly?
> > (Regardless if they are external PMPs or PMPs embedded on the PCIe card.)
> > 
> Hello Niklas,
> 
> Unfortunately, our design does not provide interface to communicate with
> the PMPs directly.
> When ASM1064 plugging in an external PMP, we will hide the PMP and map to 
> the virtual port to run.

Thank you for your reply!

If you have any idea on how those users with a ASM1064 card that does not
have any PMPs on the PCIe cards, e.g. Delock 90073, can avoid the extra
2-3 minutes delay during boot, we are open to suggestions.

I guess you could send a new firmware to Delock that sets the PI register
(Ports Implemented) register to 0xf.

However, from what I've understood from how you have decided to implement
PMP support on your HBAs, I assume that setting the PI register to 0xf
would also stop Delock 90073 from working with an externally connected
port multiplier, so that it probably not a good approach after all.


Kind regards,
Niklas
