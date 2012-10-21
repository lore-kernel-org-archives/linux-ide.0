From: Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Sun, 21 Oct 2012 17:04:12 +0100
Message-ID: <50841CFC.2030802@talktalk.net>
References: <bug-49151-11633@https.bugzilla.kernel.org/> <20121020120047.GC17563@liondog.tnic>
Reply-To: phillip.wood@dunelm.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:48213 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752397Ab2JUQOA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2012 12:14:00 -0400
In-Reply-To: <20121020120047.GC17563@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Anton V. Boyarshinov" <boyarsh@altlinux.org>, phillip.wood@dunelm.org.uk, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 10/20/2012 01:00 PM, Borislav Petkov wrote:
> On Sat, Oct 20, 2012 at 10:19:22AM +0000, bugzilla-daemon@bugzilla.ke=
rnel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D49151
>>
>>             Summary: NULL pointer dereference in pata_acpi
>>             Product: IO/Storage
>>             Version: 2.5
>>      Kernel Version: 3.6.2
>>            Platform: All
>>          OS/Version: Linux
>>                Tree: Mainline
>>              Status: NEW
>>            Severity: normal
>>            Priority: P1
>>           Component: IDE
>>          AssignedTo: io_ide@kernel-bugs.osdl.org
>>          ReportedBy: phillip.wood@dunelm.org.uk
>>          Regression: No
>>
>>
>> Just upgraded from 3.2.20 to 3.6.2 and when I try to boot a get
>>
>> BUG unable to handle kernel NULL pointer dereference at 00000010
>> IP [<efe4c2407>] pacpi_set_dmamode+0x50/0xa0 [pata_acpi]
>>
>> and it wont find my hard disc. I'm using the standard arch linux ker=
nel config
>> available at
>> https://projects.archlinux.org/svntogit/packages.git/tree/trunk/conf=
ig?h=3Dpackages/linux
>>
>> I've attached a couple of photos of the message and backtrace
>
> Ok,
>
> let's first switch to mail.
>
> FWIW, there's another report of this
>
> http://marc.info/?l=3Dlinux-ide&m=3D134995465614435&w=3D2
>
> and it is on 64-bit while Phillip's is 32-bit. Adding Anton and a cou=
ple
> more people to CC.
>
>  From Anton's disassembly I get:
>
> =C3=84 2.703078=C3=9C Code: 01 00 00 00 f6 43 10 10 74 0a 41 89 c7 43=
 8d 0c 3f 41 d3 e6 41 0f b6 bd e1 02 00 00 e8 ce 74 0f 00 41 80 bd e1 0=
