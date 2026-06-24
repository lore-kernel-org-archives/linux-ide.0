Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750E3074B1
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302957; cv=none; b=h8FWcMCUFYxm6u7Oaz5ky7GQ0aAGoK9QuPFVgg6D5bpmvk+2EY3F7rn+lNNuKxpTOS5JzTldrKLO1wLE9drGI1fYoBGBvudybWEqBCq3FrvttaXtDA8fLRlsqkBsx/13QljI35G70bVlQSduUwYPi33lkEoUu/cRci9KDoPas58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302957; c=relaxed/simple;
	bh=OVnlzL8y4Rp98GWJ56tX+1fBQDYKC7XwYskBq9oKEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI/IE5W9bnzdXdqAGNeqW3YklR32+8yR+NNeOaaXEJNRUbzP4kwI9zj1VCit0PIk706jJDormXw8MC52g/IJgGR2PSZxSuNam2niT1AmXHCuCBeOfLViXAKO+vvwGdCVW5oEipjiq+FVyRlBXvBZG82rfDjbNLJ8AY251Mcr5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjIgdJkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjIgdJkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512C81F000E9;
	Wed, 24 Jun 2026 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782302956;
	bh=Nv3gphvhihQr4Hrb7As3BQOciGby4CHG8TJTkgek9hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjIgdJkAN6Q5NUbz0tLz1G1IVMT7PHjijSK8XiBfBeH3USsuRWm0g9O3PgRq3dus4
	 M2fjxBSyF3EaL7soMQgHBQ9537rnC143qKnxZ7XYZgog8zyPZE3MP3YufngnjFUVfd
	 3hr1rye2XYcPU+v3VK7OtomET6vrntBWBS1YzddXkvLvEaaAKuKU0hc+bggnrOMWFB
	 IH1PAdTEFj1N5+qB5/MwfHnJcHw5AkubQwKQX633K6NTdKbxeDuqWZrOm4sB4HkhGE
	 0zzxuG9K8DXfGGtNP8gJB6rf7kq8e6PdO/v6jjPh492Y3W8J+xuN2TthzkEQOnuRwZ
	 2pLRSb9Tvzy/A==
Date: Wed, 24 Jun 2026 14:09:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
Message-ID: <ajvI6KEkggFcWNlk@ryzen>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
 <ajvErjEiGUuFm75I@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvErjEiGUuFm75I@ryzen>

On Wed, Jun 24, 2026 at 01:51:14PM +0200, Niklas Cassel wrote:
> So if this is not the case, I think the fix should be in SCSI.
> I guess we could add code in libata to return an error if INC_512 set to zero,
> and scsi_bufflen(scmd) (+ scmd->extra_len ?) is not a multiple of 512.
> But to me, for SECURITY PROTOCOL OUT, the current libata code looks correct.

s/scsi_bufflen()/TRANSFER LENGTH (cdb[6:9])/


> For your workaround, we should probably ensure that it is only applied for
> SECURITY PROTOCOL IN (rx). But... would we not be violating the SAT spec?
> 
> If we get a SCSI command with a scsi_bufflen that is not 512 aligned, and we
> apply your workaround, we will transfer less than scsi_bufflen to the device
> (since you now round down instead of up), but AFAICT, when calling
> ata_scsi_qc_complete() + ata_scsi_qc_done(), nowhere do I see that we call
> scsi_set_resid(), to indicate that the transfer has been truncated (i.e.
> that we did not transfer all scsi_bufflen() number of bytes), so it seems to
> me that your workaround would silently truncate the transfer, without informing
> the upper layer (SCSI) that the result is truncated.

s/scsi_bufflen()/ALLOCATION LENGTH (cdb[6:9])/


Kind regards,
Niklas
