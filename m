From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: ATA Passthru unimplemented protocols
Date: Wed, 27 Jul 2005 14:32:41 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D060A82@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:20536 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S262366AbVG0Vcn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 17:32:43 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Well it doesn't seem that nasty to adopt flagged access.  From a userland
API point of view how about adopting the IDE driver's taskfile mechanism,
and simply translating that into the yet-to-be internal flagged mechanism?

Tim



-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Wednesday, July 27, 2005 2:09 PM
To: Timothy Thelin
Cc: linux-ide@vger.kernel.org
Subject: Re: ATA Passthru unimplemented protocols


Timothy Thelin wrote:
> I'm interested in soft reset (1) and return response information (15).
But
> I didn't know who was doing what or had plans for what, which is why the
> question was so general.  If I end up working on these two myself, I'd be
> nice to  coordinate with existing efforts rather than collide with them =)

Certainly!  Your question was just a bit vague :)

The soft reset would be especially nice to have, but would require a bit 
of work to synchronize with other devices on the bus (needed for PATA 
only, really).

Another line item that I would like to see happen is "flagged 
taskfiles", which allows the user to specify which shadow registers to 
touch and -- more importantly -- which not to touch.  This is important 
for vendor-specific commands (particularly older PATA devices).

	Jeff



