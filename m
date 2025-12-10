Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F925F988
	for <linux-ide@vger.kernel.org>; Wed, 10 Dec 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333753; cv=none; b=paOu1ivtCzcQ7sxWiOkrG8tLjG3Lt1lKxIbfFFMh8aGQLTeI1HveF0AGdt6K29o+6aVLVNB9eHItZaD/s8oGS4SdtsgGtuW5C3Q+sMuAt3EKMXRjjMTlJY9mUZIr4S9Ozt7/yXR6R3r/+BYA1GTOId7rqHmiRbk5Va4DcxUrqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333753; c=relaxed/simple;
	bh=XMbt7+69M1vdggmT1/JubRne9e9ipETRMQ7b+KFStK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdInpMyR0+EEBe+UCkcP2fjKEvppAU+zGEAGSRgWlWUBg7Li6KcT90u0jlrEaCzowJ7L6GOQjZKirlMoo26fCt/Lkj+/F2lIGu4cj1oMLMhhS7AWWEUq6bvdHhPLb9y0IJ1+j6E88u84pqz+FG+R9JpcIkPb64+5vS+8523WceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTW9GbV+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTW9GbV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4003AC4CEF5;
	Wed, 10 Dec 2025 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765333753;
	bh=XMbt7+69M1vdggmT1/JubRne9e9ipETRMQ7b+KFStK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTW9GbV+/8YSgaNoDwZ1tyLZIpMo2JW27VjlRc6HmLBI2rRLtMXegZm4z+fUrXPWg
	 T8X2ktAshQEPDgHj2DV2F5qRQw0Kc4fm15W2MacCEUPmArqAyurfe+qQPBW/4J9D/w
	 zKN0vy6sr5ws1jmrO9wdq7YyRB70YaeYAQe4dAXd9jp80fbNEIOH6bAXDE6cP+agyg
	 yjMsBQ3pheTjzNzoJ3NcrS7SYqTnZGTYpOv/Y2hMx2Y6wNjW5tdYbQqdCW7TUCMf6p
	 bHNTT8Rkey9C2SwcK5NqBlycORVvDyomJ3GCV/Md1T0uZ/mJ55yY4Xq7ycjoZjQ4xf
	 dW9UqRs+mKvbQ==
Date: Wed, 10 Dec 2025 11:29:10 +0900
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
Message-ID: <aTja9mQwpjAJqrFd@dhcp-10-89-81-223>
References: <20251209042359.1467124-2-cassel@kernel.org>
 <de7c9e53-b153-4e29-a841-99802cabf44b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7c9e53-b153-4e29-a841-99802cabf44b@kernel.org>

On Tue, Dec 09, 2025 at 05:42:37PM -0800, Damien Le Moal wrote:
> On 2025/12/08 20:24, Niklas Cassel wrote:
> > According to a user report, the ST2000DM008-2FR102 has problems with LPM.
> > 
> > Reported-by: Emerson Pinter <e@pinter.dev>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/ata/libata-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index b96105481784..94c0e0ff981f 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4187,6 +4187,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
> >  						ATA_QUIRK_NOLPM },
> >  	{ "VB0250EAVER",	"HPG7",		ATA_QUIRK_BROKEN_FPDMA_AA },
> >  
> > +	/* ST disks with LPM issues */
> 
> s/ST/Seagate
> 
> Other than that, looks good.

Perhaps you can fix up while applying?

Emerson sent me a message off list, confirming that the quirk is applied.


Kind regards,
Niklas
