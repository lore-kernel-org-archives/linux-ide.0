From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Thu, 30 Mar 2006 16:59:07 -0500
Message-ID: <442C54AB.2040306@pobox.com>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com> <20060325054008.GG5288@htj.dyndns.org> <20060325061215.GH5288@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58276 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751021AbWC3V7R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 16:59:17 -0500
In-Reply-To: <20060325061215.GH5288@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch renames ata_dev_present() to ata_dev_enabled() and adds
> ata_dev_disabled().  This is to discern the state where a device is
> present but disabled from not-present state.  This disctinction is
> necessary when configuring transfer mode because device selection
> timing must not be violated even if a device fails to configure.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 1-2.  can you please rediff against current #upstream and 
resend?

	Jeff



