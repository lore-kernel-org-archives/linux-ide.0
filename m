From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC] ata_set_mode() to send SET FEATURES first
Date: Sat, 13 Nov 2004 20:23:51 -0500
Message-ID: <4196B3A7.1020303@pobox.com>
References: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261227AbUKNBYE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Nov 2004 20:24:04 -0500
In-Reply-To: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

I basically agree with Doug, but for a different reason.

If the hardware is setting an incorrect timing value, then the solution
is to disable that hardware feature, and manually set the timings.

	Jeff



