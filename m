From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 8 Aug 2007 14:24:47 +0200
Message-ID: <200708081424.48382.rjw@sisk.pl>
References: <fa.bsWpbo79BZgHoaIGhEMfTEBxs54@ifi.uio.no> <200708072233.52500.rjw@sisk.pl> <46B930ED.6040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38435 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbXHHMPf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Aug 2007 08:15:35 -0400
In-Reply-To: <46B930ED.6040607@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Michael Sedkowski <sedmich@gmail.com>, trenn@suse.de, Robert Hancock <hancockr@shaw.ca>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, 8 August 2007 04:56, Tejun Heo wrote:
> Rafael J. Wysocki wrote:
> > Well, on my box (nx6325) with the appended (experimental) patch applied
> > on top of 2.6.23-rc1 with the patchset from
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc2/patches/ , the
> > double spin down doesn't occur during hibernation and the system is shut down
> > notceably faster.
> 
> Can you please explain what the patch does?

It replaces the shutting down of devices done by kernel_shutdown_prepare()
with the suspending of the (just like before entering S3, but the target state
is now S4) and the shutting down of sysdevs with suspending them.

It also disables the nonboot CPUs before entering the sleep state (S4), which
generally always is a good idea.

In short, it makes hibernation_platform_enter() execute the enter-a-sleep-state
sequence instead of the mixed shutdown-with-entering-S4 thing.

> So, I take it that entering S4 also spins down the disk.

Yes.

> Does the patch remove the ACPI spin down or libata one?

I _think_ that it removes the ACPI one, although I'll need to do some more
testing to confirm that.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
