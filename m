From: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 14:48:22 +0100
Message-ID: <20070319134822.GA4885@homac2.suse.de>
References: <200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070319132243.GA2869-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon 19. Mar - 13:22:43, Matthew Garrett wrote:
> On Sun, Mar 18, 2007 at 09:27:51AM +0100, Holger Macht wrote:
> 
> > I don't prefer any solution, whether doing it inside the kernel, or doing
> > it in userspace. What would be good would be to know what's the 'right'
> > way to go, or at least what both kernel people and userspace people can
> > agree on so that we can find a solution across distributions, whatever.
> > I'm currently just looking how to integrate the generic dock and bay
> > driver into the openSUSE distribution, and this seems to be quite hard,
> > especially because of the above mentioned already working solution ;-)
> 
> If the kernel knows that a bay device has just been added or removed, it 
> makes sense for the device removal to take place in the kernel rather 
> than bouncing it out to userspace and then back into the kernel. Pulling 
> out a cardbus card doesn't require us to run a userspace helper to 
> detach the hardware.

Yes, makes sense to me. So if this is the way to go, we would need two
things:

  1. libata integration into the bay driver
  2. The dock station driver has to inform the bay driver that an undock
     event took place, right?

But you still have to deal with mounted filesystems, no matter if it a
cardbus or a cdrom. Wouldn't we need something like 'save removal'
triggered from userspace like you maybe know from 'the other' operating
system?

Regards,
	Holger

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
