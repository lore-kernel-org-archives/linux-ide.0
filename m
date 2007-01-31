From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/7] devres: device resource management
Date: Wed, 31 Jan 2007 06:50:20 -0500
Message-ID: <45C0827C.2050207@garzik.org>
References: <11692764264005-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56105 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933086AbXAaLuZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 06:50:25 -0500
In-Reply-To: <11692764264005-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement device resource management, in short, devres.  A device

ACK patches 1-7.  Applied patches 1-6 (with some remaining pata_platform 
damage) to #upstream.

Please examine the resulting damage, and resend patch #7, plus any 
missing bits

	Jeff



