Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591F1ABCC9;
	Thu, 20 Jun 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884292; cv=none; b=jeE9WAzh2YlzdR1sRNE7eUGkx0yTD68gCT2gFgQYUMCtzqGAzu7rXT/+tebZNmRbdY+4T/L7UQsGjWJXhViaCz3JDDu6xId2S4WyXxjkfoKpt+DsaGhZxbWkPWTin8E+5NEEXAQtts8yDWisP8564nu8WCCy+cFa821alVYh5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884292; c=relaxed/simple;
	bh=0kNsEGwJ7M6q4F0VOLpua0Rt7+tkn2sArQw0Gc54cxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq/1f/ZtrWXUcxoUGDmqCzndd68XJTBvrhPtTG7gZeJmovRGPhMDrUjXyktxt6DrdFnmiZsLpWZXRIWEIxb1F2+s+JoS+nKzhZeQclkLAQ04MesyL2uS5fP0MLMYg+/VrNnpPtPlkWoSlJ1jEbNyqc2LAHqvYng2woE2VuoCvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8hPd6cd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8hPd6cd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61AEC2BD10;
	Thu, 20 Jun 2024 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718884292;
	bh=0kNsEGwJ7M6q4F0VOLpua0Rt7+tkn2sArQw0Gc54cxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8hPd6cdl/IoUnptROTBL1G7TGt3MjIWK6TURNRTE2UNN5FmYvBE3S8zFErgukoiL
	 zOnMpwBSyn4elZXjKhbGZDh+FIl6x1+NCo7w0/oEGaF38E3TbGtxGo+bRxw5s+OVkr
	 ko47186vgdTGJn8SJCGbLl4PsN7jcBXvguBA8lTx5F5ObtY7MpBS5KB5L7g+6pcMcm
	 JJru4J6MAFS0LkdnY2AaRxAB162t9XPjJQ7TONi7GQ5TpHe711a6QfCzt5n97joyKT
	 gzeqE5P0cp3FTB1XG2jUfUbNqsVllB5xZ9cy9YSjIq048pCdncFp8OB0Uu8Mo78sF7
	 gkYYVY9OaK+Qw==
Date: Thu, 20 Jun 2024 13:51:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnQXvmvbRWQs9dpz@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
 <ZnAS1nux75l7QlqF@ryzen.lan>
 <ZnHnACszbExFJSuY@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHnACszbExFJSuY@google.com>

On Tue, Jun 18, 2024 at 07:58:56PM +0000, Igor Pylypiv wrote:
> 
> I think we should explicitly memset buffers before passing them to
> atapi_eh_request_sense() in atapi_eh_clear_ua() and zpready() so that
> atapi_eh_request_sense() can have the same behavior as ata_eh_request_sense()
> with regards to sense buffer expectations i.e. both functions will expect
> buffers that are already memeset to zero.

Well, you could argue that:
static bool ata_eh_request_sense(struct ata_queued_cmd *qc)
doesn't take a sense_buffer, but:

unsigned int atapi_eh_request_sense(struct ata_device *dev,
                                    u8 *sense_buf, u8 dfl_sense_key)

does, so it makes sense for atapi_eh_request_sense() to memset() the buffer.


> I think that it is still benefitial to remove the redundant memset() from
> the ata_eh_analyze_tf() -> atapi_eh_request_sense() path?

atapi_eh_request_sense() should only be called when ATA_SENSE bit is set,
so this is only called in special circumstances, so it is not like the
memset() is in the hot path.

If you ask me, I think that the current code is fine.


Kind regards,
Niklas
