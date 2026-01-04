Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CE3A1E94
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767546358; cv=none; b=s8zLrrO1AjFqTJcPL4DgdyzNeMPCyiWXlNAwogLeC98UVregdBGrgkBTVBfp+/b2Z9cDdYFAyuuidGo+5hs2xAQ15vwtJIss0qXClsMsfAE/ekYX37G7Ix/707Qm9BomWteuL3bHJfFIsOk4wp1PL/Ke5LszcTeFSIXFaL674X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767546358; c=relaxed/simple;
	bh=YEXjO1ydhaZPdXGL8ntGVykbwmHq1+zq7GYz0EJUdXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdv8fWgXdjS7qLwOWda1HO+9wKCMPIYAOSmxeuNRa+ilVBAyTNFIDnSsdQ+DVrNqzVTkaRwWDF705w+ESo2xSvMOx7BywUlSCAm9B3Ztd57ht8TY4EfpeXhn94WrqOW6BM94/+MvgJ8JvhjsKUq8ocLsetxeFnEvFZECOzM/tIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUyz+bwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUyz+bwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A1EC4CEF7;
	Sun,  4 Jan 2026 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767546358;
	bh=YEXjO1ydhaZPdXGL8ntGVykbwmHq1+zq7GYz0EJUdXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUyz+bwLHNcsvId1aVUHktVWPjn8cc+81cfhEHzi/dc6syXVyrcGTfBdPIsIH7D7f
	 Vf/kUXtvdRis8N0kvCbeAb9RjzVtr325YIIk9CqBjvLXaAh40yl0Cn3YUxbX1fBiJE
	 QeqcFSo0EuDrh824ndfe5n1PZU3nat0Xc0otZzM4T2BjmgJjeKnw/jxA1vtF72Vz6e
	 AzlbvOQ/gxBwmDNbdp95Ju56FBdH+t679pOoBKrH8tGhxmAmf5DSdY1DkZr9lpP2sO
	 bUDHpKOg89iijDOUqmYgn1YbA5fCpBP464fflVpriQrQnnyk0TojmVmnJoR2GHpBvJ
	 OErBogVU+pWJA==
Date: Sun, 4 Jan 2026 18:05:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 1/2] ata: libata-scsi: refactor ata_scsi_translate()
Message-ID: <aVqd8acyL6fDYYjM@fedora>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
 <20260104082203.1212962-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104082203.1212962-2-dlemoal@kernel.org>

On Sun, Jan 04, 2026 at 05:22:02PM +0900, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback and inssuing the queued
> command with ata_qc_issue() into the new function ata_scsi_qc_issue(),
> and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
