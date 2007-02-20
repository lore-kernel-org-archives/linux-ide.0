From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: add back some verbosity into ADMA error_handler
Date: Tue, 20 Feb 2007 10:52:29 -0500
Message-ID: <45DB193D.3070402@garzik.org>
References: <45CFB624.9020201@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44059 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965176AbXBTPwb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:52:31 -0500
In-Reply-To: <45CFB624.9020201@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Robert Hancock wrote:
> Some debug output in the ADMA error_handler function was removed recently,
> but it may be useful in certain cases, like NCQ commands timing out. Add it
> back in, but make it a bit more intelligent so that it only prints if
> command(s) are active and only prints the CPBs for those commands.
> That way it won't spew at inappropriate times like suspend/resume.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied


