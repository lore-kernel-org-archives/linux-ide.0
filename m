From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Confused, libata NCQ supported or not?
Date: Sat, 08 Jan 2005 10:05:59 -0500
Message-ID: <41DFF6D7.60600@pobox.com>
References: <001701c4f569$27d8b020$9d02a8c0@southa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261184AbVAHPGT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jan 2005 10:06:19 -0500
In-Reply-To: <001701c4f569$27d8b020$9d02a8c0@southa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle Wong <kylewong@southa.com>
Cc: linux-ide@vger.kernel.org

Kyle Wong wrote:
> So .... does libata can do NCQ or not now?

The hardware status report describes the capabilities of the hardware.

The software status report describes the capabilities of the software.

So, as the software status report states, libata cannot do NCQ at the
present time.

	Jeff


