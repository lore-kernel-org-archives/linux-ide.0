From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/2] fastboot: Add a module parameter to skip probing of
 specific ports
Date: Tue, 12 Aug 2008 13:00:27 +0100
Message-ID: <20080812130027.2c4643a9@lxorguk.ukuu.org.uk>
References: <20080811153542.61095e5c@infradead.org>
	<20080811153641.706726ec@infradead.org>
	<20080812083903.6d402c2e@lxorguk.ukuu.org.uk>
	<20080812043603.3d8471d4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751892AbYHLMRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 08:17:36 -0400
In-Reply-To: <20080812043603.3d8471d4@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > What
> > defines the probe order here particularly as people are pushing for
> > parallel probing of multiple devices.
> 
> the patches I'm pushing for this don't change probe order; that has
> been tried before and wasn't a great success.

That was a question sorry. You are sledgehammering controllers by
discovery sequence - you've no idea if they will always be found in that
order. As such your boot option is incredibly fragile.
