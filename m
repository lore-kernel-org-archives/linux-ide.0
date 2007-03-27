From: Jeff Garzik <jeff@garzik.org>
Subject: Re: HPA patches
Date: Tue, 27 Mar 2007 01:00:36 -0400
Message-ID: <4608A4F4.1010208@garzik.org>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk> <20070323205652.GA9965@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60824 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbXC0FAm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 01:00:42 -0400
In-Reply-To: <20070323205652.GA9965@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

Matthew Garrett wrote:
> On Fri, Mar 23, 2007 at 07:13:21PM +0000, Alan Cox wrote:
>> +static int ata_ignore_hpa = 0;
>> +module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
>> +MODULE_PARM_DESC(ignore_hpa, "Ignore HPA (0=off 1=on)");
> 
> I'm not sure I like the language here. "Ignore HPA" appears to mean 
> "Explicitly disable the HPA", which I guess is one interpretation of 
> "ignore" - however, naively I'd expect "Ignore HPA" to mean "Don't touch 
> the HPA" with the result that it would remain inaccessible to userspace.

"ignore" sounds more appropriate to me.

We're not just making it inaccessible, we are actively ignoring all 
traces of its existence everywhere, when that setting is enabled.

	Jeff



