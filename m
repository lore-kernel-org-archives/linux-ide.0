From: "David S. Miller" <davem@redhat.com>
Subject: Re: IDE corruption datapoint
Date: Wed, 16 Jul 2003 06:08:45 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030716060845.0e71a6e5.davem@redhat.com>
References: <20030716042020.780126b9.davem@redhat.com>
	<200307161247.h6GClmk07996@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pizda.ninka.net ([216.101.162.242]:35291 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270729AbTGPNDZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2003 09:03:25 -0400
In-Reply-To: <200307161247.h6GClmk07996@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, linux-ide@vger.kernel.org, bcollins@debian.org

On Wed, 16 Jul 2003 08:47:48 -0400 (EDT)
Alan Cox <alan@redhat.com> wrote:

> > FWIW, just like my alim5x3 based Sparcs, I have to boot with ide=nodma
> > on my VAIO laptop which uses PIIX chipsets, otherwise I get data
> > corruptions.
> 
> Ok thats I think a first ever and only report for the VAIO. Are you using
> ACPI and what compiler are you using ? Do you have APIC support enabled ?
> Does it occur with a vanilla Red Hat 2.4.20- kernel ?

No ACPI, stock compiler from RH8.0 with all updates installed:

gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)

CONFIG_X86_GOOD_APIC is enabled, but there is no IO-APIC in this
VAIO and /proc/interrupts shows all XT-PIC.

Does not occur with vanilla RH 2.4.20- kernel.

WRT. the VAIO, I originally suspected some of the DMI table changes
that went into 2.4.21, but I reverted that (and nearly all of the
other i386 specific 2.4.21 changes) to no avail.

> If you cp lots of data around then compare what is the error pattern,
> thats basically essential info to debug this as is the drive data,
> mode selected and so on

I'll do this at next opportunity.  It'll take a while since it
requires a whole kernel build in order to trigger the corruption
in the final linked image :(

I'll try using the disk bashing tools from feral.com to see if
that triggers anything easily.

> > This suggests, at least to me, that it's something generic in
> > the IDE layer of 2.4.x vanilla vs. 2.6.0-test1 that's causing
> > the problems, rather than a chipset specific issue.
> 
> That would be unlikely since someone found the ali problem with
> sparc/alpha but just never bothered to send a patch to fix it.

Interesting.  I've never seen any evidence from Ben or anyone else who
saw the problem on Sparc say much other than "2.6.0-test1 doesn't have
the problem, 2.4.x does"

Can you show the patch in question?  I guess it's in 2.6.0-test1
already?
