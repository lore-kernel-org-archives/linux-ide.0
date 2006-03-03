From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: convert dev->id to pointer
Date: Fri, 03 Mar 2006 17:31:16 -0500
Message-ID: <4408C3B4.40703@pobox.com>
References: <11411969753100-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:52886 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750753AbWCCWbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 17:31:18 -0500
In-Reply-To: <11411969753100-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert dev->id from array to pointer.  This is to accomodate
> revalidation.  During revalidation, both old and new IDENTIFY pages
> should be accessible and single ->id array doesn't cut it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-4


