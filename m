Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648212D042
	for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760065; cv=none; b=aTmkt/qExrl7EQBpeakCJsIblC4G7UokmAn8BE1CL8dL4TfBoEZ9wyO2TVGhFEiQEsabBTB4cbkhZ+N3fwzVd1y4Kf3tlKA3afGjr4aLNETQI4tb7vNM7olV/xtjU8WVNP1+42GJ1gcwHbqqkWC9Mj9FzuYbA7BpqU03eAXs3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760065; c=relaxed/simple;
	bh=QP2C/shQ934I6mr4D6lPnK/VTiajIaV28A9/wVOwAPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jez2773IKHlc/utlcKYsZcark1C+307ko7lW1kh9uhiSVk9qkaOHtIDgxS0B3/gJ1i/vlDct5anNEili7p0+igDBvNKDrGrktcBd/PnQkI65jWePIC/zjAybXlORH8L3vO8tYHYhNPSlhikWL2bEReiyAsrFMVGiMiTxaxMtyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDtqAdYu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDtqAdYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710760062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfPtBKGsZi4LE7xikyVl7DaraBFw5E82nfcYt9fvb8I=;
	b=RDtqAdYuC1wwyYQEkIaom0sqkW8EJJCNkvSi3Rc+NxtgrOZtu/omY5s3vAO6BoG9WVRwqB
	ZsB9EyWiTS887lWrNlS0gJZm8WzuxVd9PzY4gncou/rWmBe9dlgwTRJqu4zAn58TIlgG0d
	aIiJ15DcqGz7fZyCp759kfT26jR1dK4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-EvjJ_1bYPxiJLSbmJYJjSw-1; Mon, 18 Mar 2024 07:07:40 -0400
X-MC-Unique: EvjJ_1bYPxiJLSbmJYJjSw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a45b4f09107so286649966b.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Mar 2024 04:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710760059; x=1711364859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfPtBKGsZi4LE7xikyVl7DaraBFw5E82nfcYt9fvb8I=;
        b=CHjbb43Aq3oil4VqVLj6gPgn4P58c6tZBVO1ACWtK9WS2A/0K7fS8OMowlrToL+DHE
         SHokUmSp7bgDGSFwpb8/UlcbO2Uw6Rclb+UJqgk8YGlleo6Zy8amtbhhHtSghdaH4kWn
         eHemfzyc2KhBRDt1Q/vyA0DAIQiZzp7cIM7FjZpFhjYElVqRqCcRV+xoHhV0J0iVdMhd
         ooaWhn8wjq4/Ha2DGsuXVx3raLUsiHbvPe87J3FxPVw6gMUNSMHmssZqEm7PmmUqiSeF
         N5gqrsLqa5qSBnUOAzemB1AC2zI3An1snoNhi1BvxA6dEQQ0grisb/ZxcBa5q5i/8ZGC
         /ygw==
X-Forwarded-Encrypted: i=1; AJvYcCXnoUAN6SZzoiFvJkmKN6Sd47lXYdLTb4Ole1lvwXo1A+O1lc0QgsKxmSeuSYPIA2Wbw0LjDcd/fwsOyn4qzFfAxXcjvQTJfq0J
X-Gm-Message-State: AOJu0YzWAwRWnCPrSUyfZUk9IAu02vcirB36NGjy8ZzaVuxqcDaX3Ajp
	9o5ScMCXXRRGNIAON3NqnUfzHOUxxycVNI3d9DoUWaJT7n4pLzd6hV+I79XMx6FuOGTnV3yDen2
	m3YODDfSPB6DLXMoapVLc8Y4cxKv3/W+Af3bTkgXtz7OLwsqfkv/hmugxgrXGalUMxg==
X-Received: by 2002:a17:906:3708:b0:a45:f215:ce89 with SMTP id d8-20020a170906370800b00a45f215ce89mr7939272ejc.6.1710760059399;
        Mon, 18 Mar 2024 04:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgs4Hhf5DO2uwfTGjMVT+Izp2upkW5yNJ9O5t87zrQ+mnW9m5al+rfQLMUvv0dV2vDUESdg==
X-Received: by 2002:a17:906:3708:b0:a45:f215:ce89 with SMTP id d8-20020a170906370800b00a45f215ce89mr7939256ejc.6.1710760059034;
        Mon, 18 Mar 2024 04:07:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j1-20020a1709062a0100b00a46af0fbf5dsm1917698eje.103.2024.03.18.04.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 04:07:38 -0700 (PDT)
Message-ID: <65cd50b1-4f54-4f47-89d8-65b4ef2c0549@redhat.com>
Date: Mon, 18 Mar 2024 12:07:37 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will break
 cards with port-multipliers
