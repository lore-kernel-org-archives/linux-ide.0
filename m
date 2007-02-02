From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 16:00:20 -0700
Message-ID: <311601c90702021500g74cd1241u43068cb81f0942a9@mail.gmail.com>
References: <20070202063748.GC1625@htj.dyndns.org> <45C33BCF.2040506@emc.com>
	 <45C354CF.1020500@gmail.com>
	 <20070202153929.33f4a806@localhost.localdomain>
	 <45C36338.60803@rtr.ca>
	 <311601c90702020843w16a67db8j5ead05f107161ec9@mail.gmail.com>
	 <20070202184743.1516d1f9@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:50748 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946120AbXBBXAV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 18:00:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so895365uga
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 15:00:20 -0800 (PST)
In-Reply-To: <20070202184743.1516d1f9@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 2/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> Is there a way to detect RAID drives with this kind of timing, or does
> someone need to take a baseball bat into the standards committee meeting
> and add an identify field that gives command and "long command" timeouts
> in seconds ?
>
> If we can detect the "fast fail" drives (initially by say ident string
> components) lets do it and the people who care can buy the right product
> for the job.

Like many new features in disk drives or other products, they're often
driven by a single or small set of large, paying customers to prove
them out prior to being standardized.  Given time, most eventually
settle on common interfaces to reduce costs.

This is a continuous process, the "concept -> development -> one
customer -> standard feature" path.  Unfortunately, you're right, it's
very difficult for individuals to interact with some of the standards
committees, and the exact working details (including detection) of
these features are often not made public for competitive reasons in
their initial offerings.

--eric
