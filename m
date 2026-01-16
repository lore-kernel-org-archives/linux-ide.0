Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9A2773E3
	for <linux-ide@vger.kernel.org>; Fri, 16 Jan 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571977; cv=none; b=Aam+JQFuBYQhciE/9iGdRWjvK6KIyvT4SWXYUuldZpTdprYiaB/OW1Zxb+fhRyKmueNPxydUm/hFrpotTAgm2zG3mIm/ukvCbKboeKz9LEJX74t9R/7R6R8HCoQPICwzgy82cj9pXnvf8fgBeuN4P77g+vmk/8NlZgN0Yl45QiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571977; c=relaxed/simple;
	bh=zna4QZeZS43745WOlFO9JAWA2/j870Kn9B5gEHKfgqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZIyJioAJ772kI1NC/Pu+IoMJe+OxuyAxWNsgw4QjMAH6Pu9hGoa/GX0Nu2cQEBgXuxX93jXfetVs32QMOiCSwJB5wxDFyi4DooD7xNG3JDO/5bAJ/GVVIESAd8VDx+kUMGLbOVAzqMf2KcDefSxztL3zBVWT27F4CyMEcG1yus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOPMUdOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOPMUdOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0DBC116C6;
	Fri, 16 Jan 2026 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768571977;
	bh=zna4QZeZS43745WOlFO9JAWA2/j870Kn9B5gEHKfgqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOPMUdOMRvVZvrMS5mXBsm7jwg5C67ELEqyjcuRRIEH1vXNXTnvRfq1YtaK8isxPf
	 dFhfb5g6G51rm1Yik1rmL2U+1oCFVXZ1AFlF33Bb/w0jtV+FJ35KDUwNnn5EFm+WhW
	 nS8G07c7ilOYZDqEuab7rHUqzFagFAbEyxmhTUFCy/CxPqZ+iuYffEORqOJBah6GH3
	 otcyRiGxmrxYS9ranJxo7MSWaokpyBYI++Zi6672uYGGKr6LFGrMoxRzfqZOibRVnh
	 we/+ZywujT8axd7I5NMXzPE5aeLcaIJM0d6mJRrirIe7gPC++ArE3R986ITxJMcG85
	 4W1odUbi2Zmgw==
Date: Fri, 16 Jan 2026 14:59:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Wolf <snow.wolf.29@proton.me>
Cc: 1120831@bugs.debian.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [regression] failed command: READ FPDMA QUEUED after boot for
 INTEL SSDSC2KG480G8, XCV10120 after 9b8b84879d4a ("block: Increase
 BLK_DEF_MAX_SECTORS_CAP")
Message-ID: <aWpEQqCHuDx8i5VT@ryzen>
References: <176839089913.2398366.61500945766820256@eldamar.lan>
 <aWelaQYNJyulLBVc@ryzen>
 <kkJPUUv8aExqrXPkwlzwEJV7Ywy3ogYCeTawLZZJm3wHBYylIhyCUeIKVFg6PWku-5BbspvtELJC6Tok6ens7Ib26hFkuSKKSm8NEwigRYo=@proton.me>
 <aWfDYaZU7nYtcH0b@fedora>
 <iy-aryUnhtm6ORlJyPqOF0OrRSv1jAmyv_rOu1PswCnpCfQoNL8DKbBg26v5qsmW1zSU1MfDdWnvFJ5Y3mzYqXCq121b-I5pWll_AkEj1Sc=@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iy-aryUnhtm6ORlJyPqOF0OrRSv1jAmyv_rOu1PswCnpCfQoNL8DKbBg26v5qsmW1zSU1MfDdWnvFJ5Y3mzYqXCq121b-I5pWll_AkEj1Sc=@proton.me>

Hello Wolf,

On Thu, Jan 15, 2026 at 05:29:28AM +0000, Wolf wrote:
> Hi, Niklas
> 
> Udev rule
> 
> ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sda", ATTR{queue/max_sectors_kb}="4096"
> 
> is not working.

Ok, since you seem to be able to reproduce it so easily,
then perhaps try with different values here, e.g.
1280 2048 3072 4095

and tell us the largest one that is working, and we could
add a quirk for the device with the highest value that is
working for you.


Kind regards,
Niklas
