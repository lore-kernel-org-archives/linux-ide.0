From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/5] libata: improve EH internal command timeout handling
Date: Mon, 19 May 2008 14:51:47 -0400
Message-ID: <4831CC43.3040806@garzik.org>
References: <12112174741373-git-send-email-htejun@gmail.com>	<12112174751449-git-send-email-htejun@gmail.com> <20080519193506.6811bdb3@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45995 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbYESSvu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 14:51:50 -0400
In-Reply-To: <20080519193506.6811bdb3@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, liml@rtr.ca

Alan Cox wrote:
>> IDENTIFYs use 5s - 10s - 30s timeout and all other commands use 5s -
>> 10s timeouts.
> 
> Cache flushes need more but they now come via the libata-scsi code right ?

via scsi layer via libata-scsi, yes.  Kernel issues flush, SCSI 
translates to SYNC CACHE, libata-scsi translates to FLUSH CACHE.

We don't issue flushes outside of that code path (except SG_IO I suppose)

	Jeff



