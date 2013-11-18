From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/3] sd: don't bother spinning up disks on resume
Date: Sun, 17 Nov 2013 16:09:28 -0800
Message-ID: <1384733368.2050.18.camel@dabdike.int.hansenpartnership.com>
References: <527AF287.7020700@ubuntu.com>
			 <927e15641f27b46f206f8ae8110201c8fd77b7e1.1383789225.git.psusi@ubuntu.com>
			 <527BDA11.6060603@interlog.com> <527C0349.5010301@ubuntu.com>
		 <1384626031.3614.7.camel@dabdike.int.hansenpartnership.com>
		 <52883CE9.9040102@ubuntu.com>
	 <1384670620.3614.24.camel@dabdike.int.hansenpartnership.com>
	 <5288EBA6.3070609@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55034 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750Ab3KRAJf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Nov 2013 19:09:35 -0500
In-Reply-To: <5288EBA6.3070609@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: dgilbert@interlog.com, todd.e.brandt@linux.intel.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org

On Sun, 2013-11-17 at 11:15 -0500, Phillip Susi wrote:
> On 11/17/2013 01:43 AM, James Bottomley wrote:
> > OK, so three people have now told you that's not how the code
> > works. Why don't you just read it?  because there's not really much
> > point us reading your patches until you do.
> 
> I have, which is why I said it handles it via scsi_eh_stu.  If I'm not
> understanding it correctly, then by all means, explain.

Because you don't damn well listen.  Two emails ago I said:

        The error handler is not automatically activated for a not
        ready/initializing command required because of multi-path

I don't really understand how I can be clearer.  You keep wittering
about the error handler spin up but if the error handler doesn't
activate, the disk is never spun up with your patch.  This is the
problem we keep telling you about.  You can't make the error handler
always activate because then multi-path would fail.

James


