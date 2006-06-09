From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.17-rc5-mm3: oops when ejecting dock
Date: Thu, 08 Jun 2006 18:15:34 -0700
Message-ID: <4488CBB6.6040003@goop.org>
References: <4483EB38.30609@goop.org> <1149554579.6006.10.camel@whizzy>	 <4484D244.3010905@goop.org> <1149634494.13089.53.camel@whizzy>	 <44861109.7090502@goop.org> <1149639412.13089.85.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1149639412.13089.85.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Kristen Accardi wrote:
> To me it
> seems unwise to do anything outside the ide subsystem other than notify
> of an event and call some handler or something.
Sounds reasonable to me.

I presume what happens (or should happen?) is that pressing the "want to 
undock" button would send an event to acpid to unmount any filesystems, 
etc, and then once that had finishes you can pull the latch lever to 
actually disconnect the dock. Does that work at present?

I guess actually pulling the dock would cause PCI hot unplug events if 
there were actual PCI devices behind it.  I don't think the X60 dock 
does though.

    J


