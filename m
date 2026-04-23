Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A330EF8F
	for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942925; cv=none; b=IRMMmyg/tlUX2XTVK1A2Abi+sfC5s9e4iHYsMaVOc+D7iYt1usKtpbygqYbCRGocv3Y+WKrW19Ph03p8KExcA8PDTd/0zhRvYO+jdFPzhu5EP6CiIQeRqdTSULPRhowLfqn5lZE76GlOpex+sosg71TIEeZgUtBGRnKSS19iPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942925; c=relaxed/simple;
	bh=FZ+KqEOY8Au+l0aTYPICFKrbk63cneCrqrjuBerVASs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCkyhN+Zx3LUvu6mboj4o3oHDUQcCfEMealPAmA0RXfxfbay3gL9jx/1zg5kofEBSC29tTG7+dnMkMLZxj+LDJZtrprkh3yEdDT77RAH2R5az3TDDWig0fX8YZA02WeoT9zYdAoQCUkLLHLe2+q9vJeNNIRjpceIxb/mTs6+8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE+f54sb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE+f54sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A24AC2BCAF;
	Thu, 23 Apr 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942925;
	bh=FZ+KqEOY8Au+l0aTYPICFKrbk63cneCrqrjuBerVASs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gE+f54sb2mYT5zR3DTeYZMVD6moS5JOSi1v9uZsP1+402SN46Y+Gbt65gYbe8JQEI
	 GoQUAUoQI3aZ3mAxhstT3vDigwAwtY6yLj7FpT9a8cXWKWaJxZT8AGjpsArHJ7I70e
	 zRki5JN5vg1xMG6GMt6MTxF9Q8xIpBypPX7JV5O0PNHOgFz/yDxP8x2RNfRWOyKGzA
	 hKc96SB/4/Sw629bxe+Kdl2FSOGMebi4HeDj8syDobyghWgusAw9ZhdX3guE3WLoIZ
	 Rw0e3fBgvaaA6CPEM7RlTpzCEocEf0PWfXwv7f+1RulD0gEHxyX6TI/MU4zMT43fAS
	 lN1QfJ9vOGxUQ==
Date: Thu, 23 Apr 2026 13:15:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
Message-ID: <aen_SQ-7fPfdAylr@ryzen>
References: <14015677.uLZWGnKmhe@alanarchdesktop>
 <23071769.EfDdHjke4D@alanarchdesktop>
 <aeZUCa5wumWXi_yN@ryzen>
 <f8dAJyMVQ4yJA5_7X9Jscw@alancui.cc>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8dAJyMVQ4yJA5_7X9Jscw@alancui.cc>

Hello Alan,

On Thu, Apr 23, 2026 at 05:18:24PM +0800, AlanCui4080 wrote:
> On Tuesday, 21 April 2026 00:27，you wrote：
> > From this it seems that it is simply the first IDENTIFY that times out.
> > On the second try, it seems that the IDENTIFY passes, otherwise we would
> > have seen more "revalidation failed (errno=-5)" prints for the same drive.
> > 
> > So, from this log alone, I don't see any problem. We will try to do IDENTIFY
> > up to three times, so just a single IDENTIFY failing should not be a problem.
> 
> So at your opinion, the error is caused by a hardware failure but not kernel, 
> so we should not add any quirk to relax or solve the problem, is that correct?
> (I just want to confirm that how kernel will deal with this error)

Like Damien said, the IDENTIFY DEVICE command is one of the few commands which
a device is required to execute without leaving the Standby state or requiring
a spin-up. A device is allowed to reply to IDENTIFY with the 'incomplete' bit
set:

37C8h - Device requires SET FEATURES subcommand to spin-up after power-up and
IDENTIFY DEVICE data is incomplete (see 4.19).
738Ch - Device requires SET FEATURES subcommand to spin-up after power-up and
IDENTIFY DEVICE data is complete (see 4.19).

8C73h - Device does not require SET FEATURES subcommand to spin-up after
power-up and IDENTIFY DEVICE data is incomplete (see 4.19).
C837h - Device does not require SET FEATURES subcommand to spin-up after
power-up and IDENTIFY DEVICE data is complete (see 4.19).

libata looks like it already handles this:
https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libata-core.c#L1903-L1922



However, in your case you get a timeout, which means that the device does
not reply at all.

Before a system suspend, libata will send a spin-down/STANDBY IMMEDIATE
command to all drives.

After a system resume, libata will send a COMRESET to all devices, before
it sends the IDENTIFY, and after that it will send SET ACTIVE to spin-up
the drive.

It seems that occasionally, some of your drives hangs in a weird state after
STANDBY + COMRESET + IDENTIFY. When we get a timeout, we will do another
COMRESET + IDENTIFY, and this time your drive does not hang.

My best guess is that it is a HDD firmware bug where the drive sometimes
hangs after a STANDBY + COMRESET + IDENTIFY. Or claims to be ready before
it is actually ready.

It could of course also be a bug in e.g. ata_wait_ready(), and we are sending
the IDENTIFY command too quickly after the COMRESET, but if that was the case,
I think we would have seen way more bug reports from different vendors by now.



Anyway, considering that from a user space perspective, we are never removing
the device (we only do that if we fail IDENTIFY three times), so the retries
themselves should not be visible to user space applications.

So if you disregard the error in the log, from a user space application
perspective, the only difference should be that it takes a few extra seconds
for the device to reply to commands after a system resume.


> 
> > So I think the question is, at this point, can you read from the drive?
> > 
> > E.g.:
> > # dd if=/dev/sda of=/dev/null iflag=direct bs=4K count=1
> 
> I will be blocked out of the shell for 5 secs unless the IDENTIFY succeed.

But as soon as you get a shell after a system resume, the above command
succeeds, right?


> 
> > 
> > If you can read from the device, then this seem like a problem with zpool
> > kicking the device off the RAID array (perhaps because it is taking longer
> > than some zpool defined timeout value?), rather than a libata problem.
> 
> But after the link re-established, the drive works normally.

My suggestion is to look at the zpool code to see how long it waits to finds
all devices after a system resume before it kicks devices off the RAID array.

My initial feeling is that if your device is ready after 5 seconds after a
system resume, then the timeout value for zpool to kick off a device must be
very low.


Kind regards,
Niklas
