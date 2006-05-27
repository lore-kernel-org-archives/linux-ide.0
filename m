From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v3] libata resume fixes
Date: Sat, 27 May 2006 17:12:01 -0400
Message-ID: <4478C0A1.4050003@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527205213.GA30686@havoc.gtf.org> <4478BD18.6010908@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:13965 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964982AbWE0VL7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:11:59 -0400
In-Reply-To: <4478BD18.6010908@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, torvalds@osdl.org

The alt4_v3 patch from Jeff also still fails here.

The screen stays off for 30 seconds, then comes on,
but the error-recovery attempts do NOT appear in the syslog
as they did with the alt4_v2 patch.  The disk LED is still
stuck on, and the syslog shows only this, from early on:

qc timeout (cmd 0xe1)
do_simple_cmd: ata command failed: 4

I've got an errand to run now, but I'll be back again later.

Cheers
