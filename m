From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Fw: [Bugme-new] [Bug 7958] New: AE_AML_PACKAGE_LIMIT is beyond
 end of object
Date: Wed, 7 Feb 2007 10:26:02 -0800
Message-ID: <20070207102602.43a00724.akpm@linux-foundation.org>
References: <20070207091034.76b76139.akpm@linux-foundation.org>
	<45CA18CE.7030300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <45CA18CE.7030300@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

On Wed, 07 Feb 2007 21:22:06 +0300 Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:

> Andrew,
> This bug seem to be duplicate of 7907, which in turn seem to be caused 
> by latest libata patches.

Oh.  Surprised.  Let's tell Jeff about it.

> Thanks,
>     Alex.
> Andrew Morton wrote:
> > This looks like something which needs attention prior to merging the new ACPI
> > code?
> >
> > Begin forwarded message:
> >
> > Date: Wed, 7 Feb 2007 04:57:01 -0800
> > From: bugme-daemon@bugzilla.kernel.org
> > To: bugme-new@lists.osdl.org
> > Subject: [Bugme-new] [Bug 7958] New: AE_AML_PACKAGE_LIMIT is beyond end of object
> >
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=7958
> >
> >            Summary: AE_AML_PACKAGE_LIMIT is beyond end of object
> >     Kernel Version: 2.6.20-rc6-mm3
> >             Status: NEW
> >           Severity: normal
> >              Owner: acpi_acpica-core@kernel-bugs.osdl.org
> >          Submitter: jirislaby@gmail.com
> >
> >
> > This occured in dmesg after hw suspend and resume:
> > Suspending device 0.0
> > ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (000000007) is beyon
> > d end of object [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTM_]
> > (Node dfe64fcc), AE_AML_PACKAGE_LIMIT
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0._
> > GTM] (Node dfe649f0), AE_AML_PACKAGE_LIMIT
> > ...
> > RESUME
> > ...
> > hda: selected mode 0x45
> > ACPI Error (dsopcode-0481): Attempt to CreateField of length zero [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA]
> > (Node dfe64ec8), AE_AML_OPERAND_VALUE
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.D
> > RV1._GTF] (Node dfe64964), AE_AML_OPERAND_VALUE
> > do_drive_get_GTF: Run _GTF error: status = 0x3006
> >
> > ------- You are receiving this mail because: -------
> > You are on the CC list for the bug, or are watching someone who is.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
