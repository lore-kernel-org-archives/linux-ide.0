From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 16:14:10 -0400
Message-ID: <4478B312.5040901@garzik.org>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12688 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964958AbWE0UON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:14:13 -0400
In-Reply-To: <20060527201024.GA29015@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: liml@rtr.ca, torvalds@osdl.org

Jeff Garzik wrote:
> This fixes a bug in alt4 v1, by eliminating the second ata_set_mode()
> call, found in ata_device_resume().

This seems to make my x86-64 box happier...

	Jeff



