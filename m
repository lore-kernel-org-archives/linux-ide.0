From: Andy Warner <andyw@pobox.com>
Subject: RFC: hotplug & libata.
Date: Fri, 15 Oct 2004 15:16:56 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041015151656.A26160@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:53411 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267653AbUJOUSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2004 16:18:41 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I've spent time over the last 10 days or so working
through hotplug issues with libata and am coming round
to the position that the current __init/probe mechanism
may need some reorganisation for hotplug to work well.

I can currently (mostly) hotplug SATA drives that were
present at __init/probe all day long; but things
are less good for drives which were not present
at __init/probe.

If it's not there at __init/probe time, the groundwork
isn't in place to add devices later without some fairly
nasty & repetitious code. I keep coming back to a model
where the host adapter ports are initialised, then the
initial drive scan & addition is effectively a hot-plug
event (either automatic or forced, depending on hardware
capabilities.)

Unfortunately, I fear that any impending PATA/libata
train-wreck may conflict with this, due to the behaviour
of some (many) of the PATA chipsets out there (e.g.
misbehaving seriously when no active devices are attached
to the bus etc.)

Anyone have thoughts/advice to share on this concept? I think
the re-org may be quite intrusive, and I don't want to waste
cycles on something that "would never work with PATA, because
of blah, blah, blah.."
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
