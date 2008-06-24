From: Mark Lord <mlord@pobox.com>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 03:04:47 -0400
Message-ID: <48609C8F.90805@pobox.com>
References: <023701c8d4dd$d737fa10$85a7ee30$@com>
 <485F6830.1040000@pobox.com> <485F7356.5050605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFXHE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 03:04:59 -0400
In-Reply-To: <485F7356.5050605@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Milo Medin <medin@m2znetworks.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mark Lord wrote:
..
>> The 7042 is the best of the Marvell chips, for Linux.
> 
> How high does it go bandwidth-wise?
..

The limiting factor will be the bus width of the card
and the slot into which it is plugged, I suspect.

There are 4-lane PCIe cards out there, and one of those
in a 4-lane ("4X") or wider PCIe slot ought to have no
real limitations due to the 7042 side of things.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
