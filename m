From: Alan Cox <alan@redhat.com>
Subject: Re: IDE corruption datapoint
Date: Wed, 16 Jul 2003 08:47:48 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200307161247.h6GClmk07996@devserv.devel.redhat.com>
References: <20030716042020.780126b9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6921 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270709AbTGPMc7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jul 2003 08:32:59 -0400
In-Reply-To: <20030716042020.780126b9.davem@redhat.com> from "David S. Miller" at Gor 16, 2003 04:20:20 
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@redhat.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@redhat.com, linux-ide@vger.kernel.org, bcollins@debian.org

> FWIW, just like my alim5x3 based Sparcs, I have to boot with ide=nodma
> on my VAIO laptop which uses PIIX chipsets, otherwise I get data
> corruptions.

Ok thats I think a first ever and only report for the VAIO. Are you using
ACPI and what compiler are you using ? Do you have APIC support enabled ?
Does it occur with a vanilla Red Hat 2.4.20- kernel ?

> On the VAIO it shows up as corrupted kernel builds.  The build
> is successful but the images won't boot properly, rebuilding
> the same kernel tree with ide=nodma results in a working image.
> This shows up with both 2.4.21 and 2.4.22-current.

If you cp lots of data around then compare what is the error pattern,
thats basically essential info to debug this as is the drive data,
mode selected and so on

> This suggests, at least to me, that it's something generic in
> the IDE layer of 2.4.x vanilla vs. 2.6.0-test1 that's causing
> the problems, rather than a chipset specific issue.

That would be unlikely since someone found the ali problem with
sparc/alpha but just never bothered to send a patch to fix it.

Alan
