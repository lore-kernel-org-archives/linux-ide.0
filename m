From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] libata-eh: update atapi_eh_request_sense()
 to take @dev instead of @qc
Date: Fri, 27 Jun 2008 02:41:14 -0400
Message-ID: <48648B8A.9000500@garzik.org>
References: <484E4925.30202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47278 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbYF0GlX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 02:41:23 -0400
In-Reply-To: <484E4925.30202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Update atapi_eh_request_sense() to take @dev, @sense_buf and
> @dfl_sense_key instead of taking @qc and extracting information from
> it.  This change is to make the function more generic and allow it to
> be called from other places.
> 
> While at it, make cdb initialization use initializer.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |   19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

applied


