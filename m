From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA hotplug status (sii3114)
Date: Fri, 14 Jan 2005 17:28:29 -0500
Message-ID: <41E8478D.3070305@pobox.com>
References: <41E8292A.40302@dot21rts.com> <41E84305.5070202@pobox.com> <41E84753.4040003@dot21rts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13523 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262212AbVANW2w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Jan 2005 17:28:52 -0500
In-Reply-To: <41E84753.4040003@dot21rts.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Helten <andy.helten@dot21rts.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Andy Helten wrote:
> Can you share the plan with me (pdf, email archive, or web page)?  I've 
> been tasked with adding hotplug support for the system I mention in my 
> original email.  Soooo, it is really just a matter of whether it will be 
> a custom hack job or something more generic that could benefit more people.


<shrug>  Just "use SCSI infrastructure such as 
scsi_{add,remove}_device() to facilitate hotplug"

	Jeff


