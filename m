From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 7/9] libata-acpi: improve _GTF execution error handling
 and reporting
Date: Fri, 14 Dec 2007 09:12:10 -0500
Message-ID: <47628F3A.1060806@rtr.ca>
References: <11976129411285-git-send-email-htejun@gmail.com> <11976129433239-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1572 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbXLNOMM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Dec 2007 09:12:12 -0500
In-Reply-To: <11976129433239-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> As _GTF commands can't transfer data, device error never signals
> transfer error.  It indicates that the device vetoed the operation, so
> it's meaningless to retry.
..

The SECURITY commands may pass a data block to the drive,
containing the password required to unlock/freeze a drive.
I suspect ACPI on many machines will issue such a command,
and it does indeed transfer data (512 bytes).

????
