From: "Stoyan Gaydarov" <stoyboyker@gmail.com>
Subject: Re: ata error
Date: Fri, 25 Jul 2008 14:26:52 -0500
Message-ID: <6d291e080807251226l3af4fd78m85de6e2122dac682@mail.gmail.com>
References: <6d291e080807251143k6cfc6db1w4e024ac245187d48@mail.gmail.com>
	 <6d291e080807251147n14b0f0d1g4c8ad1d4759c702b@mail.gmail.com>
	 <20080725195618.5f09c3bf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:9633 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbYGYT0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jul 2008 15:26:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1310547nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 25 Jul 2008 12:26:52 -0700 (PDT)
In-Reply-To: <20080725195618.5f09c3bf@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 25, 2008 at 1:56 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > [ 1078.735322] ata3.00: configured for UDMA/133
>> > [ 1078.735336] ata3: EH complete
>> > [ 1078.766066] sd 2:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
>
> We timed out, reset the drive and it came back.
>> > [ 1078.766442] sd 2:0:0:0: [sda] Write Protect is off
>> > [ 1078.766448] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> > [ 1078.766957] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
>> > enabled, doesn't support DPO or FUA
>> > [ 1107.310768] [drm] Loading R300 Microcode
>
> I notice there is a drm Loading R300 Microcode logged just before each
> drive failure. That seems very suspicious to me. Does it ever occur if
> you are not in X ?

I don't know but I can try it, later today.
What is happening is that the movie I am watching with vlc (stored on
the drive) stops playing and then the dmesg error comes up, and then
it ether freezes X which it did a couple of times but I didnt get the
dmesg because it was frozen and i wasnt expecting it, or I just need
to restart the movie and it plays again(the error stuff mentioned in
the dmesg above). Is there any other info I can provide you with?

-Stoyan G

>
