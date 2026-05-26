Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE7356761
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808031; cv=none; b=O8eeGU4JmhWnQHygk1TehoYArpV46h3WgO35UpMWtApQU8px1LMYEslVYDm/52bkMHoqpEi/IpyX0SG4Fg5yhOUE6nQ1CpqT2lwMnEh9s37tPJgZnGC1L4bjllXE7F8xsJKc73GctfIiLS/ZsiMf5OTo4SKBWwpX0Xzjt8n8EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808031; c=relaxed/simple;
	bh=ObLBmFZnZgWLmL8Co1fEJip3eKzbPH8VpSkCXcIo7Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZy1nba6M+yEhg3Pah/gbQP21G+xEyKXJbE6mP2soyOfLU6TnxMiFREAgMh8prpL97807IlK062ORSZroubYlXMsF4uJGIW407wGaWo2mKFAWszH+N3KyY1zispXrYZ+0GWHpZBJUfWmyPwy6T5wISkxGoq21cZicESAfZbYPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifhOfu/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifhOfu/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33141F000E9;
	Tue, 26 May 2026 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808029;
	bh=fH11Vg3lyfkhnIe4Wtt7kUzhDVdn0HAGnEnsSj5cHug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifhOfu/Dt7TAldz/Ne1Q9ng+Ybo1W3AcXI5H2Cke+Xlk4JURDcFAoObhNAgQ+YwoT
	 5igoAXyZ7K9otqem4mvNrtfv45eTWJuRsqEar3yc1kJb9C0fi/e9/bQeq0V7PfMv3L
	 k7USgIslRzZ4L/4LjOfrCUmNgNOYid7w/bCNvMK5wXCaom7m6rNS400CXyoh0Bn5UR
	 VepHbOk1RBhAFmcky2kZTYV15aMstnrBqltAvNeOFB5wS5M9v1EpWCbldbzklZsM5k
	 vtVYw7nQ78fW2OfBSUX/dUAjgmYbScs+Xv7b9Dep0MWEYTvoq7bX/uJwTAX++5K/j5
	 wq9BygcsSSY/w==
Date: Tue, 26 May 2026 17:07:06 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
Message-ID: <ahW3GuCDCz1wnp3H@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521173347.2079560-3-bvanassche@acm.org>

Hello Bart,

On Thu, May 21, 2026 at 10:33:30AM -0700, Bart Van Assche wrote:
> Prepare for adding lock context annotations that refer to the ATA port
> argument (ap). No functionality has been changed.

For this and the other preparation patches:
Please add some additional text explaining why this change is required for
us to add lock context annotations.

I guess it is not possible to simply add __must_hold(dev->link->ap->lock)
annotation to __ata_scsi_queuecmd() ?

But at the same time, you do add __must_hold(dev->link->ap->lock) to e.g.
ata_scsi_translate().



Looking at the C-file, I can see that patch 9/9 adds:

+	/* Tell the compiler that dev->link->ap == ap. */
+	__assume_ctx_lock(dev->link->ap->lock);

to __ata_scsi_queuecmd().

but, that annotation is using dev->link->ap and not ap directly.


Patch 9/9 also adds a __must_hold(ap->lock) annotation to the declaration
of __ata_scsi_queuecmd(), i.e. in the header file.

Personally, I think that it makes more sense to have the annotation in the
definition (C-file), since that is what we most often read.
If clang requires us to also add the annotation to the declaration, then
perhaps we can have the annotation both in the C-file and the header file?
(Especially since you do annotate the function definition for those functions
that do not have a declaration in the header file.)



Not strictly needed, but assuming that we still need to grow an ap parameter
to many functions, would it perhaps be possible to restructure the series like:
1) Pass the ATA port argument directly to __ata_scsi_queuecmd()
2) Add annotations to __ata_scsi_queuecmd()
3) Pass the ATA port argument directly to ata_qc_schedule_eh()
4) Add annotations to ata_qc_schedule_eh()
5) Pass the ATA port argument directly to ata_qc_complete()
6) Add annotations to ata_qc_complete()
...

That should be possible, right?
(I guess you might need to reorder some patches.)


Thank you for spending time on this!


Kind regards,
Niklas
