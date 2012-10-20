From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Sat, 20 Oct 2012 14:00:48 +0200
Message-ID: <20121020120047.GC17563@liondog.tnic>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47259 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab2JTMAv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2012 08:00:51 -0400
Content-Disposition: inline
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Anton V. Boyarshinov" <boyarsh@altlinux.org>, phillip.wood@dunelm.org.uk
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sat, Oct 20, 2012 at 10:19:22AM +0000, bugzilla-daemon@bugzilla.kern=
el.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D49151
>=20
>            Summary: NULL pointer dereference in pata_acpi
>            Product: IO/Storage
>            Version: 2.5
>     Kernel Version: 3.6.2
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: IDE
>         AssignedTo: io_ide@kernel-bugs.osdl.org
>         ReportedBy: phillip.wood@dunelm.org.uk
>         Regression: No
>=20
>=20
> Just upgraded from 3.2.20 to 3.6.2 and when I try to boot a get
>=20
> BUG unable to handle kernel NULL pointer dereference at 00000010
> IP [<efe4c2407>] pacpi_set_dmamode+0x50/0xa0 [pata_acpi]
>=20
> and it wont find my hard disc. I'm using the standard arch linux kern=
el config
> available at
> https://projects.archlinux.org/svntogit/packages.git/tree/trunk/confi=
g?h=3Dpackages/linux
>=20
> I've attached a couple of photos of the message and backtrace

Ok,

let's first switch to mail.

=46WIW, there's another report of this

http://marc.info/?l=3Dlinux-ide&m=3D134995465614435&w=3D2

and it is on 64-bit while Phillip's is 32-bit. Adding Anton and a coupl=
e
more people to CC.

=46rom Anton's disassembly I get:

=C3=84 2.703078=C3=9C Code: 01 00 00 00 f6 43 10 10 74 0a 41 89 c7 43 8=
d 0c 3f 41 d3 e6 41 0f b6 bd e1 02 00 00 e8 ce 74 0f 00 41 80 bd e1 02 =
00 00 3f 77 44 <0f> b7 40 10 41 f7 d6 44 21 73 10 4d 63 ff 42 89 44 fb =
04 48 89
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   01 00                   add    %eax,(%rax)
   2:   00 00                   add    %al,(%rax)
   4:   f6 43 10 10             testb  $0x10,0x10(%rbx)
   8:   74 0a                   je     0x14
   a:   41 89 c7                mov    %eax,%r15d
   d:   43 8d 0c 3f             lea    (%r15,%r15,1),%ecx
  11:   41 d3 e6                shl    %cl,%r14d
  14:   41 0f b6 bd e1 02 00    movzbl 0x2e1(%r13),%edi
  1b:   00=20
  1c:   e8 ce 74 0f 00          callq  0xf74ef
  21:   41 80 bd e1 02 00 00    cmpb   $0x3f,0x2e1(%r13)
  28:   3f=20
  29:   77 44                   ja     0x6f
  2b:*  0f b7 40 10             movzwl 0x10(%rax),%eax     <-- trapping=
 instruction
  2f:   41 f7 d6                not    %r14d
  32:   44 21 73 10             and    %r14d,0x10(%rbx)
  36:   4d 63 ff                movslq %r15d,%r15
  39:   42 89 44 fb 04          mov    %eax,0x4(%rbx,%r15,8)
  3e:   48                      rex.W
  3f:   89                      .byte 0x89

And although I cannot generate the exact code here, building
drivers/ata/pata_acpi.c locally gives only one instruction like the
trapping one (thankfully, function is short enough):

	sall	%cl, %eax	# tmp92, tmp93
	orl	%eax, 16(%rbx)	# tmp93, acpi_6->gtm.flags
	jmp	.L30	#
=2ELVL46:
=2EL29:
	.loc 1 151 0
	movzwl	16(%rax), %eax	# t_12->cycle, t_12->cycle		<---
=2ELVL47:
	.loc 1 152 0
	leal	(%r12,%r12), %ecx	#, tmp97

which could mean that ata_timing_find_mode() might be returning NULL
on those systems (t is in %(r|e)ax in both oopses and the 0x10 offset
points to ata_timing->cycle).

So, Anton, Phillip, can you guys try the following debugging patch
to confirm (it is against mainline but should apply cleanly ontop of
3.6-stable):

---
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 09723b76beac..c5a54faecb98 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -144,6 +144,12 @@ static void pacpi_set_dmamode(struct ata_port *ap,=
 struct ata_device *adev)
=20
 	/* Now stuff the nS values into the structure */
 	t =3D ata_timing_find_mode(adev->dma_mode);
+
+	if (!t) {
+		WARN(1, "%s: ata_timing_find_mode gives NULL\n", __func__);
+		return;
+	}
+
 	if (adev->dma_mode >=3D XFER_UDMA_0) {
 		acpi->gtm.drive[unit].dma =3D t->udma;
 		acpi->gtm.flags |=3D (1 << (2 * unit));
--

Thanks.

--=20
Regards/Gruss,
    Boris.
