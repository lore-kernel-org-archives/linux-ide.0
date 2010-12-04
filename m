From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: AT91 IDE module
Date: Sat, 4 Dec 2010 21:16:55 +0100
Message-ID: <20101204201655.GA2913@r2bh72.net.upc.cz>
References: <4CEB8FB8.80702@tcz.cz>
 <20101123210054.GA4164@r2bh72.net.upc.cz>
 <4CECDCA5.2060106@tcz.cz>
 <20101124215056.GA2167@r2bh72.net.upc.cz>
 <20101125215319.8uxphaqc0cwo048s@mail.tcz.cz>
 <20101126182045.GA3404@r2bh72.net.upc.cz>
 <4CF7C4ED.6070400@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.8]:20963 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab0LDUTR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Dec 2010 15:19:17 -0500
Content-Disposition: inline
In-Reply-To: <4CF7C4ED.6070400@tcz.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Radovan =?iso-8859-1?Q?V=E1pen=EDk?= <radovan.vapenik@tcz.cz>
Cc: linux-ide@vger.kernel.org

On Thu, Dec 02, 2010 at 05:10:21PM +0100, Radovan V=E1pen=EDk wrote:
> I had mistake in schematic - after repair I get some new debug
> messages - is possible to tell, what can be wrong? Thanks for advice

Unfortunately I don't know where the problem can be.

> at91_ide_probe chipselect 4 irq 132 res 50000000
> apply_timings t0=3D600 t1=3D70 t2=3D290 t6z=3D30
> apply_timings mck_hz=3D99328000
> apply_timings cycle=3D60 setup=3D7 pulse=3D29 data_float=3D3
> Probing IDE interface ide0...
> probing for hda: present=3D0, media=3D32, probetype=3DATA
> probing for hda: present=3D0, media=3D32, probetype=3DATAPI
> hda: probing with STATUS(0xa0) instead of ALTSTATUS(0x00)

Strange that here alt status is 0x00 and in other places it is 0x1e.
Also all bits in alt status except second one should be the same as in
status register. First version of driver had bug where address of alt
status was wrong, but that was fixed before driver was merged into
the kernel.

> hda: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)
> probing for hdb: present=3D0, media=3D32, probetype=3DATA
> probing for hdb: present=3D0, media=3D32, probetype=3DATAPI
> hdb: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)
> hdb: probing with STATUS(0xa0) instead of ALTSTATUS(0x1e)

Status 0xa0 shows that BUSY bit is set, that definitely is wrong too.

Stanislaw
