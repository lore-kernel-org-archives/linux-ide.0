From: Drew Winstel <raw@dslr.net>
Subject: Re: [SATA] libata-dev queue updated
Date: Sat, 04 Jun 2005 21:40:03 -0500
Message-ID: <1117939204.26775.3.camel@localhost>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	 <42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
	 <42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>
	 <20050604191958.GA13111@havoc.gtf.org>  <87k6l9k0aa.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dslreports.com ([209.123.192.187]:34704 "EHLO
	mail.dslr.net") by vger.kernel.org with ESMTP id S261437AbVFECjI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Jun 2005 22:39:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.dslr.net (Postfix) with ESMTP id B89DA42D3B
	for <linux-ide@vger.kernel.org>; Sat,  4 Jun 2005 22:38:56 -0400 (EDT)
Received: from mail.dslr.net ([127.0.0.1])
 by localhost (coral.dslreports.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12201-09 for <linux-ide@vger.kernel.org>;
 Sat,  4 Jun 2005 22:38:56 -0400 (EDT)
In-Reply-To: <87k6l9k0aa.fsf@stark.xeocode.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, James Bottomley <James.Bottomley@steeleye.com>

On Sat, 2005-06-04 at 22:25 -0400, Greg Stark wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > On Sat, Jun 04, 2005 at 03:15:24PM -0400, Greg Stark wrote:
> > > So my question is, if I did tackle this riddle trail and figured out how to
> > > fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
> > > just start working? Or would it just confuse the SMART tools until they're
> > > updated? Or would it just crash my machine?
> > 
> > SMART should just start working.  It adds the ioctls that existing smartd
> > and hdparm already know about.
> 
> So, uh, where do I get git? Where is your "git repository" and Linus' "git
> repository" and how do I set that up?
> 
> Or, at least, where do I find all this info?
> 
> 
Your best bet is probably to read Jeff's short git how-to at
http://kerneltrap.org/node/5196 and just about every other LKML-oriented
site.  Hopefully that gives you a good start.

Drew

