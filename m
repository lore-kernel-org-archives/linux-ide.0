From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug
 in cable detection
Date: Mon, 5 Feb 2007 11:28:45 +0000
Message-ID: <20070205112845.4fc6e80a@localhost.localdomain>
References: <20070205080128.GH1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59346 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932096AbXBELRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 06:17:11 -0500
In-Reply-To: <20070205080128.GH1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

On Mon, 5 Feb 2007 17:01:28 +0900
Tejun Heo <htejun@gmail.com> wrote:

> 80c test mask is at bits 18 and 19 of EIDE Controller Configuration
> not 22 and 23.  Fix it.

ACK - verified against data sheet.

Alan
