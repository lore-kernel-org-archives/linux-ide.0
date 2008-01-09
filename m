From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 1/2] [libata] sata_mv: Remove PCI dependency
Date: Wed, 9 Jan 2008 13:59:11 +0200
Message-ID: <c70ff3ad0801090359n669471fap45b67228ded564a5@mail.gmail.com>
References: <11966101971581-git-send-email-saeed.bishara@gmail.com>
	 <1196610199229-git-send-email-saeed.bishara@gmail.com>
	 <47684270.5030405@garzik.org>
	 <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:20079 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYAIL7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 06:59:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so368306wah.23
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 03:59:11 -0800 (PST)
In-Reply-To: <c70ff3ad0712250842n5c5383b1x2f53406fbf34dfb5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Mark Lord <liml@rtr.ca>

> Here is the updated patch according your comments:
> From af124a0fd4984db4fbc8638e0af4e6a41561588d Mon Sep 17 00:00:00 2001
> From: Saeed Bishara <saeed@marvell.com>
> Date: Sun, 2 Dec 2007 10:43:10 +0200
> Subject: [PATCH] sata_mv: Remove PCI dependency
>
> The integrated SATA controller is connected directly to the SoC's
> internal bus, not via PCI interface. this patch removes the dependency
> on the PCI interface.
guys, any other comments for this patch?
