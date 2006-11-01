From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] libata: implement ATA_EHI_PRINTINFO
Date: Tue, 31 Oct 2006 20:57:48 -0500
Message-ID: <4547FF1C.4090108@pobox.com>
References: <1161237098999-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7893 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946017AbWKAB5u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 20:57:50 -0500
In-Reply-To: <1161237098999-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ehi flag ATA_EHI_PRINTINFO.  This flag is set when device
> configuration needs to print out device info.  This used to be handled
> by @print_info argument to ata_dev_configure() but LLDs also need to
> know about it in ->dev_config() callback.
> 
> This patch replaces @print_info w/ ATA_EHI_PRINTINFO and make sata_sil
> print workaround messages only on the initial configuration.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 1-3.  I would apply them to #upstream, if I knew they would 
apply directly.  As it is, they are at least reviewed... :)


