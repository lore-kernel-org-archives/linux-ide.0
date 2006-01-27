From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/5] libata: move cdb_len for host to device
Date: Thu, 26 Jan 2006 23:36:57 -0500
Message-ID: <43D9A369.3090402@pobox.com>
References: <11382890433660-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:30650 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932283AbWA0EhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 23:37:02 -0500
In-Reply-To: <11382890433660-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> cdb_len is per-device property.  Sharing cdb_len on ap results in
> inaccurate configuration on revalidation and hotplugging.  This patch
> makes cdb_len per-device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 3-5, but not applied due to previous 2 patches not being applied


