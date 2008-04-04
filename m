From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: uninline atapi_cmd_type()
Date: Fri, 04 Apr 2008 02:47:25 -0400
Message-ID: <47F5CEFD.8030100@garzik.org>
References: <47F343BE.4030103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55816 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbYDDGr0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:47:26 -0400
In-Reply-To: <47F343BE.4030103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Uninline atapi_cmd_type().  It doesn't really have to be inline and
> more case will be added which need to access unexported libata
> variable.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied 1-2