2 00 00 3f 77 44 <0f> b7 40 10 41 f7 d6 44 21 73 10 4d 63 ff 42 89 44 f=
b 04 48 89
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>     0:   01 00                   add    %eax,(%rax)
>     2:   00 00                   add    %al,(%rax)
>     4:   f6 43 10 10             testb  $0x10,0x10(%rbx)
>     8:   74 0a                   je     0x14
>     a:   41 89 c7                mov    %eax,%r15d
>     d:   43 8d 0c 3f             lea    (%r15,%r15,1),%ecx
>    11:   41 d3 e6                shl    %cl,%r14d
>    14:   41 0f b6 bd e1 02 00    movzbl 0x2e1(%r13),%edi
>    1b:   00
>    1c:   e8 ce 74 0f 00          callq  0xf74ef
>    21:   41 80 bd e1 02 00 00    cmpb   $0x3f,0x2e1(%r13)
>    28:   3f
>    29:   77 44                   ja     0x6f
>    2b:*  0f b7 40 10             movzwl 0x10(%rax),%eax     <-- trapp=
ing instruction
>    2f:   41 f7 d6                not    %r14d
>    32:   44 21 73 10             and    %r14d,0x10(%rbx)
>    36:   4d 63 ff                movslq %r15d,%r15
>    39:   42 89 44 fb 04          mov    %eax,0x4(%rbx,%r15,8)
>    3e:   48                      rex.W
>    3f:   89                      .byte 0x89
>
> And although I cannot generate the exact code here, building
> drivers/ata/pata_acpi.c locally gives only one instruction like the
> trapping one (thankfully, function is short enough):
>
> 	sall	%cl, %eax	# tmp92, tmp93
> 	orl	%eax, 16(%rbx)	# tmp93, acpi_6->gtm.flags
> 	jmp	.L30	#
> .LVL46:
> .L29:
> 	.loc 1 151 0
> 	movzwl	16(%rax), %eax	# t_12->cycle, t_12->cycle		<---
> .LVL47:
> 	.loc 1 152 0
> 	leal	(%r12,%r12), %ecx	#, tmp97
>
> which could mean that ata_timing_find_mode() might be returning NULL
> on those systems (t is in %(r|e)ax in both oopses and the 0x10 offset
> points to ata_timing->cycle).
>
> So, Anton, Phillip, can you guys try the following debugging patch
> to confirm (it is against mainline but should apply cleanly ontop of
> 3.6-stable):
>
> ---
> diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
> index 09723b76beac..c5a54faecb98 100644
> --- a/drivers/ata/pata_acpi.c
> +++ b/drivers/ata/pata_acpi.c
> @@ -144,6 +144,12 @@ static void pacpi_set_dmamode(struct ata_port *a=
p, struct ata_device *adev)
>
>   	/* Now stuff the nS values into the structure */
>   	t =3D ata_timing_find_mode(adev->dma_mode);
> +
> +	if (!t) {
> +		WARN(1, "%s: ata_timing_find_mode gives NULL\n", __func__);
> +		return;
> +	}
> +
>   	if (adev->dma_mode >=3D XFER_UDMA_0) {
>   		acpi->gtm.drive[unit].dma =3D t->udma;
>   		acpi->gtm.flags |=3D (1 << (2 * unit));
> --
>
> Thanks.
>
Hi Borislav

Thanks for responding to the bug report so quickly. I've applied your=20
patch and the kernel now finds my hard drive and the logs (pasted below=
)=20
have a couple of warnings generated by the patch. So if I've understood=
=20
correctly then your theory that ata_timing_find_mode() is returning NUL=
L=20
is correct.

Thanks for looking into this, just let me know if you want me to do=20
anything else

Best Wishes

Phillip


  [    1.932509] ------------[ cut here ]------------
  [    1.932509] WARNING: at drivers/ata/pata_acpi.c:149=20
pacpi_set_dmamode+0xc7/0xe0 [pata_acpi]()
  [    1.932509] Hardware name: Portable PC
  [    1.932509] pacpi_set_dmamode: ata_timing_find_mode gives NULL
  [    1.932509] Modules linked in: pata_acpi ata_generic
  [    1.932509] Pid: 857, comm: scsi_eh_0 Not tainted 3.6.0-1-custom #=
1
  [    1.932509] Call Trace:
  [    1.932509]  [<c102cd28>] ? warn_slowpath_common+0x78/0xb0
  [    1.932509]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    1.932509]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    1.932509]  [<c102cdf3>] ? warn_slowpath_fmt+0x33/0x40
  [    1.932509]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    1.932509]  [<ef77e375>] ? pacpi_qc_issue+0x45/0x64 [pata_acpi]
  [    1.932509]  [<c126dfb2>] ? ata_qc_issue+0x152/0x320
  [    1.932509]  [<c140d1bd>] ? schedule_timeout+0xed/0x170
  [    1.932509]  [<c126e3c9>] ? ata_exec_internal_sg+0x249/0x510
  [    1.932509]  [<c127d2d0>] ? ata_release_transport+0x40/0x40
  [    1.932509]  [<c1039145>] ? msleep+0x15/0x20
  [    1.932509]  [<c126e6f2>] ? ata_exec_internal+0x62/0xa0
  [    1.932509]  [<c126e755>] ? ata_do_dev_read_id+0x25/0x30
  [    1.932509]  [<c126ea35>] ? ata_dev_read_id+0x245/0x560
  [    1.932509]  [<c127af72>] ? ata_eh_recover+0x762/0x1270
  [    1.932509]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    1.932509]  [<ef77e180>] ? pacpi_port_start+0x80/0x80 [pata_acpi]
  [    1.932509]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    1.932509]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    1.932509]  [<c127c490>] ? ata_do_eh+0x40/0xb0
  [    1.932509]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    1.932509]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    1.932509]  [<ef77e180>] ? pacpi_port_start+0x80/0x80 [pata_acpi]
  [    1.932509]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    1.932509]  [<c127ec77>] ? ata_sff_error_handler+0xb7/0x120
  [    1.932509]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    1.932509]  [<c127bfc5>] ? ata_scsi_port_error_handler+0x495/0x86=
