Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222F3E7BDE
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878658; cv=none; b=ORF+wau24e7u8k5eFy8ofRaTzej8j2KlqtAfFMzW1Okfh2KWRIdqAol6nUrpmmG5cUEx1I4YFjsgJTe+4PovCcoMlR5T+swm//ei8fFyFjaJES1n35yiGqUUwz5/+RzuH21y8YVmXDzM8L2aQ7YT3MHoZRXY6aq3HpPKeCAFHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878658; c=relaxed/simple;
	bh=Om5IWuW/Df/4u2NvvjNybNdQkHgR6NamKRLVSlygDKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXg7ApSbRMl6hSuLS3gmKSutgqwykbpzASu4hlW0MSzwjX6IcejyXXkuAwvCDUqE6qVFNU+Sc+y1jGy+Wno0p0Ve4wxGk2V5SX0XK2L7284zycHUJPIE8aZushg0TmInT9b7wB/iJI9uWa3YHcv48udkfT070tZE9WYKTw0D9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+bq64zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+bq64zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501171F000E9;
	Wed, 27 May 2026 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878656;
	bh=KRwLes+t8IBZJKTW1No/DM0qQ17coWa0IME/b9jc4JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+bq64zrSgQqwdpNqLGOyRGqSg1AaWaM/TTPlf2cmLrpN29/3lWSs37xxeCaM153L
	 OUQEKb4C5VnXnXyJ7a88q2QrjAdF+9sVAMydF0fKl6Ky3PK/ocTv/pqnxDhgtghqfV
	 xF6+I/LeslH9GceIza5C1+3e8IDjzL91W/CnO/19GoCkvuEj3Gq0rSSKjo1qYolNOb
	 Hlrrww8veypR/Jh7MY6tdmtIUeDRGPKN0dZzda1CjWiD0ZdD25Z0nb+hTRGTB+Dkd+
	 hFXoyqNB54ojqU/XYB7kl+wGbwsdJg3iXORRNIYCwTgVhSTpySoaMTfDlN7b9r5Plg
	 VK6cv2c8KdYsA==
Date: Wed, 27 May 2026 12:44:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
Message-ID: <ahbK_PC16fs-Ii7A@ryzen>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
 <ahW3GuCDCz1wnp3H@ryzen>
 <da5ecf6a-b01c-4cbd-bb95-ab5a1e6a9ad7@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5ecf6a-b01c-4cbd-bb95-ab5a1e6a9ad7@acm.org>

On Tue, May 26, 2026 at 02:46:01PM -0700, Bart Van Assche wrote:
> On 5/26/26 8:07 AM, Niklas Cassel wrote:
> > Hello Bart,
> > 
> > On Thu, May 21, 2026 at 10:33:30AM -0700, Bart Van Assche wrote:
> > > Prepare for adding lock context annotations that refer to the ATA port
> > > argument (ap). No functionality has been changed.
> > 
> > For this and the other preparation patches:
> > Please add some additional text explaining why this change is required for
> > us to add lock context annotations.
> > 
> > I guess it is not possible to simply add __must_hold(dev->link->ap->lock)
> > annotation to __ata_scsi_queuecmd() ?
> 
> Context annotations with complex expressions are supported by Clang.
> However, annotating __ata_scsi_queuecmd() with
> __must_hold(dev->link->ap->lock) would require annotating many
> __ata_scsi_queuecmd() callers with __assume_ctx_lock(dev->link->ap->lock) to
> tell the compiler that dev->link->ap->lock is the same
> synchronization object as ap->lock. If the "ap" argument is added then
> these __assume_ctx_lock() annotations aren't necessary in the
> __ata_scsi_queuecmd() callers.

I do agree that the __assume_ctx_lock() annotations are quite ugly, and that
we would like to avoid them, and as much as possible only have __must_hold()
annotations.

While it makes the code slightly more ugly to provide an ap argument if
strictly not needed, the advantage of enabling clang context analysis
would justify it.

I just want to understand how it works a bit better...

