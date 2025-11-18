Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891130AAB6
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479364; cv=none; b=rml3meZjNPYIahEMXFSnrEZ7Zt/RkSd4LPihAeSkVmnLffvtvkP8SMj3YaE/MJdf52y68nnY77quUbQmgC59+jaBDM/Z1dmSJV2WFGU/GHD0ODhCUwS06xb14X4r7ghjM5tuVzKm6OfjPVXg/rFFyg+mgIlNDPe2Ec4faAya3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479364; c=relaxed/simple;
	bh=1pmN9YIhrnfbWD4vDyuY84gLYAh5NQ+Rum7E9kSlyzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyQf4E83MR6InG6wv07d+RGv5YwIsdvdtvxSOiUBCDYmw0e6KyFrlwQNdVpDOxjR/Y8nF/8fKE+nRYGDvzs1Wz6hzPSofKoXi4eKK37LOLppMn/ZtTIkP4A2WGwFe1DdzIfLSLBX1QvCILx8AFXvAr3Fz+2skbCieax1jqEj2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdNC9SXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdNC9SXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE7CC4CEF5;
	Tue, 18 Nov 2025 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763479363;
	bh=1pmN9YIhrnfbWD4vDyuY84gLYAh5NQ+Rum7E9kSlyzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdNC9SXj4pxEuh8HCLS6nruzFzE3wsrC6F+SmnMNGiU8DMCOCBZc33qlpeMkYU1lQ
	 hJkp708SL3tGVRntuQAG1gphXYFiPETTMBJNCWfnwka4jaBI+xnbb/Vg7Nc4m6WBjB
	 fmBGP/dIufnYyW3yoa2Ba7S6unRSBzE3j6HKqsOM5Z6PcDrtJZlcShQlo1lpM0uHiw
	 r6LfPCcvYuCg8b/z+Etzloak1zkL4KOeUIF1FSukxnxqAATzYot8+uSrWdU47Hr3Dz
	 wNYJG9aY7zgMn7CuGWBlj/1olVVU6QBdcNrrxEqw5uIEaMGrsClyuTsIez+bxZSU6w
	 HL7axGiLbI1Zw==
Date: Tue, 18 Nov 2025 16:22:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH] fix PCMCIA Iomega Clik!
Message-ID: <aRyPQBMHhckIsa6k@ryzen>
References: <20251117.134321.1327313572065130952.rene@exactco.de>
 <aRyJB2j4MDNIARIM@ryzen>
 <20251118.161305.959866833545078228.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118.161305.959866833545078228.rene@exactco.de>

On Tue, Nov 18, 2025 at 04:13:05PM +0100, René Rebe wrote:
> On Tue, 18 Nov 2025 15:56:07 +0100, Niklas Cassel <cassel@kernel.org> wrote:
> 
> > Hello René,
> > 
> > On Mon, Nov 17, 2025 at 01:43:21PM +0100, René Rebe wrote:
> > 
> > Please change the subject to include: "ata: pata_pcmcia: " prefix.
> > 
> > I.e. something like:
> > 
> > ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI Adapter
> 
> sure, will resend.
> 
> > Looking at:
> > https://en.wikipedia.org/wiki/PocketZip
> > 
> > It seems like this device was renamed to PocketZip.
> 
> My devices have all stickers with Clik! I don't have a PocketZip to
> test.

Since it was a simple rebranding, I assumed that Iomega PocketZip and
Iomega Clik! had the same device ID, but if we can't find out for sure
if they actually have the same device ID, then I guess it is better to
keep the Iomega Clik name.


Kind regards,
Niklas
