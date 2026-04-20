Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20732E137
	for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2026 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702477; cv=none; b=GCg2Whi3vw4VzusJrFahAosIZOMQcpWtqnzS1LbwFZ28OyNIn2VhjwvOXNs97DfC7TQtH9lI7+JH5Xt/AWZLlePfbjZ4Gn0UxQYmlTDR7a3sY6uaHNebKniryNNsSzsMNxoZszIyGTaKajOl7Hv/WbVQJQDMCXPA5eDH3y80q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702477; c=relaxed/simple;
	bh=TDbhItEMZ2Gspha5N1Q9UvzrdsEwBvXBar4aFawNezA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QROZTbSz1Kh6ncW50TfIfuWaVtyfKXaDxmC5ci+q/HEroX+1MMFffEXIPLow4ZJFWr6Ma2L/aKl4H4jJ2u8cx7Be8oxqgpTTZMwS53EHXMhgBwEpaZjS0Zkbizgf5nwF+d3JPY3kGO4mbXpAMIBG74tEunuO95Oor0pXytOhvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF/4uJKs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF/4uJKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ECAC19425;
	Mon, 20 Apr 2026 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702477;
	bh=TDbhItEMZ2Gspha5N1Q9UvzrdsEwBvXBar4aFawNezA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF/4uJKsZ0GbuamBR967v6/MeIC4TBzeJVahMbs03Dux3bxVJl0eoxYzLZFKfN6a+
	 2q00YambJ/wMtkkjCMsjBezGLQYkzVRaUNa6h8Cipfg66uT++JVEfH7UltJ4pAGhN/
	 ACzv/+kSPrKV2BdkwxyFt/Rj9kPQjoOIRxx354H0dt9JgcpoyBJcmhrqy2DphLsJCe
	 K/N6rbOD9LnKLa2AI5Du0EGl0ObpCz29uenjGbpWWyXNAfWdfLPpSbQGdVUsOYbPIq
	 aEfxMNDfdH1cY0RHd4kD1PWh+gUFMRE9FYNHazneAaUdRCxrOFgj7U7lmag0pGVw3z
	 TpA5jWXUB1MBA==
Date: Mon, 20 Apr 2026 18:27:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-ide@vger.kernel.org
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
Message-ID: <aeZUCa5wumWXi_yN@ryzen>
References: <14015677.uLZWGnKmhe@alanarchdesktop>
 <6740c3b7-c63c-4181-b36e-962e07bb468f@kernel.org>
 <ad-HTImFZxdtkD2J@ryzen>
 <23071769.EfDdHjke4D@alanarchdesktop>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23071769.EfDdHjke4D@alanarchdesktop>

On Thu, Apr 16, 2026 at 08:59:30PM +0800, AlanCui4080 wrote:

[...]

> [12961.113196] ata2: link is slow to respond, please be patient (ready=0)
> [12961.114200] ata4: link is slow to respond, please be patient (ready=0)
> [12963.428372] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control rx/tx
> [12965.816162] ata2: found unknown device (class 0)
> [12965.816180] ata4: found unknown device (class 0)
> [12965.969160] ata2: found unknown device (class 0)
> [12965.969171] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12965.970159] ata4: found unknown device (class 0)
> [12965.970167] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12981.369196] ata2.00: qc timeout after 15000 msecs (cmd 0xec)
> [12981.369207] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [12981.369210] ata2.00: revalidation failed (errno=-5)
> [12981.369226] ata4.00: qc timeout after 15000 msecs (cmd 0xec)
> [12981.369236] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [12981.369238] ata4.00: revalidation failed (errno=-5)
> [12981.833047] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12981.833134] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [12981.869506] ata2.00: configured for UDMA/133
> [12981.879537] ata4.00: configured for UDMA/133

From this it seems that it is simply the first IDENTIFY that times out.
On the second try, it seems that the IDENTIFY passes, otherwise we would
have seen more "revalidation failed (errno=-5)" prints for the same drive.

So, from this log alone, I don't see any problem. We will try to do IDENTIFY
up to three times, so just a single IDENTIFY failing should not be a problem.

So I think the question is, at this point, can you read from the drive?

E.g.:
# dd if=/dev/sda of=/dev/null iflag=direct bs=4K count=1

replace /dev/sda with the drive connected to ata2.00 or ata4.00.

If you can read from the device, then this seem like a problem with zpool
kicking the device off the RAID array (perhaps because it is taking longer
than some zpool defined timeout value?), rather than a libata problem.


Kind regards,
Niklas