It obviously cannot detect that the lock taken by ata_scsi_queuecmd()
(ap->lock) is the same as dev->link->ap->lock in __ata_scsi_queuecmd().

Too bad that there isn't a more clearer way to tell clang that the two
objects are the same, by having something like an
__objects_are_equal(dev->link->ap->lock, ap->lock) annotation in
__ata_scsi_queuecmd(). (Needing to have an annotation in the caller, is
quite ugly... and __assume_ctx_lock(), which takes a single argument, seems
way more error prone than an annotation that would take two arguments.)


> 
> Do you really want me to repeat this explanation in every patch that
> adds the "ap" argument to a function?

Yes, please.
Even if the motivation might be more or less the same in all the prep patches,
I think the motivation should be in all the prep patches.


> 
> > But at the same time, you do add __must_hold(dev->link->ap->lock) to e.g.
> > ata_scsi_translate().
> > 
> > Looking at the C-file, I can see that patch 9/9 adds:
> > 
> > +	/* Tell the compiler that dev->link->ap == ap. */
> > +	__assume_ctx_lock(dev->link->ap->lock);
> > 
> > to __ata_scsi_queuecmd().
> > 
> > but, that annotation is using dev->link->ap and not ap directly.
> 
> I will look into adding "ap" to the ata_scsi_translate() arguments and
> removing the __assume_ctx_lock() mentioned above.

Sounds good.


Overall comment, for the places where we have something like:
/* Tell the compiler that dev->link->ap == ap. */
__assume_ctx_lock(dev->link->ap->lock);

Since this is in the calling function, I can see that you try to put it
as close to the function that is being called (the callee), but would it
make sense to also mention the name of the callee in the comment?


> 
> > Patch 9/9 also adds a __must_hold(ap->lock) annotation to the declaration
> > of __ata_scsi_queuecmd(), i.e. in the header file.
> > 
> > Personally, I think that it makes more sense to have the annotation in the
> > definition (C-file), since that is what we most often read.
> > If clang requires us to also add the annotation to the declaration, then
> > perhaps we can have the annotation both in the C-file and the header file?
> > (Especially since you do annotate the function definition for those functions
> > that do not have a declaration in the header file.)
> 
> I will look into adding annotations to both the header and the C files.

Sounds good.


> 
> > Not strictly needed, but assuming that we still need to grow an ap parameter
> > to many functions, would it perhaps be possible to restructure the series like:
> > 1) Pass the ATA port argument directly to __ata_scsi_queuecmd()
> > 2) Add annotations to __ata_scsi_queuecmd()
> > 3) Pass the ATA port argument directly to ata_qc_schedule_eh()
> > 4) Add annotations to ata_qc_schedule_eh()
> > 5) Pass the ATA port argument directly to ata_qc_complete()
> > 6) Add annotations to ata_qc_complete()
> > ...
> > 
> > That should be possible, right?
> > (I guess you might need to reorder some patches.)
> 
> Hmm ... there is no way to check that the intermediate state will be
> consistent because with this approach CONTEXT_ANALYSIS := y would have
> to be moved to the end of the patch series. Once CONTEXT_ANALYSIS := y
> is moved to the end of the patch series, how to let the compiler verify
> that any intermediate annotations are consistent?

I was thinking to move CONTEXT_ANALYSIS := y
to the first patch that enables context analysis,
which in my suggestion above would be:
2) Add annotations to __ata_scsi_queuecmd()

My thinking was e.g. for patch 2) to e.g. only add annotations in:
__ata_scsi_queuecmd() and all functions calling it / above it.

I would assume that there is no requirement to add annotations to
all functions below it. (As you have told us that we can add annotations
to additional functions later.)

Thus enabling annotations for functions below __ata_scsi_queuecmd(), e.g.
ata_scsi_translate() could be done in a patch later in the series.

E.g.:
1) Pass the ATA port argument directly to __ata_scsi_queuecmd()
2) Add annotations to __ata_scsi_queuecmd()
3) Pass the ATA port argument directly to ata_scsi_translate()
4) Add annotations to ata_scsi_translate()

But perhaps I am misunderstanding something.


Kind regards,
Niklas
