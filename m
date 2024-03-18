Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1725624
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759399; cv=none; b=c0npLmzRo73J7WZFbgVuVSIkGCIwOVVR4m67cbPwd9vxtaefOj6t7UEpYlHmoL5stn7LArJOwwnib8iwdT8mImIhTmv832VpSUy59Rr7qh1fWPJy77wTGwbOPJpKLUPoi96TTP0qFcwM74ftnZG//Xp0FN3hsAe6w2PjnTQhxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759399; c=relaxed/simple;
	bh=Vo/JLpp9fcg0QOvxa5+L/vHj/GpCCmoXHLzRynyFIzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEXWK0qGDZv7okxMsjuB67qKspIsgPFEq7/9ZpClIqQJOWCm6M83WTHJ67RE8wVctA5p00udTavov+yUMxSZcV8RWNkiVWdrMP2w7gZ1HBAm/YtXvUwCFNvxVRNf6jMPrminz8108zuUqdhbQkFMQm4jmy8hPEyDQAtjD5MGt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBQ1ony1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBQ1ony1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E4C433F1;
	Mon, 18 Mar 2024 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710759398;
	bh=Vo/JLpp9fcg0QOvxa5+L/vHj/GpCCmoXHLzRynyFIzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBQ1ony15Th6zWRlivfsWtj5fFzX8dxpir1eKl1kSbi0rM/64ft/03SODC2Fq5oVd
	 ZW4BsEDsoofTRChaM5Ks2b8v+JaxrQU9pHRwMw/JC4ggs+na+n1M6BzpV0zfAkJ3zY
	 lQCKrWMOdHigDgFWd67eUckZbxaphfcDquEu7lEtrUg82NvGJUMGCbEiCZqebB0+JX
	 35GKtDgcJH1VacDmvXb9IaVfIlcKNXkkd45qrW1y/NDZzHN6PujYUI3DRLy5olc1H7
	 zo5mviGAN0g+tCKuu84rwAViZLL25+oe8hoRSz/Opk5C6IXLnO9OZte1rXUVoWTjFZ
	 m0Y0MqfjSlL5Q==
Date: Mon, 18 Mar 2024 11:56:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Cryptearth <cryptearth@googlemail.com>
Cc: temnota.am@gmail.com, linux-ide@vger.kernel.org, conikost@gentoo.org,
	hdegoede@redhat.com
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Message-ID: <Zfgd4gjQS0Cmexeq@ryzen>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>

Hello Matt,

On Sun, Mar 17, 2024 at 11:58:14PM +0100, Cryptearth wrote:
> Sorry folks - GMail somehow not send my reply to all of you but only
> one. My bad - haven't noticed it.
> 
> Anyway - tldr: The provided patch doesn't work.
> I build the 6.8.1-arch with a simple fix of commenting out the ASMedia block.
> No matter how it's dealt with - I do understand the issue this change
> is about to fix - but there has to be some override. Forcing users
> like me building the entire kernel (and additional modules like ZFS or
> nVidia gpu drivers) on thier own just for 4 characters in 2 lines
> (namely /* and */ before and after the block) just isn't acceptable.
> 
> Greetings
> 
> Matt
> 
> ---------- Forwarded message ---------
> Von: Cryptearth <cryptearth@googlemail.com>
> Date: Sa., 16. März 2024 um 14:47 Uhr
> Subject: Re: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will
> break cards with port-multipliers
> To: Conrad Kostecki <conikost@gentoo.org>

Please be respectful on the mailing list.
https://docs.kernel.org/process/code-of-conduct.html


> @Niklas
> I tested the patch - but unfortunately it does not work with my card.
> See the attached log - the fun starts around line 760. This time I
> also attached the output of lspci -vvv -nn. I haven't checked for any
> differences.
> As Hans wrote my card seem to do something way different and out of
> spec of standards.

Is CONFIG_SATA_PMP set to y in your .config?


Looking at your logs, we can see that port0-port3 all don't have a link:
[    0.919020] ata7: SATA link down (SStatus 0 SControl 330)
[    2.787201] ata8: SATA link down (SStatus 0 SControl 330)
[    3.100522] ata9: SATA link down (SStatus 0 SControl 330)
[    3.413890] ata10: SATA link down (SStatus 0 SControl 330)

I looked at your v6.7.xx log as well, and it is the same there.

So Hans's theory that port0-port3 is each connected to a
JMB575 Port Multipliers does seem less plausible.

Because if that was the case, I would expect to see link up on these ports
and that it detects a PMP class code when probing these ports.

So I have honestly no idea how this works...

Perhaps the ASMedia firmware takes the command to port0-port3,
and instead of sending it to the PMP, it sends back some faked
reply instead?

This piece of hardware really seems to do not care at all about
following specifications...

Fun fact:
https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
Claims that it supports AHCI 1.4.
That is impressive, especially considering that the latest version
of AHCI is 1.3.1:
https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface

I will send an email to some ASMedia developers on the list and see
if we can get any clarification.


Kind regards,
Niklas
