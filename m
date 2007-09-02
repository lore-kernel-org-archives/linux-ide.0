From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH] drivers/firmware: const-ify DMI API and
 internals
Date: Sun, 2 Sep 2007 19:17:46 +0200
Message-ID: <20070902191746.6aa9fcae@hyperion.delvare>
References: <20070901142719.GA31990@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934279AbXIBRQt@vger.kernel.org>
In-Reply-To: <20070901142719.GA31990@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com, bzolnier@gmail.com, minyard@acm.org, rlove@rlove.org, dz@debian.org, Greg KH <greg@kroah.com>, stelian@popies.net, dmitry.torokhov@gmail.com, ibm-acpi@hmh.eng.br, ak@suse.de, lm-sensors@lm-sensors.org, linux-ide@vger.kernel.org, mzxreary@0pointer.de, j.w.r.degoede@hhs.nl, Andrew Morton <akpm@linux-foundation.org>, gimli@dark-green.com, ambx1@neo.rr.com
List-Id: linux-ide@vger.kernel.org

On Sat, 1 Sep 2007 10:27:19 -0400, Jeff Garzik wrote:
> 
> commit 457b6eb3bf3341d2e143518a0bb99ffbb8d754c4
> Author: Jeff Garzik <jeff@garzik.org>
> Date:   Sat Sep 1 10:16:45 2007 -0400
> 
>     drivers/firmware: const-ify DMI API and internals
>     
>     Three main sets of changes:
>     
>     1) dmi_get_system_info() return value should have been marked const,
>        since callers should not be changing that data.
>     
>     2) const-ify DMI internals, since DMI firmware tables should,
>        whenever possible, be marked const to ensure we never ever write to
>        that data area.
>     
>     3) const-ify DMI API, to enable marking tables const where possible
>        in low-level drivers.
>     
>     And if we're really lucky, this might enable some additional
>     optimizations on the part of the compiler.
>     
>     The bulk of the changes are #2 and #3, which are interrelated.  #1 could
>     have been a separate patch, but it was so small compared to the others,
>     it was easier to roll it into this changeset.
>     
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>

Looks alright to me, thanks Jeff.

-- 
Jean Delvare
