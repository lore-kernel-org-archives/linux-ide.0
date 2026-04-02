Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649A3793CD;
	Thu,  2 Apr 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120145; cv=none; b=Ey27FxWyZFBPIcVfEWPNpvKUKLWLKrg2Dl9WKqJckEnacd6KvkqxO8pI35qdkQiRjzauGVHFaLH+Zi89shYRiWX45OCyul//nQpxeSu0F92jylZHir82xLsfPpEhaCmyrzK0rJoOd2REVWV5hmotMO8Q68Kf4jWv5G9hGri4jlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120145; c=relaxed/simple;
	bh=nmZ3NhRcHniIQPQwmqvoaYukX1M9nYGCiSPPVrAgK6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPQ2my8ksR4xM38cIqsymDDUCqG2zQgZVP1xIvFjFKsUVm74L48X4/gY4of0TkM4U517wTzb/y4r6cd1X0oRz9Ci2a/OSkZ5UmdQNoz/z2VYUTTYKNeBE05MCQ3cH0ioBiqFLndrEZy3YDL42O1QnZtrtFw72oGmz/u7YibHw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT92EOzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT92EOzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BD2C2BCB0;
	Thu,  2 Apr 2026 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775120145;
	bh=nmZ3NhRcHniIQPQwmqvoaYukX1M9nYGCiSPPVrAgK6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OT92EOzMXoUoJEwzV9w4a8VZKZzDlQ+7NPo2sYh4Fnxu1uXQ2oYij/WUzFuGJiPKM
	 zQyUEHDxcyu9VbWLmoR2Se5nw5GQBqiG28PplW4yoMwFmNysYMqUgqgyWXxiw8x3Np
	 oXja4ayRkMaOT/mMc4v4IwEaA316f21iNsIxo43Y3j6iB4mbiCH6apoCK3IToiT//4
	 zirj3M896+GFatNI30K80roLzW+BMrbCkZbouCohmad6tI8KkhxZNhGUIxCTMnv+OC
	 NjKMy36N9eqMZPdC0qOsWthuPkd29Q8ZmEPCznVQv86YyCEeLsDBs6lpRP8NZ0ICiW
	 r3ibnVfjaEqZQ==
Date: Thu, 2 Apr 2026 10:55:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Do not retry reset if the device is gone
Message-ID: <ac4vDZVvJydch994@ryzen>
References: <20260402011101.676267-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402011101.676267-1-ipylypiv@google.com>

On Wed, Apr 01, 2026 at 06:11:01PM -0700, Igor Pylypiv wrote:
> If a device is hot-unplugged or otherwise disappears during error handling,
> ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
> continue to retry the reset operation up to max_tries times.
> 
> Prevent unnecessary reset retries by exiting the loop early when
> ata_eh_reset() returns -ENODEV.

ata_do_reset() ?

The loop is inside ata_eh_reset(), so it sounds a bit weird to exit
the loop early if the function itself returns -ENODEV.


I guess you could also write it like:
Prevent unnecessary reset retries by exiting the loop early when
a callee in ata_eh_reset() returns -ENODEV.


Kind regards,
Niklas
