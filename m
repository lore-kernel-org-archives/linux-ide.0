Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CCB155C83
	for <linux-ide@vger.kernel.org>; Mon, 27 May 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826385; cv=none; b=dwySMz95onUqkUPwiW1Lcef4CrscbwJB1bTdD0bMwwbsUyJrhl7hObClTokxuPCCOpGX1Y24RFxpgmfnFT76chG255QzKstR5QlVh5U9wtLq8NCvjo46qsaYHlMwiK2CjYEZzFTLVXHM2yHRh9c71xFLMtxiyMoNYIvWCubeGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826385; c=relaxed/simple;
	bh=YPdNfpK8wJ1YI3z6lscOiv6kdr3LeFfSR+bOeB+xSMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8OWUN4KigJAgclQfjP6q6cP2IC++3L3BpTEKvlIhq1jaBB2qJ8Kt2D7rP+3vfwQ3nHOZcL9Gq3B0OlzP7QRllyOQjeH06YyXBJnRf1AgcnEven90JafKmsTjhpmKNLk3NW87mCHuHDaWZEjW7VENcQ1/yfYDoIQaue2qfbGQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJBDIcR5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJBDIcR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633ACC32789;
	Mon, 27 May 2024 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716826385;
	bh=YPdNfpK8wJ1YI3z6lscOiv6kdr3LeFfSR+bOeB+xSMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJBDIcR5ag+5hny5KVsEQIF3nrVfM4Gmd+Tq812nVIjhNp7ZB6oDuhsWGBzS6clU0
	 ek5mEWaPEHoves67znYofnuaAagM6p8CZGW+4fMwFvRcfN/0Zrl7EAWz4QIhjT4iji
	 obIzN459VT9zE31FJ0eZb75k24yFjkjhxrVWqZNXnCrA/4kRgN7ywFlCnbbpDb/1SI
	 Er0EUsLBI3koGU4EAENDak2JwzQN6BRTPcVB4ZuZChDRfy2ehOjFAgDTZKso1PZUc9
	 9dMyQbh6pvoNq5+78bE110/xH21EDEVvaaGwllfb879NpoDRIzhD90B7uP6OWSFKIa
	 QSFQob1y1z2fA==
Date: Mon, 27 May 2024 18:13:00 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tasos Sahanidis <tasos@tasossah.com>
Cc: dlemoal@kernel.org, jhp@endlessos.org, hch@lst.de,
	mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
	linux-ide@vger.kernel.org
Subject: Re: AHCI hotplug no longer functions on ICH7
Message-ID: <ZlSxDCS_pllymUxQ@ryzen.lan>
References: <c41c5bf8-9ed8-49c8-a9f4-431d523fffbf@tasossah.com>
 <Zkyl/RuvygEpVW26@x1-carbon.wireless.wdc>
 <a32a43a4-c482-4689-9852-85da4d936641@tasossah.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32a43a4-c482-4689-9852-85da4d936641@tasossah.com>

On Mon, May 27, 2024 at 11:59:44AM +0300, Tasos Sahanidis wrote:
> Hi Niklas,
> 
> Thank you kindly for your response.
> 
> On 2024-05-21 16:47, Niklas Cassel wrote:
> > If your port is external or hot plug capable, then your platform firmware/BIOS
> > should set either the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the
> > "PORT_CMD_HPCP" bit.
> > 
> > See:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata?id=45b96d65ec68f625ad26ee16d2f556e29f715005
> 
> Understood. I had looked at that commit, but did not look into those
> bits in detail. They were obviously not set correctly, thus the port was 
> not marked external.
> 
> > Is there any option in your BIOS to mark the port as external or hot plug
> > capable?
> > 
> > 
> > If not, then your platform firmware is broken and needs to be quirked.
> > 
> > Please provde the output from
> > # dmidecode
> > so that we can apply a quirk for your broken platform.
> 
> I went through again and checked for any "hotplug" or "external" options
> and found nothing. I was ready to try to make a quirk for it, but then I
> noticed the option "ALPE and ASP" under IDE Configuration (section 
> 4.3.6, page 4-17 of the user's manual [0]). It was set to enabled, so I 
> disabled it. That did the trick and the ports are now marked as 
> external.

Great!

Even if the platform implementation is not that great in my opinion...
I mean, a port is either "external"/"hotplug capable" or it isn't :)
(It shouldn't matter if ALPE (or SALP) is enabled or not.)

Aggressive Link Power Management Enable (ALPE) is simply the enable bit
corresponding to the Supports Aggressive Link Power Management (SALP) bit.

So the expectation would be that setting "ALPE" to false simply changes
the bootup value of the "ALPE" bit to false.

However, I'm guessing that your platform implementation probably toggles
"SALP" instead of toggling "ALPE".

Regardless, we can clearly see that setting "ALPE" to false also changes
either the "PORT_CMD_ESP and HOST_CAP_SXS" bits or the "PORT_CMD_HPCP" bit
as well...


> Thank you for your time, and apologies for not noticing this earlier.
> Perhaps this helps someone in the future with the same issue.

No need to apologize!

Thank you for reporting the regression on the mailing list.

Now we know that some platform implementations toggle either the
"PORT_CMD_ESP and HOST_CAP_SXS" bits or the "PORT_CMD_HPCP" bit,
when "Aggressive Link Power Management" is toggled in the BIOS.

Perhaps some other platform implementations do the same, so this
information might be helpful to others in the future.


Kind regards,
Niklas
