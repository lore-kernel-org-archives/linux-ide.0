From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] S3C: ide: Add Samsung S3C IDE controller driver
Date: Sun, 01 Nov 2009 01:53:25 -0500
Message-ID: <4AED3065.6090808@garzik.org>
References: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45325 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbZKAGxZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2009 01:53:25 -0500
In-Reply-To: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-ide@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

On 11/01/2009 01:07 AM, Thomas Abraham wrote:
> This patch adds Samsung S3C IDE controller driver. This driver supports
> PIO and UDMA modes of data transfer.
>
> Note: This patch depends the following patch series.
> [PATCH 0/7] S3C64XX: Add platform support for Samsung S3C IDE controller driver
>
> Signed-off-by: Abhilash Kesavan<a.kesavan<at>  samsung.com>
> Signed-off-by: Thomas Abraham<thomas.ab<at>  samsung.com>

A libata driver would be nice, since we are trying to move away from 
old-IDE.

	Jeff




