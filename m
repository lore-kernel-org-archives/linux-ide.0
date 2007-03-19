From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 12:36:59 -0300
Message-ID: <20070319153659.GB15942@khazad-dum.debian.net>
References: <20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
	<20070319134822.GA4885@homac2.suse.de>
	<20070319140403.GA3697@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070319140403.GA3697-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
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
Cc: Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 19 Mar 2007, Matthew Garrett wrote:
> > But you still have to deal with mounted filesystems, no matter if it a
> > cardbus or a cdrom. Wouldn't we need something like 'save removal'
> > triggered from userspace like you maybe know from 'the other' operating
> > system?
> 
> Yes, there's a need for a mechanism to deal with all of this safely, but 
> the same is true of any storage device that can be hotplugged (USB, 
> firewire, anything in a hotplug bay...)

True.  The best available procedure to do this for ACPI bay/dock currently
is, AFAIK:

1. Send event when bay/dock "please release" button/lever is pressed. Do
*nothing* else.  I know bay does this right, maybe dock doesn't.

2. Wait for something to echo 1 >eject or to call the appropriate routine
directly, or (if this exists) for an notification from firmware that the
user IS disconnecting the device for real.

3. delete the device.  This means force-umount, force-close, etc.

4. Tell the hardware to eject.


Note that currently (2) and (3) are swapped, as (3) is being done by
userspace request, instead of by the kernel.  This is something I *don't*
like.  IMO should do as PCMCIA and hotplug PCI does, and do that in kernel
space.

The time window where one can ask the user something or notify it is not a
good idea to eject is between (1) and (2).  If the eject command is issued,
delete devices (includes sync, of course) and eject.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