Content-Language: en-US, nl
To: Niklas Cassel <cassel@kernel.org>, Cryptearth <cryptearth@googlemail.com>
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
 <Zfgd4gjQS0Cmexeq@ryzen>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zfgd4gjQS0Cmexeq@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/18/24 11:56 AM, Niklas Cassel wrote:
> Hello Matt,
> 
> On Sun, Mar 17, 2024 at 11:58:14PM +0100, Cryptearth wrote:
>> Sorry folks - GMail somehow not send my reply to all of you but only
>> one. My bad - haven't noticed it.
>>
>> Anyway - tldr: The provided patch doesn't work.
>> I build the 6.8.1-arch with a simple fix of commenting out the ASMedia block.
>> No matter how it's dealt with - I do understand the issue this change
>> is about to fix - but there has to be some override. Forcing users
>> like me building the entire kernel (and additional modules like ZFS or
>> nVidia gpu drivers) on thier own just for 4 characters in 2 lines
>> (namely /* and */ before and after the block) just isn't acceptable.
>>
>> Greetings
>>
>> Matt
>>
>> ---------- Forwarded message ---------
>> Von: Cryptearth <cryptearth@googlemail.com>
>> Date: Sa., 16. März 2024 um 14:47 Uhr
>> Subject: Re: Re[2]: ASMedia ASM1166/ASM1064 port restrictions will
>> break cards with port-multipliers
>> To: Conrad Kostecki <conikost@gentoo.org>
> 
> Please be respectful on the mailing list.
> https://docs.kernel.org/process/code-of-conduct.html
> 
> 
>> @Niklas
>> I tested the patch - but unfortunately it does not work with my card.
>> See the attached log - the fun starts around line 760. This time I
>> also attached the output of lspci -vvv -nn. I haven't checked for any
>> differences.
>> As Hans wrote my card seem to do something way different and out of
>> spec of standards.
> 
> Is CONFIG_SATA_PMP set to y in your .config?
> 
> 
> Looking at your logs, we can see that port0-port3 all don't have a link:
> [    0.919020] ata7: SATA link down (SStatus 0 SControl 330)
> [    2.787201] ata8: SATA link down (SStatus 0 SControl 330)
> [    3.100522] ata9: SATA link down (SStatus 0 SControl 330)
> [    3.413890] ata10: SATA link down (SStatus 0 SControl 330)
> 
> I looked at your v6.7.xx log as well, and it is the same there.
> 
> So Hans's theory that port0-port3 is each connected to a
> JMB575 Port Multipliers does seem less plausible.
> 
> Because if that was the case, I would expect to see link up on these ports
> and that it detects a PMP class code when probing these ports.
> 
> So I have honestly no idea how this works...
> 
> Perhaps the ASMedia firmware takes the command to port0-port3,
> and instead of sending it to the PMP, it sends back some faked
> reply instead?

Yes I believe that this is what is happening, the physical-ports 0-3
are obviously connected to the JMB575 Port Multipliers, but I believe
the "emulated" ports seen by the OS are mapped like this:

0-3  Only show as connected to the OS is connected directly to a disk
     without a PMP
4-19 Only show as connected to the OS when PMPs are used and the mapped
     port on the PMP has a disk connected

Because of this emulation it does make sense that we cannot reach
the PMPs since ports 0-3 are faked as disconnected when the controller
has detected a PMP. And ports 4-19 map to the ports on the "other side"
of the PMP. So there is no way for the kernel to talk to the upstream
port of the PMP I guess.

> This piece of hardware really seems to do not care at all about
> following specifications...

Ack. I think we should just go back to also probing the emulated
extra ports so as to not regress systems where this was all working
before and then add a module option to allow skipping the emulated
ports to speed-up probing.

Note in other part of the thread it was suggested to make this
speed-up probing option enabled by default. I'm strongly against
enabling this by default. A slow boot is much less of a problem
then systems all of a sudden no longer finding disks.

> Fun fact:
> https://www.asmedia.com.tw/product/A58yQC9Sp5qg6TrF/58dYQ8bxZ4UR9wG5
> Claims that it supports AHCI 1.4.
> That is impressive, especially considering that the latest version
> of AHCI is 1.3.1:
> https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
> 
> I will send an email to some ASMedia developers on the list and see
> if we can get any clarification.

If we can get some insights on how to deal with this from ASMedia
and maybe come up with a better fix that would be great.

So lets hold of on adding the module option.

But can we please drop the problematic quirk to lower the number
of ports for now, to avoid more people getting bitten by this
regression ?

Regards,

Hans



