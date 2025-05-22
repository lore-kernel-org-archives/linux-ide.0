Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25651A3A80
	for <linux-ide@vger.kernel.org>; Thu, 22 May 2025 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899590; cv=none; b=H0A3xDBqzLfMBTYAVH976/pQSlHriJfskTr3OiPXmRdAFgjcLVn4PIAxjIXL95Rip7WiOPcuY2cHdYClgvttlYaV8PAy2ZEZOP2PxWZdsaE13F1vutv8T4WfoHFtRtAF9whrMaM1a9gDRqFphHbsLPk8VH1X+9CASMJtnvsVZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899590; c=relaxed/simple;
	bh=dLRjMGW095FeV/X2DnR6SUWc40hzyd/2fPEyygTSrHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXzrs7DTHp4k+b2nlKrSCKIZFfQFZK14BTYvwMjEhaw3KvDFUu8vAlI2/ORfVVb8dMrKz9gJOWL1pG9U4oUCJiPsVooZ6/bDDMuzTLiEBALvRmspfiAkUjNCo+qT7SIMglxXE3yT/NeNgizDTv0HC/ZZX7L02mVQRJisrPlMSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raR7KFN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raR7KFN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418FBC4CEE4;
	Thu, 22 May 2025 07:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747899590;
	bh=dLRjMGW095FeV/X2DnR6SUWc40hzyd/2fPEyygTSrHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raR7KFN/E8KkcXn/eosWuuVG3lz3Bh5w7Rz/9cYsYD0Vcuxzuq7ZXQjEEytpHdefA
	 4IFNB3qCR92lmcgzj+vCiTSY4MAaXV9lW0j8/vp00wNCMhPMJkTNXKWLbQwR0t4CrW
	 FjcoqR5KHUFXV6Uz7QR96cVXqDR3mcYUdNAF6S+6a/hPucLV3JqE0H9lR86ptNGbyk
	 i6AKvdHxOJ13Sow9/7GbuOS/HBXEwmlSntun+LXw62Acx9QpP5fiCsstJA5fYy9dwV
	 T4Ko4e+k3g/agzkqDM2wSOnDf9BPZjDq0OHDJPMdcRM752Lar2SAkiUhwujT4L+1Y4
	 uQVB4t7EDMXrQ==
Date: Thu, 22 May 2025 09:39:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
Message-ID: <aC7UwqgemO28FGOs@ryzen>
References: <CADUzMVYk1VOB9u2n4Bxd=ZBeDspkorP94HqA9H1zb6QSDxmFbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUzMVYk1VOB9u2n4Bxd=ZBeDspkorP94HqA9H1zb6QSDxmFbg@mail.gmail.com>

Hello Ioannis,

Please always CC maintainers.

On Wed, May 21, 2025 at 11:14:47PM +0300, Ioannis Barkas wrote:
> Hello guys!
> 
> cdrecord -vvv -atip produces an error using my AD-7200A on VT6415
> controller at my installation as you can see below:

Do you get this after applying the VT6415 patch in $subject?
Or does this command work on latest kernel without the patch in $subject?

(snip)

> Taso you can update your drive to version 1.09 and retest. Also please
> share a dmesg to identify the errors you get and the kernel in use.
> Output from IDE controller PCI config could be handy:
> sudo lspci -nnnnvvvvxxxxks 05:00.1
> 
> Guys cable detect seems broken. With a 40 conductor cable in Linux I get:
> ata3.00: ATAPI: Optiarc DVD RW AD-7200A, 1.09, max UDMA/66
> also UDMA 4 is selected in hdparm while BIOS says UDMA 2
> 
> Finally cdrecord -vvv -atip command is not working properly with 40
> conductor cable. I get wrong results but no hang was observed at all
> during the tests.

There was a different patch from Tasos WRT 40 wire cable recently:
https://lore.kernel.org/linux-ide/20250519085945.1399466-1-tasos@tasossah.com/

Did you include this patch when testing or not?


Kind regards,
Niklas
