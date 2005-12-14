From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH RESEND] via82cxxx IDE: Add VT8251 ISA bridge
Date: Wed, 14 Dec 2005 22:19:05 +0100
Message-ID: <58cb370e0512141319q2ce4bd9as510b3b353beb78b@mail.gmail.com>
References: <43988D11.80809@gentoo.org> <43989AB9.60203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964990AbVLNVTJ@vger.kernel.org>
In-Reply-To: <43989AB9.60203@pobox.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Drake <dsd@gentoo.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

applied

On 12/8/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Daniel Drake wrote:
> > Some motherboards (such as the Asus P5V800-MX) ship a
> > PCI_DEVICE_ID_VIA_82C586_1 IDE controller alongside a VT8251 southbridge.
> >
> > This southbridge is currently unrecognised in the via82cxxx IDE driver,
> > preventing those users from getting DMA access to disks.
> >
> > Signed-off-by: Daniel Drake <dsd@gentoo.org>
> >
> > --
> >
> > Bart, I submitted this 2 weeks ago but sent it to your old pw.edu.pl
> > address by accident. Sorry about that!
>
> ACK.
>
> VIA sent me the same patch, privately.
