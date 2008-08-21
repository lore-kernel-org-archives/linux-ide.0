From: echo6 <echo6_uk@yahoo.com>
Subject: Re: sata_inic162x
Date: Thu, 21 Aug 2008 19:00:17 +0100
Message-ID: <48ADAD31.90001@yahoo.com>
References: <48AD9EAD.1010204@yahoo.com> <20080821175240.6099c205@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060806040907070609000700"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n10.bullet.re3.yahoo.com ([68.142.237.123]:25982 "HELO
	n10.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753369AbYHUSC7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2008 14:02:59 -0400
In-Reply-To: <20080821175240.6099c205@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------060806040907070609000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox wrote:
|> I also have custom compiled kernel using 2.6.26, on that the moment I
|> shove the sata pcmcia card into my laptop the system freezes.
|
| If you boot with the "irqpoll" option does it get further ?
|

On the 2.6.26 kernel, system still freezes.
On  2.6.24-19-generic;

[   30.507816] sata_inic162x 0000:04:00.0: version 0.3
[   30.507871] PCI: Enabling device 0000:04:00.0 (0000 -> 0003)
[   30.507984] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 21 (level,
low) -> IRQ 18
[   30.508198] ACPI: PCI interrupt for device 0000:04:00.0 disabled
[   30.508300] sata_inic162x: probe of 0000:04:00.0 failed with error -22

I should also point out that with the 2.6.26 kernel the system only
freezes when I connect an external e-SATA drive.  I've attached the
message log of the output result of me physically removing the pcmcia
card re-inserting it and attaching the external drive.

Jon.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIra0xbSv1saVS9ucRAtMNAJ9HjCazvooFxnNkV9nnQzd5MS04XgCdF8l4
+e96wwUBhe+4EOWtxyp1TaM=
=T44h
-----END PGP SIGNATURE-----

--------------060806040907070609000700
Content-Type: text/plain;
 name="message.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="message.log"


