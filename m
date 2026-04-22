Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D283195FB
	for <linux-ide@vger.kernel.org>; Wed, 22 Apr 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871097; cv=none; b=ufJYzcYQr782sLh08MVHU/pFxKVA8cvXaJoHidBZx3bhu52cdMyRVngXDbZXmG80OcEcaPrWeY0XPKFTs82mNzCHqD/4W90ASyy56k1ikfCAI4qQnStKjw9LhXaYnFPRGpZuHtje93p2pQ9ep9qHxi62FVI2kf9Z7I61/A+LaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871097; c=relaxed/simple;
	bh=/TLzr5Atocrgt0wSkVW3up3TL8okGRM5AY0RQgpDC0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epErO4hevcm98fs0tOd/1ndJQU/x6IkdWpJbVTSpXvkwXn0rz8Q0kz3Y9CuHyqkTwbic6BZ3grM3TWT28moiW/O876D8DaTrxjIs30Cf6+mWPbt3A5I2rBxsmErw56KD6b2JULPy+V4hQltnTLKZACUEO4LaGGwPhyzT6x4wpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucucwsv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucucwsv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CE9C19425;
	Wed, 22 Apr 2026 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871097;
	bh=/TLzr5Atocrgt0wSkVW3up3TL8okGRM5AY0RQgpDC0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucucwsv7syKknmPZoQDjxAX32P2GiBCfXkGWDJ09H8liZBIEEFDLQZ8p9y6mK+XlI
	 DyhEC31/uk7Q/9mVVa9+unLlgtz/yfC8xi238/zo17sfqwuBp54Tf1Zxld07OxKEIM
	 XVXEeUGIc7jNZlx/HOk7jDnhHLqXOUadBsW3ir8ElTKqDb+BRqKBv8hipC2SnxQZ/d
	 +SJC6q8F8H4sooUfSrp94vD1z3hVdZXQK4YP6haqTgSErr/H4DBd44LjFANlnQbvc/
	 GF20m/vEqby60gSAFz1BPuqO93+eSGbZ5hAvaXE6rCHQECxdkZrtWVbI4GXR8B0g0+
	 n8RfjKtZYhuxw==
Date: Wed, 22 Apr 2026 17:18:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
Message-ID: <aejmtaOfEva8uqak@ryzen>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>

On Thu, Apr 02, 2026 at 02:22:49AM -0700, Tommy Kelly wrote:
> The device/driver/subsystem tree looks like rk3568-dwc-ahci -> scsi -> sda.
> The platform does not (yet) support FIS-Based Switching (FBS), so it is
> using Command-Based Switching (CBS). FBS support may land in Linux 7.1.

I still do not have access to a PMP.
Damien said he might give me access to one.

FWIW, since you are using rk368, I saw that:

commit 5918bf2a17f4689abfb94d341c5240088f8bd16e
Author: Heiko Stuebner <heiko@sntech.de>
Date:   Sun Feb 1 20:18:01 2026 +0100

    arm64: dts: rockchip: Add port subnodes to RK356x SATA controllers


Has now landed in Linus's tree, which adds PMP FBS support for this platform.


What we know:
1) There is a design flaw in the current deferral code which will make
   PMP FBS defer commands to all drives when sending a non-NCQ command.
   (Basically giving the FBS the same performance as CBS).

2) There is a bug that you found that seems to cause indefinite requeues on
   PMP CBS. This manifests as:
systemd[1]: dev-sdc.device: Job dev-sdc.device/start timed out.
systemd[1]: Timed out waiting for device dev-sdc.device - /dev/sdc.

   We don't know if this bug also affects PMP FBS or not.
   Out of curiousity, do you still see this bug if running with the above
   patch cherry-picked or not?


Kind regards,
Niklas
