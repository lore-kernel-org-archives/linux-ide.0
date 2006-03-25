From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled, disabled and present()
Date: Fri, 24 Mar 2006 22:50:55 -0500
Message-ID: <4424BE1F.7090305@pobox.com>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325005305.GD5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50837 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750750AbWCYDvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 22:51:03 -0500
In-Reply-To: <20060325005305.GD5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch renames ata_dev_present() to ata_dev_enabled() and adds
> ata_dev_disabled() and ata_dev_present().  This is to discern the
> state where a device is present but disabled from not-present state.
> This disctinction is necessary when configuring transfer mode because
> device selection timing must not be violated even if a device fails to
> configures.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

OK in general, but NAK for transition reasons:  this invites silent 
breakage of code not yet in #upstream, because ata_dev_present() 
implementation changes but the function signature does not.  If a new 
ata_dev_present() is to be introduced, either a different name should be 
chosen, or the function signature should change such that an older user 
of the API will see a compiler warning or error.

	Jeff



