From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] Hibernation: Introduce new system state for the last phase of hibernation
Date: Fri, 3 Oct 2008 17:05:10 +0200
Message-ID: <200810031705.11315.rjw@sisk.pl>
References: <200808290002.55026.rjw@sisk.pl> <200810031327.19293.rjw@sisk.pl> <20081003054921.376a41ec@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753835AbYJCPAz@vger.kernel.org>
In-Reply-To: <20081003054921.376a41ec@infradead.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>, Frans Pop <elendil@planet.nl>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Friday, 3 of October 2008, Arjan van de Ven wrote:
> On Fri, 3 Oct 2008 13:27:18 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Friday, 3 of October 2008, Andrew Morton wrote:
> > > On Tue, 30 Sep 2008 00:10:37 +0200 "Rafael J. Wysocki"
> > > <rjw@sisk.pl> wrote:
> > > 
> > > > Hibernation: Introduce new system state for the last phase of
> > > > hibernation
> > > > 
> > > > Replace unused SYSTEM_SUSPEND_DISK with a new system_state value
> > > > SYSTEM_HIBERNATE_ENTER that can be used by device drivers to
> > > > check if the system is in the last phase of hibernation.
> > > 
> > > Violent objections.
> > > 
> > > We just don't know what this change will do.  It potentially affects
> > > every code site in the kernel which looks at system_state.
> > 
> > Do you mean anyone checking 'system_state != SOMETHING' ?  Oh well.
> 
> I think Andrew also means things looking for system_state > something
> like
> 
> arch/powerpc/platforms/cell/smp.c:      if (system_state < SYSTEM_RUNNING &&
> arch/powerpc/kernel/smp.c:      if (system_state < SYSTEM_RUNNING)
> arch/powerpc/kernel/smp.c:      if (system_state > SYSTEM_BOOTING)
> drivers/xen/xenbus/xenbus_probe.c:      if (system_state > SYSTEM_RUNNING) {

These particular ones shouldn't be affected AFAICS.

Anyway, I'm going to respin the patchset to take the Andrew's comment into
account.