0
  [    1.932509]  [<c127ece0>] ? ata_sff_error_handler+0x120/0x120
  [    1.932509]  [<c127c413>] ? ata_scsi_error+0x83/0xc0
  [    1.932509]  [<c125533c>] ? scsi_error_handler+0x8c/0x470
  [    1.932509]  [<c104f6b4>] ? __wake_up_common+0x44/0x70
  [    1.932509]  [<c12552b0>] ? scsi_eh_get_sense+0xd0/0xd0
  [    1.932509]  [<c12552b0>] ? scsi_eh_get_sense+0xd0/0xd0
  [    1.932509]  [<c104719c>] ? kthread+0x6c/0x80
  [    1.932509]  [<c1047130>] ? kthread_freezable_should_stop+0x50/0x5=
0
  [    1.932509]  [<c140f8f6>] ? kernel_thread_helper+0x6/0xd
  [    1.932509] ---[ end trace 7db6a26b2c0e9208 ]---


  [    2.106520] ------------[ cut here ]------------
  [    2.106520] WARNING: at drivers/ata/pata_acpi.c:149=20
pacpi_set_dmamode+0xc7/0xe0 [pata_acpi]()
  [    2.106520] Hardware name: Portable PC
  [    2.106520] pacpi_set_dmamode: ata_timing_find_mode gives NULL
  [    1.951725] ACPI: Invalid Power Resource to register!
  [    2.106520] Modules linked in: pata_acpi ata_generic
  [    2.106520] Pid: 863, comm: scsi_eh_1 Tainted: G        W=20
3.6.0-1-custom #1
  [    2.106520] Call Trace:
  [    2.106520]  [<c102cd28>] ? warn_slowpath_common+0x78/0xb0
  [    2.106520]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    2.106520]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    2.106520]  [<c102cdf3>] ? warn_slowpath_fmt+0x33/0x40
  [    2.106520]  [<ef77e2b7>] ? pacpi_set_dmamode+0xc7/0xe0 [pata_acpi=
]
  [    2.106520]  [<ef77e375>] ? pacpi_qc_issue+0x45/0x64 [pata_acpi]
  [    2.106520]  [<c126dfb2>] ? ata_qc_issue+0x152/0x320
  [    2.106520]  [<c11cda30>] ? acpi_os_release_object+0x5/0x8
  [    2.106520]  [<c10b0e7b>] ? __kmalloc+0x2b/0x130
  [    2.106520]  [<c126e3c9>] ? ata_exec_internal_sg+0x249/0x510
  [    2.106520]  [<c140d1bd>] ? schedule_timeout+0xed/0x170
  [    2.106520]  [<c11eaa87>] ? acpi_ut_delete_internal_obj+0x162/0x17=
2
  [    2.106520]  [<c126e6f2>] ? ata_exec_internal+0x62/0xa0
  [    2.106520]  [<c126e755>] ? ata_do_dev_read_id+0x25/0x30
  [    2.106520]  [<c126ea35>] ? ata_dev_read_id+0x245/0x560
  [    2.106520]  [<c127af72>] ? ata_eh_recover+0x762/0x1270
  [    2.106520]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    2.106520]  [<ef77e180>] ? pacpi_port_start+0x80/0x80 [pata_acpi]
  [    2.106520]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    2.106520]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    2.106520]  [<c127c490>] ? ata_do_eh+0x40/0xb0
  [    2.106520]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    2.106520]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    2.106520]  [<ef77e180>] ? pacpi_port_start+0x80/0x80 [pata_acpi]
  [    2.106520]  [<c127e210>] ? ata_sff_wait_after_reset+0x130/0x130
  [    2.106520]  [<c127ec77>] ? ata_sff_error_handler+0xb7/0x120
  [    2.106520]  [<c127dcb0>] ? ata_sff_drain_fifo+0x80/0x80
  [    2.106520]  [<c127bfc5>] ? ata_scsi_port_error_handler+0x495/0x86=
0
  [    2.106520]  [<c127ece0>] ? ata_sff_error_handler+0x120/0x120
  [    2.106520]  [<c127c413>] ? ata_scsi_error+0x83/0xc0
  [    2.106520]  [<c125533c>] ? scsi_error_handler+0x8c/0x470
  [    2.106520]  [<c104f6b4>] ? __wake_up_common+0x44/0x70
  [    2.106520]  [<c12552b0>] ? scsi_eh_get_sense+0xd0/0xd0
  [    2.106520]  [<c12552b0>] ? scsi_eh_get_sense+0xd0/0xd0
  [    2.106520]  [<c104719c>] ? kthread+0x6c/0x80
  [    2.106520]  [<c1047130>] ? kthread_freezable_should_stop+0x50/0x5=
0
  [    2.106520]  [<c140f8f6>] ? kernel_thread_helper+0x6/0xd
  [    2.106520] ---[ end trace 7db6a26b2c0e9209 ]---

