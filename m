From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Please help me to understand the interaction of the various ATA
 drivers
Date: Thu, 30 Apr 2015 08:09:54 -0700
Message-ID: <20150430150954.GA26574@infradead.org>
References: <1430343517.30346.10.camel@afalanga4.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59074 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbbD3PJz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 11:09:55 -0400
Content-Disposition: inline
In-Reply-To: <1430343517.30346.10.camel@afalanga4.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andy Falanga (afalanga)" <afalanga@micron.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Why don't you just send your ATA taskfile as ATA_12 or ATA_16 CDB
through the device node ans save yourself all the work of writing a
driver?
