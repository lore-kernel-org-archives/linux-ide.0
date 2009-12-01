From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 11:05:39 +1100
Message-ID: <1259625939.2076.159.camel@pasglop>
References: <1259561052.2076.73.camel@pasglop>
	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54520 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067AbZLAAGN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Nov 2009 19:06:13 -0500
In-Reply-To: <4B1459B5.40504@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 2009-12-01 at 08:48 +0900, Tejun Heo wrote:
> > One idea that comes to mind (I will try hacking something later
> today)
> > is to make ata_link_online() and ata_link_offline() use optional
> hooks
> > in the port ops so my driver can replace them instead of using the
> SATA
> > PHY stuff. Would that fly ?
> 
> Oh... yeah, that was the original intention when adding those
> functions but you wouldn't need them for hot plug/unplug.  Just set
> probe mask and freeze the port.  EH will do the right thing. 

Ok. I'll try that. Thanks.

Cheers,
Ben.


