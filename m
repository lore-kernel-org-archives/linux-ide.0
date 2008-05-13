From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: libata NCQ implementation questions
Date: Tue, 13 May 2008 11:25:41 +0200
Message-ID: <18473.24213.619836.176126@harpo.it.uu.se>
References: <18471.32504.953679.399689@harpo.it.uu.se>
	<482953F5.1020503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:34702 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbYEMJeO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 05:34:14 -0400
In-Reply-To: <482953F5.1020503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo writes:
...
 > > 4. What are these "internal commands" that map to ATA_TAG_INTERNAL?
 > >    Are they NCQ or not?
 > >    Does the existence of ATA_TAG_INTERNAL limit queue depth for NCQ?
 > 
 > Yeah, it reserves tag 31 for EH commands.  We might as well use tag 32 
 > for EH commands and let LLD map it to whatever tag it can use for EH 
 > commands but Jeff didn't like using all the tags as it makes 0xffffffff 
 > a valid status value.
 > 
 > Note that depending on LLD implementation, you might want to remap tag 
 > 31 to different hardware tag.  sata_sil24 does this mainly because it 
 > made polled execution implementation easier.

I think I'll remap them to 0 too. The tag ends up in a field
in the ATA packet header that's overloaded for NCQ tags and
non-NCQ packet "delay sequence ids". So far sata_promise has
always set this field to 0, and set up seqid #0 as /dev/null,
so I'm not comfortable allowing non-zero values into this field
for non-NCQ packets.

Thanks,

/Mikael
