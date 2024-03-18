Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE5F861
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806362; cv=none; b=HJwUzdFJJ2DX9Zk0Ut31gxHR9h4bRCZ22rH4Cq6zs30s5pPc+NiLzH/zeyJocLzxqBI4gSat0GfPr7gPbeebJGCT6zfuXt66PI1o/COF0v2tGDnejeqgvV9L/PwcwN1nFBjfd52rCXckjCLBWCaAxFU7UF0joH/aZax9S3eUdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806362; c=relaxed/simple;
	bh=mCeKIA0rcsjEmHiy9yspIAYxJCWRESIV725m1K9X3Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk0hURlJZ8AToPuKNrE1hB906WNtj1LB5oZZlCnCYhg6qgUGcXkKHAsTKDUITshVoN8x8pdEKi7IDAdwthP4QK5DbMXRz2g70RGfwYmR6k1kaZmMBisUR8X/Hb5jv08UIXHKTABfqxjhBlujSTNKqBqaeDQCY9qaNiS2cmjjWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAgK+CJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAgK+CJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408EDC433C7;
	Mon, 18 Mar 2024 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710806362;
	bh=mCeKIA0rcsjEmHiy9yspIAYxJCWRESIV725m1K9X3Yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fAgK+CJCfaUJ1rsiyKK8Jq66fkMl/FTrReiCl+mqIYGitWTE+kZv8aNZc2Zs4Gzoe
	 EEUXvTBDvXI6PceiENKNTKaTwW81dqN2YMZp2JFqPJW+eZU8WnMwde45BpB6URHtv1
	 poJCFS8EHn1ICev2EdfPGX9Y9MBGfbuJKP4hPhvYemEeDdqzV3eQt8MTWNQ4glqh08
	 lR2ltGnefdJjAqktjBF/bRi9y7q7cPh86U9QEEfXjPlzWrsrZGa+TfIPrJTSvG//Wm
	 7sGHogIU0uY6ziPHEZQZsFAlvPMhG8pMd739TksMju91wi6BU9l+blbiyeUAR4p/4o
	 2Ng+9I8JRiS9w==
Message-ID: <921f2ef8-7afb-4ae3-9f3a-e5b412f590a8@kernel.org>
Date: Tue, 19 Mar 2024 08:59:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
To: Hans de Goede <hdegoede@redhat.com>, Niklas Cassel <cassel@kernel.org>,
 Cryptearth <cryptearth@googlemail.com>
Cc: temnota.am@gmail.com, linux-ide@vger.kernel.org, conikost@gentoo.org
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <ZfMerqAmWoyu66/5@x1-carbon>
 <2e471c2b-8432-4501-b093-4295529a4d38@redhat.com>
 <CAFDm6W0zP=Yw_OA9_qJ17Np=px=sR69m9hGF3D96A9gyS5PLTQ@mail.gmail.com>
 <em260ca711-2dd7-490f-b401-eeac6c172e98@c8aae956.com>
 <CAFDm6W2nCj+qw=-7Sb9xcJTYZ8sitwUriR+Qdh9fo9+ET1Oo=g@mail.gmail.com>
 <CAFDm6W3c7UUHRVG_WzEUK+pmHQNUywFpJZtkeWVVxrX-oBKpqw@mail.gmail.com>
 <Zfgd4gjQS0Cmexeq@ryzen> <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>
 <db682ed0-3ccf-46f0-bdbc-e9d694f48e6d@kernel.org>
 <b318971e-4748-49e0-a2ae-a1fba9267d82@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b318971e-4748-49e0-a2ae-a1fba9267d82@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/24 23:21, Hans de Goede wrote:
>>> But can we please drop the problematic quirk to lower the number
>>> of ports for now, to avoid more people getting bitten by this
>>> regression ?
>>
>> I am strongly against reverting that fix/improvement because of a problem with a
>> badly broken hardware that does not respect the AHCI specifications. Such
>> regression was bound to happen with such hardware and likely will happen again
>> in the future if we touch anything that does not fit with the adapters weird use
>> of PMP or other feature. I do not want libata code to be stuck as it is for fear
>> of breaking support for adapters that are already broken in the first place...
>>
>> So let's go the other way around and add a libata.force parameter that allows
>> disabling the port count fix, or allows specifying a port mask. That will allow
>> users of these broken adapters to get them running again. Ideally, we would use
>> a quirk but it seems that the same controller chip is used in both correct
>> setups and broken-PMP setups. So unless ASMedia indicates some black-magic
>> register we can look at to know what to do, it will have to be a "manual" module
>> parameter.
> 
> The kernel has a clear no regressions policy and there is ample documented
> cases where needing to set a module option to undo the regression was
> considered not acceptable.
> 
> So there really is no discussion here. We must not regress and thus the default
> behavior must be behavior which works out of the box on the boards with
> the PMP chips on them.

I am well aware of this policy and always work hard to not introduce any
regression or to address them with the highest priority when they happen. It is
however very unfortunate that such policy must be followed even when the
regression is due to some bad hardware that does not correctly follow
specifications and just happen to "work" by chance before a change. I do not
feel that is right, especially considering that in this case, the revert will
cause users with correct hardware to again see very long boot time (minutes order).

> Also we really want Linux to "just work" having to set a module option
> just to make things work very much goes against that.

Sure, but then avoiding the long boot time will still need a module parameter to
force applying a port mask. So it is one or the other here... I vote to support
well good hardware.

Anyway, I am not going to fight this and go with the revert for now. But if we
do not get anything from ASMedia to help resolve this, these broken adapters are
likely to cause issues again in the future. And because of that, I would very
much like to just blacklist them unless someone write a special driver for these
that does not pretend to be AHCI compliant. Because they are not.


-- 
Damien Le Moal
Western Digital Research

