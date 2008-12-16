From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix Seagate NCQ+FLUSH blacklist
Date: Tue, 16 Dec 2008 05:41:25 -0500
Message-ID: <494785D5.9060802@garzik.org>
References: <49409A42.7090305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45986 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYLPKl2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Dec 2008 05:41:28 -0500
In-Reply-To: <49409A42.7090305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Tejun Heo wrote:
> Due to miscommunication, P/N was mistaken as firmware revision
> strings.  Update it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> This is ugly but the fixed revision is SD1A, so we either need to
> write custom match for these drives or make our pattern matching
> smarter to make the list shorter.  For #upstream-fixes and -stable
> go with the dumb approach.  :-(
> 
>  drivers/ata/libata-core.c |   65 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 6 deletions(-)

applied


