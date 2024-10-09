Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3E38DD3
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462534; cv=none; b=nbZ4mWeEj0qoesckp/KPDvgUgVfhsYG4etk+lsx91fSFkYvcRghaaBlHWFJ9lzbLJBOpTo5AfsW7PRNCwWBvPnsYLs0g/vKfh6aU+GFxFIeUO9Njh4PQCYT0p+wZQwxjvI9xZBhdlv7ilThn/2TzCs2fRbo2ddtNUn/QbQVFsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462534; c=relaxed/simple;
	bh=M8YiunqsNGaTx92Zx3UEM+UnSzw+R0OPwuUchz7OFkw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sP7jRltm2pLMz1wteg4ormuMxmfJyigd5CW+lGNmJbdLbSBlOtDOK7praHhqogST1XYEOamVlkLJpYbZVSuLSj//X3v8xUXy1qE3LQwL6WauoloMKeOrGNr/7Hdb89HKmfYOE7Rm72No+XFZMzsjHHq6rBI7Mme4z/ZPn1rRj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2R9WXPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2R9WXPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A516C4CEC5;
	Wed,  9 Oct 2024 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728462533;
	bh=M8YiunqsNGaTx92Zx3UEM+UnSzw+R0OPwuUchz7OFkw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=F2R9WXPwMWIJaWpdVR8mdsXXt4sb3CuTDvLPvtTu1CGBh6ODHulhplCS4H6jxqf0Q
	 3YVBJpgerjCItZ3ZWRP/4jTrnUQlEpPLaXzJ6gX+f3taeC60IE479DJj/keezS3ltH
	 tVomCVRfhXuh9tP4EEe0FHzATsWwzrJzS9OAgEom4Quko8aYd62i3NiO0BnYnkb+Tt
	 fbrN7wszndzW8VxDXqlOeLI1AArACv8OFO3qa122YnsQhsHnWro57U/O020jMXgj+l
	 WbC0hJuOUAzjWLJeSR4JEghRm/+WsyZG7W1F+U6CfmCeUhbABlwYZlzspcXdkXpUW9
	 JAvFDlPm50Guw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20241009081535.376994-1-dlemoal@kernel.org>
References: <20241009081535.376994-1-dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata: Remove unused macro definitions
Message-Id: <172846253292.1437275.1137626462183196136.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 10:28:52 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 09 Oct 2024 17:15:35 +0900, Damien Le Moal wrote:
> ATA_TMOUT_BOOT and ATA_TMOUT_BOOT_QUICK are not used anywhere. Delete
> these definitions.
> 
> 

Applied to libata/linux.git (for-6.13), thanks!

[1/1] ata: libata: Remove unused macro definitions
      https://git.kernel.org/libata/linux/c/f7a870d0

Kind regards,
Niklas

