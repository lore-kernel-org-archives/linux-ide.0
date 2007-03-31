From: Craig Metz <cmetz@inner.net>
Subject: Linux libata, Sil3124, and SATA staggered spin-up support
Date: Sat, 31 Mar 2007 12:29:39 -0400
Message-ID: <20070331162941.93F61582C@rmail.inner.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rmail.inner.net ([199.33.248.12]:4031 "EHLO rmail.inner.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381AbXCaQiW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Mar 2007 12:38:22 -0400
Received: from inner.net (eng.inner.net [199.33.248.15])
	by rmail.inner.net (Postfix) with ESMTP id 93F61582C
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 11:29:41 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

  I have a Sil3124 controller and four drives, and I'm trying to build a
large JBOD file server (with three or four of those controller+drive sets).
One of the things I would need to be able to do in order to practically do
that is to have reasonable staggered spin-up; that is, I need to not have all
the drives try to start at once - it will put a lot of strain on any power
supply and require gross oversizing and/or separate supplies.

  Silicon Image claims to support staggered spin-up, but their BIOS appears
to do it in the pessimal manner - on boot, it simply spins up all drives at
once, and there are no settings I could find to change any of that behavior.
What I could find, though, is a way to simply erase the adapter's flash and 
thus disable the BIOS entirely.

  I was hoping that Linux would be able to do staggered spin-up itself in a
reasonable manner. And, if it doesn't today, I am hoping that is just a matter
of someone writing the code.

  I have done some digging in with the 2.6.20.3 libata code, and one thing I
have noticed that is specific to the Sil3124 driver is that the controller
init function starts up all the ports, which spins up all the drives. Does
anyone know if the Sil3124 hardware really supports the necessary things to do
staggered spin-up in a rational manner? I have done some digging and some
playing with the code, and from what I see, the controller likes to either
cause all the ports to come up (drives to spin up) or not.

  Is this something that folks would be willing to support in libata if
reasonable code existed? At some level, staggered spin-up should be done in
the BIOS. However, I expect that Sil3124 is far from the only controller whose
BIOS does it wrong but could be disabled. So I personally see value in having
Linux able to do it and do it right, but if you two don't and the patch would
never go in, then I would be wasting my time continuing to work on this.

  What is the right sequence of events for staggered spin-up? I was thinking
that the process should as a first cut happen iteratively/serially:

  Init controller
  Add controller to libata, get resources
  for each port
    Init port
    Add port to libata
    Tell SCSI layer to identify

  This is a different flow than what libata/Sil3124 currently does:

  Init controller
  for each port
    Init port
  Add controller to libata
  for each port
    More init port
    Add port to libata
  Get resources
  for each port 
    Tell SCSI layer to identify

  I am not an expert on libata, so I don't really understand the design
decisions that led to the current design. I would greatly appreciate it if
you had any suggestions or could give me additional clues about what the
right design should be to implement a feature like this along with everything
else libata needs to do.

  Thanks,

									-Craig
