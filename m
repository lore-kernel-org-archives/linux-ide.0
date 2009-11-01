From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] S3C: ide: Add Samsung S3C IDE controller driver
Date: Sun, 1 Nov 2009 12:34:34 +0000
Message-ID: <20091101123434.245b4d84@lxorguk.ukuu.org.uk>
References: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39306 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752037AbZKAMdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 07:33:15 -0500
In-Reply-To: <1257052029-8406-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, Thomas Abraham <thomas.ab@samsung.com>

On Sun,  1 Nov 2009 14:07:09 +0900
Thomas Abraham <thomas.ab@samsung.com> wrote:

> This patch adds Samsung S3C IDE controller driver. This driver supports
> PIO and UDMA modes of data transfer.

drivers/ide is old code in maintenance mode only. New drivers should be
using libata.
