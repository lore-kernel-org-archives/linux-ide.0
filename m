From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/8] sata_sil24: fix on-memory structure byteorder
Date: Thu, 06 Apr 2006 12:46:51 -0400
Message-ID: <443545FB.2080300@pobox.com>
References: <11442437422203-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11192 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751275AbWDFQqy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:46:54 -0400
In-Reply-To: <11442437422203-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Data structures residing on memory and fetched by the controller
> should have LE ordering.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Do you have access to a big endian machine to test this?

	Jeff



