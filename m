From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
 side speed detection
Date: Thu, 24 Aug 2006 02:56:53 -0400
Message-ID: <44ED4DB5.10400@pobox.com>
References: <1156188229.18887.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31208 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030366AbWHXG44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2006 02:56:56 -0400
In-Reply-To: <1156188229.18887.56.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

ACK, but you need to split this up into core (#upstream) and PATA 
(#pata-drivers) patches.


