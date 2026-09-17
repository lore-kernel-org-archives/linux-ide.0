Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10C58FD01
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654685; cv=none; b=hUhJAML3f/anT6gVl2h8mVonldzEyiXjFRvtEbjGNvTnbdZyJl0NUxGKlyUz5WntCkMLGqnf+vS8xfeja0SqnKE3/8BD+KNvtfkEBndAlH/NuKi+UZnDLaHfTKbHp9mZFaSVHC1aegriSYHkGOlUUDnz2Vg2oQa9LyQcpfIRJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654685; c=relaxed/simple;
	bh=4StvYSHVvYHqKy4DgWS2cJm8zE8dyQz2HJyre/IEuPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkyWvZHApYrTYI5SAK0tsyprj7aRo+TTs5HhHfDIDKzP/wcxin3rBiN50woQOfivu89pbu94eNwLFqUtR9qAXuly1PeK9bALOHkb2CiiK6h163Zdm+ebwtOBMG4N8bFDBVTvOkETKBiay2URPXDWIsu+1vKJoxtcQHhaJr3x6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxyUPG5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxyUPG5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68391F000FF;
	Thu, 17 Sep 2026 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654682;
	bh=0XDc51sfoS5b9O6swHhi/QLFe3rkUO7TuOeaAHR/s+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CxyUPG5y5oolR8MV1xIqSi4zmt3eg6lC2xopERP4R+XCxniH5oQpdHtTRQdf60aTU
	 hCuIQ/uOzYhsDanNZqPNzQ/p87maD+Sse4a7aLqABavAYyVHeMVS8g1AWkXnanTHUH
	 NNy4eVxhtAWt3J9kFdB4mz/nc3xIrsZB8Q2uaZmp3HnTzItTaMm5RzIZfSNye7w10d
	 FFaV712UaBXh34jlG1vShdVqmYpMlfVd4dbEWnLrFcDnE8E55SiwlJZH1GoM+BIEVA
	 uIGJ7pbNNdZaXnJx+vfJzDC079KtcBdbCUnI74YSIR/i3NbtQOt+IKrhPyUyDrYmk2
	 iKfAF7QdRfCwA==
Date: Thu, 17 Sep 2026 16:17:59 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	rosenp@gmail.com
Subject: Re: [PATCH v3] ata: sata_dwc_460ex: Don't enable interrupt if libATA
 core registration fails
Message-ID: <aqv2l4pGuk7K375x@ryzen>
References: <20260917113526.1589813-1-nik.borisov@suse.com>
 <71caed6b-2aa9-4c4d-bbd9-aac41aa6a011@kernel.org>
 <3d8e8d30-1c67-4973-aed6-5fa9737b6492@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d8e8d30-1c67-4973-aed6-5fa9737b6492@suse.com>

On Thu, Sep 17, 2026 at 04:26:41PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.09.26 г. 16:18 ч., Damien Le Moal wrote:
> > On 2026/09/17 18:35, Nikolay Borisov wrote:
> > > Recent 4bbc16a353a9 commit changed the timing when interrupts are
> > > enabled. However it didn't account for the libATA registration step. So
> > > it's possible that interrupts are enabled when the device is not
> > > registered with libATA core.
> > > 
> > > Resolve the issue by ensuring that interrupts are enabled only if the rest of the
> > > initialization is successful.
> > > 
> > > Fixes: 4bbc16a353a9 ("ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler is registered")
> > > Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> > > ---
> > > 
> > > 
> > > Changes since v1:
> > > 	* Added proper goto label
> > > Changes since v2:
> > >      * Rework logic so that interrupts are enabled if everything is successful
> > > 	and don't call phy_exit otherwise, as the driver is quite broken w.r.t to it.
> > > 
> > >   drivers/ata/sata_dwc_460ex.c | 8 +++++---
> > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> > > index 8e3fc713891a..e74335dec42a 100644
> > > --- a/drivers/ata/sata_dwc_460ex.c
> > > +++ b/drivers/ata/sata_dwc_460ex.c
> > > @@ -1185,11 +1185,13 @@ static int sata_dwc_probe(struct platform_device *ofdev)
> > >   	 * error_handler() to execute a dummy Softreset EH session
> > >   	 */
> > >   	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
> > > -	if (err)
> > > +	if (err) {
> > >   		dev_err(dev, "failed to activate host");
> > 
> > Why not simply "goto err_out;" here ?
> 
> That was in V2 however Niklas discovered some issue w.r.t to phy_exit.
> https://lore.kernel.org/all/aqGFjsuIMRIy5xfv@ryzen/

I have since merged a series, which is queued on ibata/linux.git (for-7.4):
https://lore.kernel.org/linux-ide/20260915084127.692494-8-cassel@kernel.org/

See:
https://lore.kernel.org/linux-ide/20260915084127.692494-13-cassel@kernel.org/

Where, if ata_host_activate() failed after ata_host_start() returned success
(which will have called call->port_start()), it will call ata_host_undo_start()
which will call ->port_stop().


Thus, the Sashiko comment on your v2:
https://lore.kernel.org/linux-ide/20260909113821.A72011F00A3A@smtp.kernel.org/

is no longer valid.


Please send your V2 again (as a V4) just so that we can get Sashiko to review
it again.

Preferably use:
$ git format-patch --base libata/for-7.4

So that it adds the proper base commit that you depend on.


Kind regards,
Niklas
