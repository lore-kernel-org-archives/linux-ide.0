From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/6] Hibernation: Introduce new system state for the
 last phase of hibernation
Date: Fri, 3 Oct 2008 05:49:21 -0700
Message-ID: <20081003054921.376a41ec@infradead.org>
References: <200808290002.55026.rjw@sisk.pl>
	<200809300010.39000.rjw@sisk.pl>
	<20081003013557.42ce685d.akpm@linux-foundation.org>
	<200810031327.19293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200810031327.19293.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Fri, 3 Oct 2008 13:27:18 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 3 of October 2008, Andrew Morton wrote:
> > On Tue, 30 Sep 2008 00:10:37 +0200 "Rafael J. Wysocki"
> > <rjw@sisk.pl> wrote:
> > 
> > > Hibernation: Introduce new system state for the last phase of
> > > hibernation
> > > 
> > > Replace unused SYSTEM_SUSPEND_DISK with a new system_state value
> > > SYSTEM_HIBERNATE_ENTER that can be used by device drivers to
> > > check if the system is in the last phase of hibernation.
> > 
> > Violent objections.
> > 
> > We just don't know what this change will do.  It potentially affects
> > every code site in the kernel which looks at system_state.
> 
> Do you mean anyone checking 'system_state != SOMETHING' ?  Oh well.

I think Andrew also means things looking for system_state > something
like

arch/powerpc/platforms/cell/smp.c:      if (system_state < SYSTEM_RUNNING &&
arch/powerpc/kernel/smp.c:      if (system_state < SYSTEM_RUNNING)
arch/powerpc/kernel/smp.c:      if (system_state > SYSTEM_BOOTING)
drivers/xen/xenbus/xenbus_probe.c:      if (system_state > SYSTEM_RUNNING) {


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
