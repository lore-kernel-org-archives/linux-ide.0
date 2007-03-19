From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 11:00:42 -0700
Message-ID: <20070319110042.33eb7126.kristen.c.accardi@intel.com>
References: <20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
	<20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
	<45FCD062.3050001@gmail.com>
	<20070318082751.GA28591@homac2>
	<20070319132243.GA2869@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7156 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030455AbXCSSDL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 14:03:11 -0400
In-Reply-To: <20070319132243.GA2869@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

On Mon, 19 Mar 2007 13:22:43 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

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
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org
> 

Not to mention, with dock stations some laptops don't actually lock the
laptop into the dock station, so when the user decides to press the button
and undock, it just does it instantly.  And same with some bay devices - 
they don't actually give you an event until the bay is physically removed.
Because of this, I think we should handle things in kernel space.
