From: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 11:11:09 -0700
Message-ID: <20070319111109.1a62740b.kristen.c.accardi@intel.com>
References: <20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
	<20070319134822.GA4885@homac2.suse.de>
	<20070319140403.GA3697@srcf.ucam.org>
	<20070319143746.GC4885@homac2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070319143746.GC4885-tB0uoaAy/Z1bpigZmTR7Iw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Mon, 19 Mar 2007 15:37:46 +0100
Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org> wrote:

> Sure. What actually bothers me is that in its current state, the dock
> station driver signals 'green' on the dock station as soon as the user
> presses the hardware undock button, but regardlessly of anything else. I
> think it would be ok to let the ACPI undock event up to userspace because
> in many situations it knows best when it is save to undock.

I disagree - as I mentioned, not all laptops actually let you (userspace)
control the undock process because they don't lock.  The dock driver
does notify user space of an undock, before it actually undocks:

        /*
         * here we need to generate the undock
         * event prior to actually doing the undock
         * so that the device struct still exists.
         */
        dock_event(ds, event, UNDOCK_EVENT);
        hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
        undock(ds);
        eject_dock(ds);
 

We even notify other subsystems of our intent to undock prior to actually
doing it.  

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
