From: Tejun Heo <tj@kernel.org>
Subject: Re: Crash with sata_sil24 driver
Date: Wed, 23 Nov 2011 17:48:47 -0800
Message-ID: <CAOS58YPM29xi4Jq5L16fjDQDRzv-yc67tp_yqSwoiFBBbtCZkw@mail.gmail.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
	<20111123144735.64dc9f05@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111123144735.64dc9f05@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-ide@vger.kernel.org

Hello,

On Wed, Nov 23, 2011 at 2:47 PM, Jesse Barnes <jbarnes@virtuousgeek.org=
> wrote:
>> Weird, that basically means that somehow pci_iomap() isn't
>> synchronous. =A0ie. you need to way some time after pci_iomap() befo=
re
>> being able to access the mapped address. =A0Seems like arch / pci
>> weirdness. =A0Jesse, Russell, any ideas?
>
> As Russel said, pci_iomap shouldn't be async. =A0But maybe something =
else
> in the init function is doing a chip reset or causing the chip to go
> off into the weeds for a short time? =A0That's generally the cause of
> target timeouts for PCI devices.

Yeah, that's much more plausible. Weird that it doesn't happen on x86
tho. Maybe different timeouts? Pratyush, can you look at bus trace and
see what's going on?

Thanks.

--=20
tejun
