From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 14:34:51 +0000
Message-ID: <20051207143451.GB16938@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <58cb370e0512070626w735004afgf8cde34b8549fbdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751101AbVLGOe5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58cb370e0512070626w735004afgf8cde34b8549fbdc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 07, 2005 at 03:26:45PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/7/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > > Isn't ide-io.c:ide_{start,complete}_power_step() enough?
> 
> Why feeding device with ACPI taskfile(s) can't be added to
> the existing suspend/resume state machine (ide_*_power_step)?

Oh, I see what you mean. Yes, I guess it ought to be ok at that stage.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
