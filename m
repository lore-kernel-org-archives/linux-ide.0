From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SMART support for libata
Date: Thu, 09 Dec 2004 01:24:35 -0500
Message-ID: <41B7EFA3.8000007@pobox.com>
References: <87y8g8r4y6.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35725 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261464AbULIGYm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Dec 2004 01:24:42 -0500
In-Reply-To: <87y8g8r4y6.fsf@stark.xeocode.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Greg Stark wrote:
> I don't mean to be a pest, I'm just curious what the status is of SMART
> support for libata. It doesn't look like it's mentioned in any of the status
> updates. Did I miss it? Is it relatively low priority after the hardware
> support? Is anyone interested in working on it? What has to be done?

The code exists in libata-dev queue.  It's currently waiting on official 
  SCSI opcode assignments, and someone to add code to filter out SET 
FEATURES - XFER MODE commands.

	Jeff


