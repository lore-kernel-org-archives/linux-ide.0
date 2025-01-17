Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AF20B20
	for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124008; cv=none; b=ffXB0w2OTNm0IwzVytWARUPZnAQ3x+LX/gT+smyhAfChfIBiZW6QuFPjHajm5nFxgIzPSAcPiXay+DFGKxHN0L/dXlwsmZRO/J83nPP+Z58nGwGbN9UouWoitaSFvCl3+kuPpccZfPER3tm2ef7apZhji6OZ4/WCFyplf61IGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124008; c=relaxed/simple;
	bh=F/hgAFGSqkaHOJ+v6R5RZ9VxbNfrlJ2GszhU9BoZ/Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtwAX4vUh67muH5hP1YkNB0ZBHjNNbhF4JNGXAw78XxGnjvx9gR3g3mPQ6GGo0NQrr27RoKJU4iA/BI0nbeLtr1LF+xbb4c7PkmlmitebnRy9Hz19QHOAJsCTh0AMLK5J1InSfNrCUXyjKlNwX7qpg1UF58kJEf/vVn6L6OQ3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec8AMQt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec8AMQt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74507C4CEDD;
	Fri, 17 Jan 2025 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124008;
	bh=F/hgAFGSqkaHOJ+v6R5RZ9VxbNfrlJ2GszhU9BoZ/Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ec8AMQt1cRJXqhYtuUkQEXcWU8XmX3tqpdNq3IQ4K4IriUsTVuIcMqSxqETEdxd7/
	 qy3y6amvgBBs/TBTUaV2kIb/L5OVngGZDipZmckhEVJlXr751mxrhEzRp4WBRDrJEU
	 iR0jN/ISAMg5dX9zXPfr4nwSgQonVVINz/86x6zWNUonVdrdHIWuwpG1eKeKRIkWj8
	 LXzlHO243A/6OzmxkyYuq+CszXQ6LsVG5xBTlwrzHO0nwA31JcPTpzPpdKQ6ivasUq
	 LCB2OWd7r5HN4V1ueIqjZUpVPI0GaHV7M4Q58cTuKLZ0TS4FXdtvv+FRcaTFUdGbZS
	 WlXPFYs0J2/+g==
Date: Fri, 17 Jan 2025 15:26:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: reveliofuzzing <reveliofuzzing@gmail.com>
Cc: damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Subject: Re: out-of-bounds write in the function ata_pio_sector
Message-ID: <Z4popNqD1GZriXh3@ryzen>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z3ZtFDgs61oDMMB9@ryzen>
 <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>

Hello reveliofuzzing,

On Thu, Jan 02, 2025 at 11:23:49AM -0500, reveliofuzzing wrote:
> On Thu, Jan 2, 2025 at 5:40 AM Niklas Cassel <cassel@kernel.org> wrote:
> > On Wed, Jan 01, 2025 at 09:17:02PM -0500, reveliofuzzing wrote:
> > > Hi there,
> > >
> > > We found an out-of-bounds write in the function ata_pio_sector, which can cause
> > > the kernel to crash. We would like to report it for your reference.
> > >
> > > ## Problem in ata_pio_sector
> > > ata_pio_sector uses the following code to decide which page to use for the I/O:
> > > page = sg_page(qc->cursg);
> > > offset = qc->cursg->offset + qc->cursg_ofs;
> > >
> > > /* get the current page and offset */
> > > page = nth_page(page, (offset >> PAGE_SHIFT));
> > > offset %= PAGE_SIZE;
> > > but we found that `offset` could be as high as 0x5000---qc->cursg_ofs==0x5000,
> > > qc->cursg->offset == 0x0, making `page` point to a higher-position page that
> > > belongs to other threads.
> > >
> > > ## Example crash
> > > This out-of-bound write can cause the kernel to crash at arbitrary places,
> > > depending on when the corrupted page is accessed by the other thread.
> > >
> > > We found this problem can happen in Linux kernel 6.1~6.12. Here is one crash in
> > > Linux kernel 6.1:
> >
> > Thank you for reporting!
> >
> > I assume that you haven't tested kernels earlier than 6.1?
> Unfortunately, we haven't tested older kernels.
> 
> >
> > (Looking at the driver, there was no major change between 6.0 and 6.1,
> > so this bug has probably been there for a long time.)
> >
> >
> > Could you please share your reproducer and your kernel config as well?
> 
> Below we report our setup for linux kernel 6.12:
> 
> - General steps to reproduce the bug
> 1. Launch the VM
> 2. Copy the reproducer (compiled binary) into the VM
> 3. Run it with the root user
> 4. Wait for the bug to happen (generally takes less than 3 minutes)

I managed to reproduce the bug using your bzImage and syz-executor binary.

However, the .config you provided does not match the bzImage.
E.g. the e1000/e1000e driver is not built-in in your .config,
so I get no networking, while it is enabled in your bzImage.
This makes me worried that you have other changes in your .config.
If you still have the exact config for this bzImage, could you please add
it as an attachment?

I've been using the syz-executor binary that you attached, since the C code
pasted below does not compile, it seems like it has some unintended newlines.
Perhaps you could add it as an attachment instead?

Also, you only talk about 6.12 kernel. Out of curiosity, have you managed to
reproduce this bug on v6.13-rc kernels? Have you tried?


Kind regards,
Niklas
