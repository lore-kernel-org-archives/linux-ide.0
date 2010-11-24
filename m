From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: AT91 IDE module
Date: Wed, 24 Nov 2010 22:50:56 +0100
Message-ID: <20101124215056.GA2167@r2bh72.net.upc.cz>
References: <4CEB8FB8.80702@tcz.cz>
 <20101123210054.GA4164@r2bh72.net.upc.cz>
 <4CECDCA5.2060106@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx3.wp.pl ([212.77.101.7]:46808 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab0KXVrW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Nov 2010 16:47:22 -0500
Content-Disposition: inline
In-Reply-To: <4CECDCA5.2060106@tcz.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Radovan =?iso-8859-1?Q?V=E1pen=EDk?= <radovan.vapenik@tcz.cz>
Cc: linux-ide@vger.kernel.org

On Wed, Nov 24, 2010 at 10:36:37AM +0100, Radovan V=E1pen=EDk wrote:
> at91_ide_probe chipselect 4 irq 132 res 50000000
> apply_timings t0=3D600 t1=3D70 t2=3D290 t6z=3D30
> apply_timings mck_hz=3D99328000
> apply_timings cycle=3D60 setup=3D7 pulse=3D29 data_float=3D3
> Probing IDE interface ide0...
> probing for hda: present=3D0, media=3D32, probetype=3DATA
> probing for hda: present=3D0, media=3D32, probetype=3DATAPI
> probing for hdb: present=3D0, media=3D32, probetype=3DATA
> probing for hdb: present=3D0, media=3D32, probetype=3DATAPI
> ide0 at 0xc4866000-0xc4866007,0xc486e006 on irq 132

We do not detect any IDE device, registers do not contain status/data
that IDE layer expect. As far only two possible reasons of that
problem come in mind:
- board specific code does not reset CF device (with proper
  reset duration?). This is expected, there is rst_pin in
  struct at91_cf_data but driver does not use it
- CF 9 pin (ATA SEL) is not grounded or set to 0 if connected
  to controller (also in board specific initialization code)

To debug problem further, you can add your own code at the end of
at91_ide_probe(), which read/write IDE register to see if device
react properly and give some sensible status values.

Stanislaw
