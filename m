Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B22571AD
	for <linux-ide@vger.kernel.org>; Mon, 24 Feb 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399832; cv=none; b=M2FaFzrjuAjG9DugMmYYKsrqKxCug3MEAPyxeqFhoW5fRtP/5jXg0pnl2UJUJEutJyTLiguXTXgjw8aIwB3OXmYxZhpyOfj7arlYXTTF3NSj/M+FDKNsRQ/YcTGxU822FZSNBn+fnvnAY3QgZylR01Ykj9e4/ZnOIyGQRSO6u6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399832; c=relaxed/simple;
	bh=eP8RIU5Joxzdafywy9Zg3OvqgsMaeqLprVbqabGmmSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFR+N3/AGVxYzdQIi+LQVxYAHj87t2gPILl5+l3W3wOQsqADtmh07ip78Nw8/8Q2li2DdZsDAMqaNjjpSfaRmTKS67NXwI3rn2dOz0LjZquubmmAkN8aISG2CqHeSJdESXTsaopibOiXmjonK1vPvOeaVL47U9UVVpK0bac/XfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGOhvw99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGOhvw99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF1C4CEE6;
	Mon, 24 Feb 2025 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740399831;
	bh=eP8RIU5Joxzdafywy9Zg3OvqgsMaeqLprVbqabGmmSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGOhvw99RVJC9sx0QilI5RX37pqFyHQmw+XGflPpDjiiU1igkCJNshcauaM23vnKN
	 zWERCJOeqIsbP7ZyULBp5WTpmBPzo2QaPet0XPYv0zCmkROGPJQNd8Gxr0nWTIqdIl
	 ZHo0qC6qZamxjc/QHDORDy+yryoEIXVmKL/96Pmwj/ynT3IJHkWtI3X6wMaeAqP9FO
	 I/3kS6RKUylGNwo044u2ObEyrtRsLzL9drEeLDOBbrrh+EddHJpI0ByWeeX542vJ1g
	 ZRKhCvYZyYO0TyOOQppBHcOC7uXpqRaJPhs3wCtTUnQSJxglvjPZvKJ1N9e4QDiDBN
	 jTqApA3pxqGBQ==
Date: Mon, 24 Feb 2025 13:23:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Samsung SSD 870 QVO LPM issues
Message-ID: <Z7xk1LbiYFAAsb9p@ryzen>
References: <Z6MjZ1Nniwn_uldf@ryzen>
 <Z6nePJ38aL92agTW@ryzen>
 <bca345e0-391c-432a-a294-5da36bfcede0@debian.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bca345e0-391c-432a-a294-5da36bfcede0@debian.org>

On Mon, Feb 10, 2025 at 06:00:07PM +0100, Daniel Baumann wrote:
> Hi,
> 
> On 2/10/25 12:08, Niklas Cassel wrote:
> >> Dieter is using 'Samsung SSD 870 QVO 8TB', rev 'SVQ02B6Q'.
> [...]
> >> Daniel claimed that enabling LPM for his Samsung SSD 870 QVO drive,
> >> caused them to stop working.
> 
> We have different firmware versions and all of them don't work for me
> with enabled LPM, however I don't know the versions offhand.
> 
> I'll check and report back on Wednesday morning (not in office tomorrow,
> sorry).

Hello Daniel,

Any update on this?

Would be nice to have it fixed before 6.14 is officially released.


Kind regards,
Niklas
