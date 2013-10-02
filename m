From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] When a disk wakes up from sleep, ensure that the command =?utf-8?b?CWlz?= retried by SCSI EH.
Date: Wed, 2 Oct 2013 18:22:22 +0000 (UTC)
Message-ID: <loom.20131002T202103-937@post.gmane.org>
References: <4A7CB4D6.7020902@kernel.org>	 <1249687069-31011-1-git-send-email-gwendal@google.com>	 <4A7CB769.4040309@kernel.org> <v2ne7510f761004221043y4b92ab7csa96b5b45fb07ea6b@mail.gmail.com> <4BD08BFF.7070702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47173 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461Ab3JBSZE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Oct 2013 14:25:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1VRR6c-0005Rb-UN
	for linux-ide@vger.kernel.org; Wed, 02 Oct 2013 20:25:02 +0200
Received: from 216.239.45.93 ([216.239.45.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 02 Oct 2013 20:25:02 +0200
Received: from gwendal by 216.239.45.93 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 02 Oct 2013 20:25:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <tj <at> kernel.org> writes:

> 
> Hello,
> 
> On 04/22/2010 07:43 PM, Gwendal Grignou wrote:
> > Just looking into 2.6.33 code, and I did not find this patch. Is there
> > anything I should do to have it merge?
> 
> I think Jeff just hasn't come around yet.  Please wait a bit more for
> Jeff's "applied" mail.  If it doesn't happen in a week or so, pinging
> him again would be a good idea.
> 


Ping, years later! The patch still applies to 3.12.0-rc3.

Gwendal.

