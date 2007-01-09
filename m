From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: add suspend/resume support v3 (Resubmit)
Date: Tue, 09 Jan 2007 05:41:58 -0500
Message-ID: <45A37176.9050607@garzik.org>
References: <459C46C5.5050407@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33591 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbXAIKmA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:00 -0500
In-Reply-To: <459C46C5.5050407@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> Thoughts from Jeff & company on merging the patch below into libata-dev? 
> This has been in the -mm tree for over a month now, I haven't heard any 
> complaints about regressions..
> 
> ---
> 
> From: Robert Hancock <hancockr@shaw.ca>
> 
> This patch adds the necessary callbacks to support suspend/resume properly
> in sata_nv.  Most of the controllers don't need any specific handling but
> CK804/MCP04 controllers, whether ADMA is enabled or not, need some
> additional setup on resume.
> 
> As well as the additional storage of the controller type needed for proper
> resume handling, this also removes the inline helper functions for getting
> ADMA register locations by storing the pointers so we don't have to keep
> calculating them all the time.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

applied


