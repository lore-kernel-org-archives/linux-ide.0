Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B32C376B
	for <linux-ide@vger.kernel.org>; Fri,  4 Jul 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751628440; cv=none; b=N1zEFMda3ZOy5mEAU8RFBLyo32yfhQ37vXF22BHJbNExKK/fSB5q6DsH23P0yjed0i64a6apLNWaibEcKa/wVq3flCXDBdzRtGgFbldoT0FRjSKiHfj2efsyUB8NMYmyqHO6YeUbeTd9IZ9FL/kwTdzeBWvk/3Spa0iF7LLN6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751628440; c=relaxed/simple;
	bh=v+1Lo8Z60F2+w5pDtc9SH94pLb+6Y6UKxukKvQ1zKyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSsU/HZ5/mVJOqfYy10fhNSl9pd8wEfDSH6GTKiwBjcEIFjYmro8Tf63CDjX5CBVBUF0VR33MLqvh4E92WD4P7IkirPO0q1mwnuWRkXiwW8Z52ClCjLae1uhlq7XSWOudlfQQHlVYUoFSlTJGwf7aVSV1zrIAmrw1KDPNJ6D9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ0LjRNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ0LjRNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0980C4CEEF;
	Fri,  4 Jul 2025 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751628438;
	bh=v+1Lo8Z60F2+w5pDtc9SH94pLb+6Y6UKxukKvQ1zKyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQ0LjRNLhHiVKf28hTm//dx4eivrTGS+hfULrUPOmgE60R4rvTkt6G75J8CHc4taJ
	 xM6FXXRbQF+odLh0Y80+hA2mwqMcqNkYv0TmDPYy6r3JJC78PILa5/g+kNHF4wReFc
	 K9Pv7TNYyXDAPpBiHr5EyaNqeFZXkfKkEp1SaYd7xTB43YYQNBul4/LIkGFUxYFOGN
	 vhbxnf8wD0mhl4mRxk+7NR8Onl8UtKgQA4XS+rgzH1Vd8ukyuAPzlT64zgCud3NW1v
	 1i74LA0PRk9nHTVLagMRY5TuxAlF4Asf4wa6p18tBmIi3dzTAxo+vdKQO5v+9ywsBi
	 nGh7ycLtM1Cpw==
Date: Fri, 4 Jul 2025 13:27:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: use bool for fastdrain in
 ata_eh_set_pending()
Message-ID: <aGe6k1MNYyKsqL7z@ryzen>
References: <20250704104552.310630-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704104552.310630-1-dlemoal@kernel.org>

On Fri, Jul 04, 2025 at 07:45:52PM +0900, Damien Le Moal wrote:
> Use the bool type for the fastdrain argmuent of ata_eh_set_pending(), as

s/argmuent/argument/


> it should be.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