Aug 21 18:53:59 toshiba kernel: [  112.265826] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.265911] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.266788] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.266836] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.267758] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.267798] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.268773] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.268811] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.269482] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.269482] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.269482] pccard: card ejected from =
slot 0
Aug 21 18:53:59 toshiba kernel: [  112.270043] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.270078] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.271055] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.271088] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.271197] ata4: hard resetting link
Aug 21 18:53:59 toshiba kernel: [  112.272033] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.272075] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.273033] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.273066] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.273228] ata3: hard resetting link
Aug 21 18:53:59 toshiba kernel: [  112.274616] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.274705] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.275706] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.275773] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.276752] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.276836] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.277838] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.277857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.278832] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.278857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.279853] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.279857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.280835] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.280857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.281855] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.281855] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.282836] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.282855] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.283857] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.283857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.284839] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.284856] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.285856] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.285857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.286843] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.286857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.287857] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.287857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.288855] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.288857] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.289840] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.289855] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.290855] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.290855] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.291099] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.291185] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.292182] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.292257] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  112.293242] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:53:59 toshiba kernel: [  11t: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0=
xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xf=
t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_=
stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq=
_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0t: cmd=3D0xff irq_stat=3D0xft=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_st=
at=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0=
xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
ft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq=
_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xft: c
Aug 21 18:53:59 toshiba kernel: d=3D0xff irq_stat=3Dt: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff=
 irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: c=
md=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff=
 irq_stat=3D0xft: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=3D0xft: cm=
d=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff=
 irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: c=
md=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=
=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xf=
f irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0t: cmd=3D0xff=
 irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: =
cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0
Aug 21 18:53:59 toshiba kernel: : cmd=3D0xff irq_statt: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xf=
f irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: =
cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_st=
at=3D0xff idma_stat=3D0t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff i=
rq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=
=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3D0xft: cmdt: cmd=3D0xff irq_stat=3D0t: cmd=3D0=
xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0t: cmd=3D0xt: cmd=3D0x=
ft: cmd=3D0xff irq_stat=3D0t: cmd=3D0xff irq_stat=3D0t: cmd=3D0xff irq_st=
at=3D0xft: cmd=3D0xff irq_statt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff ir=
q_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xft: cmd=3D0xff
Aug 21 18:53:59 toshiba kernel: _t: cmd=3D0xfft: cmd=3D0xff irq_stat=3D0x=
ft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_=
stat=3D0t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff it: cmd=3D0xff irq_stat=
=3Dt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff ir=
q_stat=3D0t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irt: cmd=3D0xff irq_stat=3D=
0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff ir=
q_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=
=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D=
0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq=
_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
ft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq=
_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xft: c
Aug 21 18:53:59 toshiba kernel: xfft: cmd=3D0xff irq_stat=3D0t: cmd=3D0xf=
f irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_st=
at=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0=
xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_=
stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_=
stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0=
xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq=
_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cm
Aug 21 18:53:59 toshiba kernel: ft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff=
 irq_stat=3D0xt: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
ft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq=
_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_s=
tat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_s=
tat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0=
xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0=
xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_=
stat=3D0xt: cmd=3D0xff i
Aug 21 18:53:59 toshiba kernel: tt: cmd=3D0xff irq_st: cmd=3D0xff irq_sta=
t=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0=
xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_st=
at=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0=
xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
f idma_stat=3D0t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: =
cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: =
cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0=
xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0=
xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0x=
ft: cmd=3D0xff irq_stat=3D0
Aug 21 18:53:59 toshiba kernel: cmd=3D0t: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xff idma_stat=3Dt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff =
irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0t: cmd=3D0xff irq_stat=3D0xft: cmd=
=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_=
stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
ft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_=
stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xff idma_stat=3D0t: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xf=
f irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0=
xff irq_stat=3D0xft: cmd
Aug 21 18:53:59 toshiba kernel: f it: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff=
 irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: c=
md=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=
=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff=
 irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: =
cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_s=
tat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_st=
at=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xff idma_sta=
t=3D0xt: cmd=3D0xff irq_sta
Aug 21 18:53:59 toshiba kernel: ft: cmd=3D0xft: cmd=3D0xff irq_stat=3D0xt=
: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xft: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0x=
t: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq=
_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D=
0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0x=
fft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff i=
rq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=
=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff i=
rq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cm=
d=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xf=
f irq_stat=3D0xft: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=3D0xft: c=
md=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_
Aug 21 18:53:59 toshiba kernel: =3Dt: cmd=3D0xff irqt: cmd=3D0xff irq_sta=
t=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft:=
 cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xft:=
 cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_s=
tat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D=
0xff irq_stat=3D0xff idma_statt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff i=
rq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=
=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D=
0xft: cmd=3D0xff irq_stat=3Dt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq=
_stat=3D0xt: cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xt: cmd=3D0xff irq_s=
tat=3D0xt: cmd=3D0xff irq_statt: cmd=3D0xff irq_stat: cmd=3D0xff irq_stat=
=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xf=
f irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: =
cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_sta=
t=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xf=
f irq_stat=3D0xt: cmd=3D0
Aug 21 18:54:00 toshiba kernel: it: cmd=3D0xff irq_stt: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt:=
 cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_sta=
t=3D0xft: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft:=
 cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_st=
at=3D0xt: cmd=3D0xff irq_stat=3D0xft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0x=
ff irq_stat=3D0xfft: cmd=3D0xff irq_stat=3D0xt: cmd=3D0xff irq_stat=3D0xf=
ft: cmd=3D0xff irq_stat=3D0xf interrupt: cmd=3D0xff ir interrupt: cmd=3D0=
xff ir interrupt: cmd=3D0xff irqatf  a[  112.815996] ata3: unhandled inte=
rrupt: cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.816058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.816994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.817036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.817992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.818058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.818996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.819078] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.819991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.820055] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.820995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.821080] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.822001] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.822064] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.822992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.823077] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.823997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.824062] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.824990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.825035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.825992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.826035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.826992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.827032] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.828010] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.828072] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.828996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.829039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.830005] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.830069] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.831019] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.831059] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.832069] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.832109] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.832997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.833035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.833991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.834035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.834996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.835061] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.835994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.836078] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.836996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.837060] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.838015] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.838099] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.838998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.839038] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.839991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.840076] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.840999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.841060] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.841998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.842038] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.842998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.843083] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.843998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.844039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.844992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.845025] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.845991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.846055] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.846995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.847080] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.848004] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.848060] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.848988] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.849042] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.849997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.850061] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.850993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.851039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.852006] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.852069] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.853022] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.853106] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.853997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.854037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.854990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.855034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.855992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.856035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.856989] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.857035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.857992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.858054] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.858994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.859079] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.859995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.860037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.860989] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.861034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.861994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.862060] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.862999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.863085] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.863994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.864036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.864993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.865035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.865992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.866033] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.866987] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.867032] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.867991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.868054] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.868995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.869037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.869993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.870056] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.870991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.871036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.872015] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.872099] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.872996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.873058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.873996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.874039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.874995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.875062] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.876014] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.876098] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.876999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.877039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.877990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.878076] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.879004] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.879066] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.879999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.880085] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.881011] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.881075] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.882005] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.882062] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.883009] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.883072] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.884067] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.884107] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.885014] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.885079] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.886004] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.886053] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.887011] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.887072] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.887994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.888037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.888993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.889031] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.889989] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.890033] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.890992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.891032] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.891987] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.892073] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.893003] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.893065] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.893998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.894080] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.894995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.895078] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.895999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.896061] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.896992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.897037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.898012] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.898095] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.898992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.899058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.899990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.900035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.900992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.901057] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.901992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.902036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.902996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.903037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.903990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.904034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.904991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.905056] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.905993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.906079] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.906996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.907058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.908001] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.908045] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.908994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.909056] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.909993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.910037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.910994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.911036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.912017] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.912057] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.912999] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.913061] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.913994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.914034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.914992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.915036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.916002] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.916066] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.916992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.917036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.917998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.918038] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.918990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.919036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.919994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.920035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.920992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.921035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.921993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.922055] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.922993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.923036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.923992] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.924078] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.924994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.925058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.925995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.926040] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.926993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.927035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.927996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.928082] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.929003] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.929044] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.929995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.930039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.931009] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.931074] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.931995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.932081] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.932996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.933060] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.933997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.934040] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.935008] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.935069] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.936017] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.936107] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.937147] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.937191] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.937991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.938035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.939004] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.939067] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.939987] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.940073] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.941010] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.941075] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.942014] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.942054] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.943022] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.943065] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.943995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.944079] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.945001] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.945064] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.946005] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.946090] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.947015] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.947057] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.948022] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.948106] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.948998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.949035] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.949993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.950036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.951005] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.951070] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.951991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.952076] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.953007] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.953068] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.954035] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.954075] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.955000] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.955061] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.956244] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.956343] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.957217] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.957287] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.958271] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.958355] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.959361] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.959421] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.960426] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.960466] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.961021] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.961088] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.961996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.962040] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.962997] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.963058] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.964016] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.964056] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.965004] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.965066] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.965996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.966040] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.966996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.967036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.968015] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.968099] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.968994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.969059] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.970021] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.970105] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.970995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.971038] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.971986] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.972031] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.973012] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.973096] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.974103] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.974175] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.975006] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.975091] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.975996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.976082] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.977001] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.977042] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.977994] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.978081] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.979000] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.979062] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.979993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.980077] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.981023] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.981105] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.981996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.982065] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.982991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.983036] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.983991] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.984057] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.985019] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.985105] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.986009] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.986075] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.987020] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.987104] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.987996] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.988037] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.988993] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.989079] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.990005] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.990067] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.990989] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.991072] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.992015] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.992080] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.993017] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.993100] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.993998] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.994039] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.994989] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.995034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.995995] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.996033] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.996990] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.997034] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.998710] ata4: SATA link down (SSta=
tus FFFFFFFF SControl FFFFFFFF)
Aug 21 18:54:00 toshiba kernel: [  112.998710] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.998745] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.999699] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  112.999766] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.000698] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.000741] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.001655] ata3: SATA link down (SSta=
tus FFFFFFFF SControl FFFFFFFF)
Aug 21 18:54:00 toshiba kernel: [  113.001694] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.001734] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.001743] ata3: EH complete
Aug 21 18:54:00 toshiba kernel: [  113.002899] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.002935] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.003898] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.003931] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.003898] ata4: EH complete
Aug 21 18:54:00 toshiba kernel: [  113.004829] ata3: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.004864] ata4: unhandled interrupt:=
 cmd=3D0xff irq_stat=3D0xff idma_stat=3D0xffff
