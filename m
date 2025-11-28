Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E11391
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2025 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764309719; cv=none; b=ctWhb2VovM5sYCfH0x6Kg1IhvapfITALNFDzv0eCbhGsp4JPWFUcLizZL01YaDJxkkzoFzSb9fWsFMpz3ZH2cMafOtebtNSvqLF205JFBasqzgHPhNim5K0B1WEZgSm03OSG0jQcZR7/3TwEZDWsUCYJ3XLxTDsd5T3+SHsEaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764309719; c=relaxed/simple;
	bh=+r7rrNmwoudbcT5ORrdfaLVj+p6rVLYS6m8kjS0LQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJggBqD0nISxtKpwcO/YIxxbAFuhwgpvO2pEkqg+Wx5TYDQu6WmZ3//n78f5SSVWTAAvrujT5Ew+96xLauR1ML6ARxwMkVKCJaXrYnmY+xfNyKP8tWNv02eUqY4IyZ129kHq28Jne8Vmx2LHJPRsoO4A31LzWJQNeII2Q3dybqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1mHk6Q/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1mHk6Q/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0AAC4CEF1;
	Fri, 28 Nov 2025 06:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764309719;
	bh=+r7rrNmwoudbcT5ORrdfaLVj+p6rVLYS6m8kjS0LQzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1mHk6Q/Z/Sf95YNQCZ6LRx0Yyizr2yUANDitUieAv9DZTxAVmXIV9LXi0WX3bZ2K
	 enlO1kxXwe1yMjqPLVdOT5qmybOyqRivfNcuG5ZrYPe6lN5q+WdSwqcHMn8Ii3cZUO
	 aCaernybaijOqdMnaXxc2gRoLxcQtjQMDAIJSM46wUeWum8nFz569JElCKSBO/7Q3E
	 W5J1e2REps+HT3++nYqY1f2d/8oPtn8FE7+wLuoZ19oAmTfN9jrKMJ1SDeBHy0QkiQ
	 JO7dCPfR1Bo8E6Q1OX+BRsaEm59wqf302PC4zb+tSk+f9N+peuSg5W4rTPrkY5Ja4F
	 dt6wobYFrElLw==
Date: Fri, 28 Nov 2025 07:01:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Yihang Li <liyihang9@h-partners.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable LPM on Silicon Motion
 MD619HXCLDE3TC
Message-ID: <aSk603ptNtfIx6pe@ryzen>
References: <20251124163433.3082331-2-cassel@kernel.org>
 <8850d82e-6818-b67f-9acb-cdfe78b7cedd@h-partners.com>
 <aSWgnwVzGDAqPf0i@ryzen>
 <5c2c5cbd-b13c-8ba1-86c8-670f0a34fcf3@h-partners.com>
 <aSbs7HOYr_8waEZZ@ryzen>
 <479136e6-12d1-7593-bedd-e11b53063a3b@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479136e6-12d1-7593-bedd-e11b53063a3b@h-partners.com>

On Fri, Nov 28, 2025 at 10:54:21AM +0800, Yihang Li wrote:
> On 2025/11/26 20:05, Niklas Cassel wrote:
> I found an SSD that supports DIPM and connected it to my AHCI controller for testing:
> ata7.00: Features: DIPM NCQ-sndrcv
> 
> And it did not show the same errors as MD619HXCLDE3TC and MD619GXCLDE3TC.
> So, I think we can confirm that the issue is not with the AHCI controller.

Thank you for your work!

I've applied the patch to for-6.19:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?h=for-6.19

Please have a look so that everything is correct.


Kind regards,
Niklas
