From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Mon, 27 Mar 2006 12:17:37 +0100
Message-ID: <1143458257.4970.18.camel@localhost.localdomain>
References: <11431815313764-git-send-email-htejun@gmail.com>
	 <44240A67.7030001@pobox.com>
	 <1143215493.18986.11.camel@localhost.localdomain>
	 <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com>
	 <20060325054008.GG5288@htj.dyndns.org>
	 <20060325061215.GH5288@htj.dyndns.org>
	 <1143330895.28134.14.camel@localhost.localdomain>
	 <20060325235732.GA23222@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:173 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750910AbWC0Lwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 06:52:46 -0500
In-Reply-To: <20060325235732.GA23222@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sul, 2006-03-26 at 08:57 +0900, Tejun Heo wrote:
> Can you elaborate how ata_dev_pair() is broken by this patch?
> ata_dev_present() is simply renamed to ata_dev_enabled().
> ata_dev_disabled() only differenciates the conditions where
> ata_dev_present() used to think there was no device.  There should be
> no behavior change to existing code. 

Some of the drivers want one sematic some want the other, and
ata_dev_pair is now confusing. Needs a pair of better names and I'm not
sure what they should be

