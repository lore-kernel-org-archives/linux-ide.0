Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F6170A11
	for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401823; cv=none; b=nsqrZSomqcPqWyzRfjpoqI0vlNItpGx/l7GC0ujzs04eL6xr8Ae5WHcnifST+r63hpvtX+8/vwqDB2gpxBhmn5+MIMPZvav36Lzusjf3cBZBMtOg7SZfY90pBC/np7FX3rUtaA4rUY5Ao5jgy7yULVftTC3ZbX/3EZxOLCF5LgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401823; c=relaxed/simple;
	bh=taF7byazV+Fbu4XWKFYUckln04ZGtP7KpFoEGTUsxW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fprYu5ZarY36fmR1E+fDF+vo+RjOULw1uvbpZLskxdgrrHwoQ6q+UjQPsVU3wl8Xk5g8k4/HWTz3RnCEISC0oAWznQ3nN1k80mH3Kq1jz39jSBSDcoE0I70jGnUoPvaYLyJb/zgR1pw1P6t/wcZ9y8iz9oBQK2ra4VieDyGYvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP4tSKAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP4tSKAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345F5C4CEE4;
	Wed, 19 Mar 2025 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742401823;
	bh=taF7byazV+Fbu4XWKFYUckln04ZGtP7KpFoEGTUsxW0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oP4tSKAJ5iTmKtyNG6spzYB1JNTpchiMp1roJEWNal4PBSoub7UFAqR8ioVFjsAyC
	 jEvYx6SLTCiZpHbJlDmQxBmf3IMpHe7EplHtKL6trnsSDrLrdot6AN6BJ5DnR6OFv/
	 2u9fjhLo6AdyfwmK0ODumhxiQeaiULWMqv3xiWJ1gDpR0jAPA3hTW4pZZPt1lRLccT
	 bxERj4T5mQaZfJEDN95gCdgWxExKmPgcEyOUBizIQSlSwk6ZWjKb0VBttBROEiBlq+
	 POGLTYsgQYgNoWrY+ogHpR4m7nHc1Iw/vTJb5fns1H5wBpPgRORxcrgre/gjmMJrj/
	 8LnVNrOzS3oAQ==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Tomas Henzl <thenzl@redhat.com>
Cc: dlemoal@kernel.org, Niklas.Cassel@wdc.com
In-Reply-To: <20250319155030.16410-1-thenzl@redhat.com>
References: <20250319155030.16410-1-thenzl@redhat.com>
Subject: Re: [PATCH V4] ata: ahci: simplify init function
Message-Id: <174240182194.3567406.3561491357742146708.b4-ty@kernel.org>
Date: Wed, 19 Mar 2025 17:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 19 Mar 2025 16:50:30 +0100, Tomas Henzl wrote:
> There is no functional change done with this patch.
> 
> This patch moves all the IRQ vector allocations into a single
> function. Instead of having the allocations spread out over
> two separate call sites everything will be handled in ahci_init_irq.
> Also a direct call into pci(m)_intx will be removed.
> 
> [...]

Applied to libata/linux.git (for-6.15), thanks!

[1/1] ata: ahci: simplify init function
      https://git.kernel.org/libata/linux/c/565d065a

Kind regards,
Niklas

