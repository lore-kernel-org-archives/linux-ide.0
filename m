From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: More ATA corner cases
Date: Wed, 16 Aug 2006 18:55:55 -0400
Message-ID: <44E3A27B.2060806@pobox.com>
References: <1155731962.24077.346.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58511 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932315AbWHPWz7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2006 18:55:59 -0400
In-Reply-To: <1155731962.24077.346.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Any objection to me adding a new cable type for "40 wire ATA66 capable"
> to indicate the laptop vendor has been sneaky and we should do full UDMA
> ranges regardless of drive or other controller reporting.

No initial objections, but of course need to see the patch :)

	Jeff



