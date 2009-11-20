From: Zeno Davatz <zdavatz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Bug #14622] Second IDE device not found
Date: Fri, 20 Nov 2009 14:35:07 +0100
Message-ID: <40a4ed590911200535j2fe970fas3db14492c4c30b9d@mail.gmail.com>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>
	 <xXQGFmujPl.A.n7F.4SdALB@chimera>
	 <20091119.120550.183823935.davem@davemloft.net>
	 <40a4ed590911192359o563b104fo562f325ad9f5358e@mail.gmail.com>
	 <4B065648.6040609@garzik.org>
	 <40a4ed590911200129p6f0d048dqef10df2b311d4744@mail.gmail.com>
	 <4B067E1A.7000102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B067E1A.7000102-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Fri, Nov 20, 2009 at 12:31 PM, Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org> wrote:

> I use minicom and a null modem serial cable. =A0One of minicom's comm=
ands will
> capture everything sent to the serial port, to a file. =A0Other optio=
ns are
> available. =A0Googling for "linux serial console" found several usefu=
l
> starting-point links.
>
> The basic idea is to sent console output to a serial port, and then h=
ave
> some method of reading and capturing the serial port's data.
>
> Another alternative is netconsole (google for "linux netconsole"), wh=
ich
> permits output over the network.

Ok, I will try to look into this.

> Well, this goes back to David's basic request: =A0IDE-only or ATA-onl=
y.

I find it a bit irritating, that CONFIG_IDE is mentioned as ATA in
make menuconfig. But I'm trying to understand your point.

> You really, really, really should not to enable both at the same time=
=2E

I recompiled the kernel only with below settings all enabled.

> If you are choosing ATA-only (libata), then you should disable CONFIG=
_IDE
> and everything associated with CONFIG_IDE, including CONFIG_BLK_DEV_S=
VWKS.

I disabled CONFIG_IDE this time.

> libata will want something like
> CONFIG_ATA
> CONFIG_ATA_VERBOSE_ERROR =A0 =A0 =A0 =A0<-- optional, but helpful
> CONFIG_PATA_SERVERWORKS
>
> CONFIG_SCSI
> CONFIG_SCSI_LOGGING =A0 =A0 =A0 =A0 =A0 =A0 <-- ditto
> CONFIG_SCSI_CONSTANTS =A0 =A0 =A0 =A0 =A0 <-- ditto
> CONFIG_BLK_DEV_SD
> CONFIG_BLK_DEV_SR =A0 =A0 =A0 =A0 =A0 =A0 =A0 <-- required only for C=
D-ROM support

Recompiled with above enabled. And indeed: It worked. Booting as normal=
=2E

Thank you for the detailed instructions.

Best
Zeno
