From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH][RFT] libata: fix use-after-free during driver unload/unplug
Date: Thu, 26 May 2005 22:00:42 -0400
Message-ID: <42967F4A.9030705@pobox.com>
References: <42962379.5000206@pobox.com> <42964099.6000207@pobox.com> <42967601.7080003@pobox.com> <429678B0.7000009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261334AbVE0CAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2005 22:00:50 -0400
In-Reply-To: <429678B0.7000009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Attached is the patch I committed, please test.

