From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 17:12:01 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085181121.3266.6.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu
	 .	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibm
	r h9><40AE79E1.9020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:23998 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265081AbUEUXMJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:12:09 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id 31FC11DE2
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2004 17:12:09 -0600 (MDT)
In-Reply-To: <40AE79E1.9020005@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

For the record, ...

As of linux-2.6.6-bk8 plus my bk8.good.always.patch, ...

Commands that repeatably often DO complete rapidly include the
following.  Looks like we die only in Do < Ho (positive residue out) and
Dn = Hn (thin diagonal no data).

Anybody who can make time to learn USB jargon could start with the
Glossary at the end, the rest of you can delete the comments or indeed
all of this post and read only the jargon-free discussions of specific
trouble which follow.

Enjoy, Pat LaVarre


# Setup

export PLSCSI='/dev/sg0 -X time 5 0'

# Di == Hi // thin diagonal in

plscsi -i x24 -x "12 00:00:00 24 00" // "INQUIRY"
plscsi -i x800 -x "28 00 00:00:00:10 00 00:01 00" // "READ"
plscsi -i x20000 -x "28 00 00:00:00:00 00 00:40 00"

# Dn < Hi // max positive residue in

plscsi -i x24 -x "12 00:00:00 00 00"
plscsi -i x24 -x "00 00:00:00 00 00" // "TEST UNIT READY"
plscsi -i x800 -x "28 00 00:00:00:10 00 00:00 00"
plscsi -i x20000 -x "28 00 00:00:00:00 00 00:00 00"

# Di < Hi // positive residue in

plscsi -i xC0 -x "12 00:00:00 24 00"
plscsi -i x1000 -x "28 00 00:00:00:10 00 00:01 00"

# Do == Ho // thin diagonal out

plscsi -o x24 -x "3B 02 00:00:00:00 00 00:24 00" // optional "WRITE BUFFER"
plscsi -o x800 -x "2A 00 00:00:00:10 00 00:01 00" // "WRITE"
plscsi -o x20000 -x "2A 00 00:00:00:00 00 00:40 00"

# Dn < Ho // max positive residue out

plscsi -o x24 -x "00 00:00:00 00 00"
plscsi -o x800 -x "2A 00 00:00:00:10 00 00:00 00"
plscsi -o x20000 -x "2A 00 00:00:00:00 00 00:00 00"

# Glossary:

"The thirteen cases" are shown in the table:

http://images.google.com/images?q=Pat+LaVarre
http://members.aol.com/plscsi/20000125/13cases.gif

"The thirteen cases" are the thirteen commonly distinct combinations of:

Hn is an abbreviation for saying the Host expects to copy No data.
Hi is the nonzero count of data bytes the Host expects to copy In.
Ho is the nonzero count of data bytes the Host expects to copy Out.

Dn is an abbreviation for saying the Device actually agrees to copy No data.
Di is the nonzero count of data bytes the Device actually agrees to copy In.
Do is the nonzero count of data bytes the Device actually agrees to copy Out.