Aug 21 18:54:00 toshiba kernel: [  113.005219] ACPI: PCI interrupt for de=
vice 0000:04:00.0 disabled
Aug 21 18:54:06 toshiba kernel: [  119.297992] pccard: CardBus card inser=
ted into slot 0
Aug 21 18:54:06 toshiba kernel: [  119.299148] sata_inic162x 0000:04:00.0=
: enabling device (0000 -> 0003)
Aug 21 18:54:06 toshiba kernel: [  119.299179] ACPI: PCI Interrupt 0000:0=
4:00.0[A] -> GSI 21 (level, low) -> IRQ 21
Aug 21 18:54:06 toshiba kernel: [  119.310360] scsi4 : sata_inic162x
Aug 21 18:54:06 toshiba kernel: [  119.311852] scsi5 : sata_inic162x
Aug 21 18:54:06 toshiba kernel: [  119.312042] ata5: SATA max UDMA/133 mm=
io m4096@0x8c420000 port 0x8c420000 irq 21
Aug 21 18:54:06 toshiba kernel: [  119.312061] ata6: SATA max UDMA/133 mm=
io m4096@0x8c420000 port 0x8c420040 irq 21
Aug 21 18:54:06 toshiba kernel: [  119.626008] ata5: SATA link down (SSta=
tus 0 SControl 300)
Aug 21 18:54:06 toshiba kernel: [  119.938406] ata6: SATA link down (SSta=
tus 0 SControl 300)

--------------060806040907070609000700--

