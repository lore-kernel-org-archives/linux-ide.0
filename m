From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/13] libata-hp: hook warmplug
Date: Tue, 30 May 2006 00:21:29 -0400
Message-ID: <447BC849.2060408@pobox.com>
References: <1148884736494-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21476 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751483AbWE3EVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 May 2006 00:21:41 -0400
In-Reply-To: <1148884736494-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hook transportt->user_scan() and hostt->slave_destroy().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 3-5


