Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA37839EB;
	Mon, 21 Oct 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524018; cv=none; b=HDG6h61csYMQ9OuEazWPNw0WgHFqhP9x/pDJxvwyJ1uO0+bn87F7tYKhegLC/BTUSH/myMscDTmb6Pe6j0AMvnkx8rH++GXt3RGF7nJo4b2leK3drIkuLbrGzXOoa6DCBG8dcGtFkTN4CPQRLuDRBxH0DwAhU/Py7wN/DYktJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524018; c=relaxed/simple;
	bh=RavReSX2R+y8sjDIaSr5xuC8/7DPGyL/PZkXGUjWQVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG8ptarRfEaJmqqRJC6dASlloWLWD2qmvRBH5zZejiMgyV4Ryc0qzY6EE51Elx9Bo/C1jhYZbMBdi1ptprm4JMU/iZ6nDwa21HwqzR5NR9E3dCRp3x+ML1hPdyH5Ds1WuALQVuuJCi4sm8yi5j4CMhA+6Imwo75DK1lDzouJIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmhpHZ76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmhpHZ76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC68C4CEC3;
	Mon, 21 Oct 2024 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729524017;
	bh=RavReSX2R+y8sjDIaSr5xuC8/7DPGyL/PZkXGUjWQVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmhpHZ76WDX3Cl6P6yjNDmStEyFyI0VipaHFzpxzl3uIqxpvpdCIr1KAelqXms9N1
	 vYf0grGEm/fE4dxTTMa8XzSvXF7Q9qQiTyaXSj0gTS39zx8/rQs/XELobkpMFEAHDa
	 BIXnh6bHqKf1RuGV3QtbsC+HMw14hNFmdvDyqUTSyhZt4JzKSPY7HX/pHBf4qk7Den
	 oamJHH90d6RsurSO2HDoMQANGrh3b4Z8Z5o5MQqNkpT/gK7Qc2Ve3GfNuqwoVb+QTr
	 pBrtsEjb1Cfm12NCnO6PtYRyUhq8Pr2xRDfSfM24nNgDLVd5bc2s/sSFyiNjnd06S1
	 dMEDwAsb8YUiw==
Date: Mon, 21 Oct 2024 17:20:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <ZxZxLK7eSQ_bwkLe@ryzen.lan>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZD-doogmnZGfRI@ryzen.lan>

On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> Hello Yi Lai,
> 
> On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > Hi Niklas Cassel,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > 
> > After bisection and the first bad commit is:
> > "
> > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > "
> 
> It might be that your bisection results are accurate.
> 
> However, after looking at the stacktraces, I find it way more likely that
> bisection has landed on the wrong commit.
> 
> See this series that was just queued (for 6.13) a few days ago that solves a
> similar starvation:
> https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> 
> You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> and then try v6.14-rc4 + that series applied, to see if you can still trigger
> the bug?

Another patch that might be relevant:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e972b08b91ef48488bae9789f03cfedb148667fb

Which fixes a use after delete in rq_qos_wake_function().
(We can see that the stack trace has rq_qos_wake_function() before
getting stuck forever in rq_qos_wait())

Who knows what could go wrong when accessing a deleted entry, in the
report there was a crash, but I could image other surprises :)
The fix was first included in v6.12-rc4.


Kind regards,
Niklas
