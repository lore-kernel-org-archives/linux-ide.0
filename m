From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [2.6.30.5] Diagnosing an IDE lockup with SMART long tests
Date: Wed, 2 Sep 2009 18:24:17 -0600
Message-ID: <51f3faa70909021724v45d2902ewdb10d5f4a188f2be@mail.gmail.com>
References: <6661.1251822466@nice.ram.loc> <4A9DF3E9.9090309@gmail.com>
	 <20090902111927.GA4590@chram.org>
	 <51f3faa70909020742g19007084j19a0ed071aaeffdf@mail.gmail.com>
	 <20090902145225.GA16359@chram.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:61508 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbZICAYS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Sep 2009 20:24:18 -0400
In-Reply-To: <20090902145225.GA16359@chram.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raphael Manfredi <Raphael_Manfredi@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Sep 2, 2009 at 8:52 AM, Raphael
Manfredi<Raphael_Manfredi@pobox.com> wrote:
> Quoting Robert Hancock:
> : Can you post what particular command you're running to run the SMAR=
T
> : test, and also the full dmesg output from bootup? Also CCing
> : linux-ide.
>
> Sure, I'm using:
>
> =A0 =A0 =A0 =A0smartctl -t long /dev/sda
>
> to launch the SMART test.
>
> Here's the requested dmesg output:

Is it always this drive that's failing? I see there's a second of the
same model, does it show the same behavior?

> ata1.00: ATA-6: HDS722512VLAT80, V33OA60A, max UDMA/100
> ata1.00: 241254720 sectors, multi 16: LBA48

If only that particular drive shows this problem, then I would start
to suspect a hardware fault with that drive. The fact that it fails
with both IDE and libata (and with ata_piix, which is a really
commonly used and tested libata driver) rather points in that
direction. Errors normally shouldn't lock up the machine, except that
if the drive is doing bad things with IORDY for example, it can
basically stall the machine forever and there's nothing the kernel can
do about it..
