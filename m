From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 11:36:42 +0000
Message-ID: <20090105113642.19679726@lxorguk.ukuu.org.uk>
References: <49615667.9020408@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37389 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751619AbZAELgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 06:36:36 -0500
In-Reply-To: <49615667.9020408@iwl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Auerbach <karl@iwl.com>
Cc: linux-ide@vger.kernel.org, karl@cavebear.com

> 2. The cs5535 ide driver doesn't seem to be able to recognize the
> newer CS5536 controller for IDE.

Switch to libata as most distributions have already done and enable the
pata_cs5536 driver, which is designed for this hardware.

Alan
