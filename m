From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Regression: my systems can no longer boot from an ide hard drive
Date: Wed, 24 Mar 2010 17:47:22 -0600
Message-ID: <51f3faa71003241647l17d41171r7f2e4f1e6b773099@mail.gmail.com>
References: <201003230801.o2N81UKg009750@alien.loup.net>
	 <20100323091718.5a57b6e1.randy.dunlap@oracle.com>
	 <4BA95AD1.2090906@gmail.com>
	 <201003240046.o2O0kvHU010541@alien.loup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:42616 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0CXXrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2010 19:47:23 -0400
Received: by iwn6 with SMTP id 6so3063389iwn.4
        for <linux-ide@vger.kernel.org>; Wed, 24 Mar 2010 16:47:22 -0700 (PDT)
In-Reply-To: <201003240046.o2O0kvHU010541@alien.loup.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hayward <hayward@loup.net>
Cc: randy.dunlap@oracle.com, linux-ide@vger.kernel.org

On Tue, Mar 23, 2010 at 6:46 PM, Mike Hayward <hayward@loup.net> wrote:
> =A0> Most likely the IDE drive isn't being detected properly, but we =
need
> =A0> more info on the hardware. Can you post the dmesg output from bo=
otup
> =A0> with a working kernel? (If you can, the boot messages from the o=
nes that
> =A0> fail to boot would be ideal. For the Fedora one, you can edit th=
e kernel
> =A0> command line in grub and take the "quiet" off the end to see mor=
e of
> =A0> them on the screen, any ata output would be useful..)
>
> Ok, here goes with a working ubuntu system. =A0Getting logs from fail=
ed
> to boot systems is a challenge; none of the Fedora logs had anything
> obvious to me at the tail but I couldn't review them all. =A0Systems =
are
> production so I couldn't keep offline after weekend.
>
> This is from literally the same exact installation process except to =
a
> different drive. =A0The ide hard drive works just fine after booting
> from sata. =A0Hopefully boot messages can help. =A0Any ideas why Ubun=
tu
> didn't even bring up grub when pressing keys? =A0I am not so familiar
> with it, but guessing boot loader wedged before kernel bootstrap.

This one looks normal.. so it only fails if you actually boot from the
IDE drive? That's a bit odd. What if you boot from a Fedora install
disc in rescue mode - can it see the drive then?

I'm not too familiar with the Ubuntu boot process - it could be the
kernel messages are set up to be so quiet you don't get any output
even if it can't mount the root file system, etc.
