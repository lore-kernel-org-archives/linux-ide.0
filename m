From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: correct kernel parameter in documentation.
Date: Thu, 27 Sep 2007 12:03:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709271202210.13117@localhost.localdomain>
References: <20070927155013.GA20219@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nic.NetDirect.CA ([216.16.235.2]:58040 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbXI0QFD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 12:05:03 -0400
In-Reply-To: <20070927155013.GA20219@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>

On Thu, 27 Sep 2007, Dave Jones wrote:

> 'noacpi' isn't a standalone parameter, give it its prefix.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 4d175c7..a87bc58 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -863,6 +863,10 @@ and is between 256 and 4096 characters. It is defined in the file
>  	lasi=		[HW,SCSI] PARISC LASI driver for the 53c700 chip
>  			Format: addr:<io>,irq:<irq>
>
> +	libata.noacpi	[LIBATA] Disables use of ACPI in libata suspend/resume
> +			when set.
> +			Format: <int>
> +

if you're going to add that libata-related parm to the kernel parms
file, wouldn't it make sense for consistency to add the other
available boot-time parms from libata-core.c as well?  it seems
counter-productive to document only a subset of them from the same
source file.

rday

p.s.  as i think i've mentioned before, i'd prefer to see that entire
kernel-parameters.txt file reorganized, where the basic boot time
parms are at the top, followed by module specific parameters *after*
that, in alphabetical order by module name.  i think that would make
far more sense.

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
