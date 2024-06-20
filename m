Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3323774
	for <linux-ide@vger.kernel.org>; Thu, 20 Jun 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895156; cv=none; b=GqvLRh3dGEnGRNLARC+cZ1YbgMnhcbG9DF51t2dYIuYgeATxGXFXMrTQjUxp/TopLvbKxOZbnukbLe5zVWXbHwkXbXoB1vgz9BCaYUNE3qWWvn9oy++VJ9sQaEs9PTlvIo+Q4JwwCdmZrHmNqO5pEoA2wv0KoJOtR0WCixsvWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895156; c=relaxed/simple;
	bh=Mi8RPxm4WcTBIgsCOrSK7o77BB0nnUaemrD3KuvILYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9Ur9jI3Dc4/JLkV8bzkG+czRbxwYpWhHN+OYM6J7IpNUgzNongy0VKkzFifcLtBM4UPrvOwMfnMmAjtZFiEPsGKGLLYj8Q367mi4+IbdkgXBklpbt9meAzmD7LQ8p6y6C4NN/AhoZp7rdu46n4ofLfbdzFg6fkJFN8rn2AVHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky0cGCnB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky0cGCnB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BFDC2BD10;
	Thu, 20 Jun 2024 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718895155;
	bh=Mi8RPxm4WcTBIgsCOrSK7o77BB0nnUaemrD3KuvILYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ky0cGCnBDSDpJ+najG9QS+keEkQ1AZTCjs/gvplJU9/tWi85jgBexkBAgU66p9217
	 sp0D73kNhzrQuaemtWB0vn3l708uUxGoVRKgaOlpQvSwVW8jZtiSyLRbL6pbV9a4n1
	 A6t9nUEmlm1AJk9kegH71cLBUbJ5uHDEjS4s+vSpIahpHEkubjIUJTiDzb7l9tMGZA
	 tcbWDAXcB0/nqcwVt7rmTRna1ozmyI6XLoYd2thQa3ghbBrew6YpXJjZA2/Um0zLsW
	 4X0gjfcEwYMtfw+9FYCIVUOBxG1tNApBJRS7q7Hpr/XapWT0fPD3EObM3knmZshENk
	 s+7KvMr1zqxiA==
Date: Thu, 20 Jun 2024 16:52:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 4/5] ata: libata-scsi: Assign local_port_no at host
 allocation time
Message-ID: <ZnRCL1TVHcxliOFK@ryzen.lan>
References: <20240618153537.2687621-7-cassel@kernel.org>
 <20240618153537.2687621-11-cassel@kernel.org>
 <9d1b6c33-3bf0-4df2-b1f0-bb589b701698@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1b6c33-3bf0-4df2-b1f0-bb589b701698@kernel.org>

On Wed, Jun 19, 2024 at 01:04:44PM +0900, Damien Le Moal wrote:
> 
> So the confusion here is the naming: ap->print_id is an ID increasing for all
> adapters, ap->port_no is the index of the port in the host (adapter) array of
> ports and local_port_no is the same + 1...
> 
> So I think we can get rid of local_port_no by simply rewriting:
> 
> ata_port_simple_attr(local_port_no, port_no, "%u\n", unsigned int);
> 
> in libata-transport.c. That will avoid this useless and confusing code.

Right now, libsas ports has both port_no and local_port_no set to 0,
so if we change common code to always print sysfs port_no attribute
as ap->port_no + 1, the sysfs value for libsas ports will change,
which would be a user visible change, but perhaps that is fine?

I don't understand why sysfs port_no should start at 0 for libsas,
but at 1 for other libata ports.


Kind regards,
Niklas
