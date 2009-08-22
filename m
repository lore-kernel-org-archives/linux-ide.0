From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
 non-ATAPI data commands
Date: Sat, 22 Aug 2009 12:02:29 -0400
Message-ID: <4A901695.6040708@garzik.org>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com> <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org> <4A900DE6.2020802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34626 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932771AbZHVQCc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 12:02:32 -0400
In-Reply-To: <4A900DE6.2020802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Robert Hancock <hancockrwd@gmail.com>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 08/22/2009 11:25 AM, Mark Lord wrote:
> Whatever. It's very well tested (and in continuous use) here on two systems
> with siI-3132 controllers. So we'll want to hear from users of the 3124
> and 3131/3531 chips for completeness, then.


Given that (a) Silicon Image's driver and the Other OS do not default to 
this data path, and (b) your mix of opcodes and workloads is inevitably 
different from others in the field, it is more than just completeness.

It is entirely possible that this sata_sil24 core data path change has 
never seen mass testing, ever.  So, the validation level needs to be 
higher than "it works for Mark" :)

	Jeff


