From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/8] libata: move ata_set_mode() to libata-eh.c
Date: Sat, 01 Dec 2007 18:07:13 -0500
Message-ID: <4751E921.9060108@garzik.org>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593392856-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47197 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbXLAXHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 18:07:15 -0500
In-Reply-To: <11961593392856-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Tejun Heo wrote:
> Move ata_set_mode() to libata-eh.c.  ata_set_mode() is surely an EH
> action and will be more tightly coupled with the rest of error
> handling.  Move it to libata-eh.c.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Does this mean SET FEATURES - XFER MODE via SG_IO will be possible soon? 
  ;-)


